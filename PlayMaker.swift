//
//  PlayMaker.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SpriteKit
import SwiftUI

struct SavedPlay: Identifiable {
    let id = UUID()
    let name: String
    let frames: [BasketballGameScene.Frame]
    let defenseType: BasketballGameScene.DefenseType
}

class BasketballGameScene: SKScene {

    let offenseColor = SKColor.blue
    let defenseColor = SKColor.red
    let ballColor = SKColor.orange

    var players: [SKShapeNode] = []
    var defenders: [SKShapeNode] = []
    var ball = SKShapeNode(circleOfRadius: 12)
    var hoop = SKShapeNode(circleOfRadius: 15)

    var selectedPlayer: SKShapeNode?
    var initialPositions: [CGPoint] = []

    // TOUCH CONTROL
    var touchStartLocation: CGPoint?
    var didDrag = false

    // RESULT UI
    var resultLabel = SKLabelNode(text: "")

    // SAVED PLAYS
    static var savedPlays: [SavedPlay] = []

    // MARK: - RECORDING
    struct Frame {
        let time: TimeInterval
        let playerPositions: [CGPoint]
        let ballPosition: CGPoint
    }

    var frames: [Frame] = []
    var recordStartTime: TimeInterval = 0
    var isRecording = true

    // MARK: - DEFENSE
    enum DefenseType: CaseIterable {
        case man, zone23, zone32
    }

    var currentDefense: DefenseType = .man

    // MARK: - SETUP
    override func didMove(to view: SKView) {
        backgroundColor = .white

        drawCourt()
        createPlayers()
        createDefense()
        createBall()
        createUI()

        startRecording()
    }

    func drawCourt() {
        let court = SKShapeNode(rectOf: CGSize(width: 350, height: 500))
        court.strokeColor = .black
        court.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(court)

        hoop.strokeColor = .orange
        hoop.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(hoop)
    }

    func createPlayers() {
        let positions = [
            CGPoint(x: frame.midX - 100, y: 250),
            CGPoint(x: frame.midX + 100, y: 250),
            CGPoint(x: frame.midX, y: 350),
            CGPoint(x: frame.midX - 80, y: 450),
            CGPoint(x: frame.midX + 80, y: 450)
        ]

        initialPositions = positions

        for (i, pos) in positions.enumerated() {
            let p = SKShapeNode(circleOfRadius: 20)
            p.fillColor = offenseColor
            p.position = pos
            p.name = "player_\(i)"
            addChild(p)
            players.append(p)
        }
    }

    func createDefense() {
        defenders.forEach { $0.removeFromParent() }
        defenders.removeAll()

        let cx = frame.midX
        let topY = frame.midY + 120
        let lowY = frame.midY - 120

        switch currentDefense {

        case .man:
            for p in players {
                let d = makeDefender()
                d.position = CGPoint(x: p.position.x, y: p.position.y + 60)
                addChild(d)
                defenders.append(d)
            }

        case .zone23:
            let positions = [
                CGPoint(x: cx - 80, y: topY),
                CGPoint(x: cx + 80, y: topY),
                CGPoint(x: cx - 100, y: lowY),
                CGPoint(x: cx, y: lowY),
                CGPoint(x: cx + 100, y: lowY)
            ]
            positions.forEach { addDefender($0) }

        case .zone32:
            let positions = [
                CGPoint(x: cx - 100, y: topY),
                CGPoint(x: cx, y: topY),
                CGPoint(x: cx + 100, y: topY),
                CGPoint(x: cx - 60, y: lowY),
                CGPoint(x: cx + 60, y: lowY)
            ]
            positions.forEach { addDefender($0) }
        }
    }

    func makeDefender() -> SKShapeNode {
        let d = SKShapeNode(circleOfRadius: 20)
        d.fillColor = defenseColor
        return d
    }

    func addDefender(_ pos: CGPoint) {
        let d = makeDefender()
        d.position = pos
        addChild(d)
        defenders.append(d)
    }

    func createBall() {
        ball.fillColor = ballColor
        ball.position = players[2].position
        addChild(ball)
    }

    // MARK: - PASS
    func passBall(to player: SKShapeNode) {
        ball.run(SKAction.move(to: player.position, duration: 0.25))
    }

    // MARK: - SHOOT
    func shootBall() {
        guard let shooter = selectedPlayer ?? players.first else { return }

        ball.removeAllActions()

        let action = SKAction.move(to: hoop.position, duration: 0.4)

        ball.run(action) {
            let (made, percent) = self.calculateShotSuccess(from: shooter)

            if made {
                self.resultLabel.text = "✅ MADE (\(Int(percent * 100))%)"
                self.resultLabel.fontColor = .systemGreen
            } else {
                self.resultLabel.text = "❌ MISS (\(Int(percent * 100))%)"
                self.resultLabel.fontColor = .systemRed
            }
        }
    }

    func calculateShotSuccess(from shooter: SKShapeNode) -> (Bool, CGFloat) {

        let distance = hypot(
            shooter.position.x - hoop.position.x,
            shooter.position.y - hoop.position.y
        )

        var successRate: CGFloat = 0.85

        let distancePenalty = min(distance / 900, 0.35)
        successRate -= distancePenalty

        let nearest = defenders.map {
            hypot($0.position.x - shooter.position.x,
                  $0.position.y - shooter.position.y)
        }.min() ?? 999

        if nearest < 60 {
            successRate -= 0.30
        } else if nearest < 120 {
            successRate -= 0.18
        } else if nearest < 180 {
            successRate -= 0.08
        }

        switch currentDefense {
        case .man:
            successRate -= 0.04
        case .zone23:
            successRate -= 0.06
        case .zone32:
            successRate -= 0.08
        }

        successRate = max(0.15, min(0.95, successRate))

        return (CGFloat.random(in: 0...1) < successRate, successRate)
    }

    // MARK: - RECORD
    func startRecording() {
        frames.removeAll()
        recordStartTime = 0
        isRecording = true
    }

    override func update(_ currentTime: TimeInterval) {

        guard isRecording else { return }

        if recordStartTime == 0 {
            recordStartTime = currentTime
        }

        frames.append(Frame(
            time: currentTime - recordStartTime,
            playerPositions: players.map { $0.position },
            ballPosition: ball.position
        ))
    }

    // MARK: - SAVE PLAY
    func saveCurrentPlay() {

        let playNumber = BasketballGameScene.savedPlays.count + 1

        let newPlay = SavedPlay(
            name: "Play \(playNumber)",
            frames: frames,
            defenseType: currentDefense
        )

        BasketballGameScene.savedPlays.append(newPlay)

        resultLabel.text = "💾 Saved Play \(playNumber)"
        resultLabel.fontColor = .systemBlue
    }
    // MARK: - SIMULATE
    func simulatePlay() {

        isRecording = false
        ball.removeAllActions()

        for (i, p) in players.enumerated() {
            p.position = initialPositions[i]
        }

        ball.position = players[2].position
        createDefense()

        guard frames.count > 1 else { return }

        var actions: [SKAction] = []

        for i in 1..<frames.count {

            let prev = frames[i - 1]
            let curr = frames[i]
            let duration = max(0.02, curr.time - prev.time)

            let step = SKAction.run {

                for (index, pos) in curr.playerPositions.enumerated() {
                    self.players[index].position = pos
                }

                self.ball.position = curr.ballPosition
            }

            actions.append(step)
            actions.append(SKAction.wait(forDuration: duration))
        }

        run(SKAction.sequence(actions))
    }

    // MARK: - RESET
    func resetPlay() {
        ball.removeAllActions()

        for (i, p) in players.enumerated() {
            p.position = initialPositions[i]
        }

        ball.position = players[2].position
        createDefense()

        resultLabel.text = ""
        startRecording()
    }

    // MARK: - UI
    func createUI() {

        // Better spacing for iPhone screens
        let buttons: [(String, CGFloat, String)] = [
            ("SHOOT", -140, "shoot"),
            ("SIM", -70, "sim"),
            ("RESET", 0, "reset"),
            ("DEF", 70, "defense"),
            ("SAVE", 140, "save")
        ]

        for (title, x, name) in buttons {
            makeButton(title, x: x, name: name)
        }

        resultLabel.fontName = "AvenirNext-Bold"
        resultLabel.fontSize = 17
        resultLabel.fontColor = .black
        resultLabel.position = CGPoint(
            x: frame.midX,
            y: frame.minY + 95
        )

        addChild(resultLabel)
    }

    func makeButton(_ text: String, x: CGFloat, name: String) {

        // SHADOW
        let shadow = SKShapeNode(
            rectOf: CGSize(width: 58, height: 34),
            cornerRadius: 9
        )

        shadow.fillColor = SKColor.black.withAlphaComponent(0.15)
        shadow.strokeColor = .clear

        shadow.position = CGPoint(
            x: frame.midX + x + 1.5,
            y: frame.minY + 53
        )

        addChild(shadow)

        // BUTTON
        let button = SKShapeNode(
            rectOf: CGSize(width: 58, height: 34),
            cornerRadius: 9
        )

        button.fillColor = SKColor(
            red: 0.16,
            green: 0.16,
            blue: 0.18,
            alpha: 1
        )

        button.strokeColor = SKColor(
            red: 0.30,
            green: 0.30,
            blue: 0.34,
            alpha: 1
        )

        button.lineWidth = 1.8

        button.position = CGPoint(
            x: frame.midX + x,
            y: frame.minY + 55
        )

        button.name = name

        addChild(button)

        // LABEL
        let label = SKLabelNode(fontNamed: "AvenirNext-Bold")

        label.text = text
        label.fontSize = 10
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: -1)

        button.addChild(label)
    }
    // MARK: - TOUCH
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let t = touches.first else { return }
        let loc = t.location(in: self)

        touchStartLocation = loc
        didDrag = false

        for node in nodes(at: loc) {

            if node.name == "shoot" {
                shootBall()
                return
            }

            if node.name == "sim" {
                simulatePlay()
                return
            }

            if node.name == "reset" {
                resetPlay()
                return
            }

            if node.name == "defense" {
                cycleDefense()
                return
            }

            if node.name == "save" {
                saveCurrentPlay()
                return
            }

            if let p = node as? SKShapeNode,
               node.name?.contains("player") == true {

                selectedPlayer = p
                return
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let t = touches.first,
              let start = touchStartLocation,
              let p = selectedPlayer else { return }

        let current = t.location(in: self)

        if hypot(current.x - start.x, current.y - start.y) > 10 {
            didDrag = true
        }

        if didDrag {
            p.position = current
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let p = selectedPlayer else { return }

        if didDrag == false {
            passBall(to: p)
        }

        selectedPlayer = nil
    }

    func cycleDefense() {
        let all = DefenseType.allCases
        if let index = all.firstIndex(of: currentDefense) {
            currentDefense = all[(index + 1) % all.count]
        }
        createDefense()
    }
}

