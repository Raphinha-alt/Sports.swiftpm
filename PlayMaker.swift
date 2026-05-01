//
//  PlayMaker.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SpriteKit

class BasketballGameScene: SKScene {

    let offenseColor = SKColor.blue
    let defenseColor = SKColor.red
    let ballColor = SKColor.orange

    var players: [SKShapeNode] = []
    var defenders: [SKShapeNode] = []
    var ball = SKShapeNode(circleOfRadius: 12)
    var hoop = SKShapeNode(circleOfRadius: 15)

    var selectedPlayer: SKShapeNode?
    var touchStartTime: TimeInterval = 0

    // Track play actions
    enum Action {
        case move(player: Int, position: CGPoint)
        case pass(player: Int)
        case shot
    }

    var recordedActions: [Action] = []

    // MARK: - Defense
    enum DefenseType: String, CaseIterable {
        case man = "Man"
        case zone23 = "2-3 Zone"
        case zone32 = "3-2 Zone"
    }

    var currentDefense: DefenseType = .man

    // UI
    var mainButton: SKLabelNode!
    var shootButton: SKLabelNode!
    var simulateButton: SKLabelNode!

    var dropdownOpen = false
    var dropdownNodes: [SKLabelNode] = []

    override func didMove(to view: SKView) {
        backgroundColor = .white
        drawCourt()
        createPlayers()
        createDefense(type: currentDefense)
        createBall()
        createUI()
    }

    // MARK: - Court
    func drawCourt() {
        let court = SKShapeNode(rectOf: CGSize(width: 350, height: 500))
        court.strokeColor = .black
        court.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(court)

        hoop.strokeColor = .orange
        hoop.lineWidth = 4
        hoop.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(hoop)
    }

    // MARK: - Players
    func createPlayers() {
        let positions = [
            CGPoint(x: frame.midX - 100, y: 250),
            CGPoint(x: frame.midX + 100, y: 250),
            CGPoint(x: frame.midX, y: 350),
            CGPoint(x: frame.midX - 80, y: 450),
            CGPoint(x: frame.midX + 80, y: 450)
        ]

        for (i, pos) in positions.enumerated() {
            let p = SKShapeNode(circleOfRadius: 20)
            p.fillColor = offenseColor
            p.position = pos
            p.name = "player_\(i)"
            addChild(p)
            players.append(p)
        }
    }

    // MARK: - Defense
    func createDefense(type: DefenseType) {
        defenders.forEach { $0.removeFromParent() }
        defenders.removeAll()

        let positions: [CGPoint]

        switch type {
        case .man:
            positions = players.map { CGPoint(x: $0.position.x, y: $0.position.y + 60) }
        case .zone23:
            positions = [
                CGPoint(x: frame.midX - 100, y: 400),
                CGPoint(x: frame.midX + 100, y: 400),
                CGPoint(x: frame.midX - 120, y: 520),
                CGPoint(x: frame.midX, y: 520),
                CGPoint(x: frame.midX + 120, y: 520)
            ]
        case .zone32:
            positions = [
                CGPoint(x: frame.midX - 120, y: 420),
                CGPoint(x: frame.midX, y: 420),
                CGPoint(x: frame.midX + 120, y: 420),
                CGPoint(x: frame.midX - 80, y: 540),
                CGPoint(x: frame.midX + 80, y: 540)
            ]
        }

        for pos in positions {
            let d = SKShapeNode(circleOfRadius: 20)
            d.fillColor = defenseColor
            d.position = pos
            addChild(d)
            defenders.append(d)
        }
    }

    // MARK: - Ball
    func createBall() {
        ball.fillColor = ballColor
        ball.position = players[2].position
        addChild(ball)
    }

    func passBall(to player: SKShapeNode, record: Bool = true) {
        let move = SKAction.move(to: player.position, duration: 0.35)
        ball.run(move)

        if record, let index = players.firstIndex(of: player) {
            recordedActions.append(.pass(player: index))
        }
    }

    // MARK: - Shooting
    func shootBall() {
        let target = hoop.position

        let arcUp = SKAction.moveBy(x: 0, y: 120, duration: 0.3)
        let moveToHoop = SKAction.move(to: target, duration: 0.4)

        let shot = SKAction.sequence([arcUp, moveToHoop])
        ball.run(shot)

        let made = evaluateShot()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            print(made ? "SHOT MADE ✅" : "MISSED ❌")
        }

        recordedActions.append(.shot)
    }

    func evaluateShot() -> Bool {
        // distance from hoop
        let dx = ball.position.x - hoop.position.x
        let dy = ball.position.y - hoop.position.y
        let distance = sqrt(dx*dx + dy*dy)

        // defender pressure
        var pressure: CGFloat = 0
        for d in defenders {
            let dist = hypot(d.position.x - ball.position.x,
                             d.position.y - ball.position.y)
            if dist < 80 {
                pressure += 0.2
            }
        }

        let baseChance = max(0.2, 1.0 - distance / 400)
        let finalChance = baseChance - pressure

        return CGFloat.random(in: 0...1) < finalChance
    }

    // MARK: - UI
    func createUI() {
        mainButton = SKLabelNode(text: "Defense ▼")
        mainButton.position = CGPoint(x: frame.midX, y: frame.minY + 40)
        mainButton.name = "dropdown"
        mainButton.fontColor = .black
        addChild(mainButton)

        shootButton = SKLabelNode(text: "Shoot")
        shootButton.position = CGPoint(x: frame.midX - 100, y: frame.minY + 40)
        shootButton.name = "shoot"
        shootButton.fontColor = .blue
        addChild(shootButton)

        simulateButton = SKLabelNode(text: "Simulate")
        simulateButton.position = CGPoint(x: frame.midX + 100, y: frame.minY + 40)
        simulateButton.name = "simulate"
        simulateButton.fontColor = .purple
        addChild(simulateButton)
    }

    func toggleDropdown() {
        dropdownOpen.toggle()
        dropdownNodes.forEach { $0.removeFromParent() }
        dropdownNodes.removeAll()

        if dropdownOpen {
            for (i, type) in DefenseType.allCases.enumerated() {
                let label = SKLabelNode(text: type.rawValue)
                label.position = CGPoint(x: mainButton.position.x,
                                         y: mainButton.position.y + CGFloat((i+1)*30))
                label.name = "def_\(type.rawValue)"
                label.fontColor = .darkGray
                addChild(label)
                dropdownNodes.append(label)
            }
        }
    }

    // MARK: - Simulation
    func simulatePlay() {
        var actions: [SKAction] = []

        for act in recordedActions {
            switch act {
            case .pass(let index):
                let move = SKAction.move(to: players[index].position, duration: 0.4)
                actions.append(move)

            case .move(_, let pos):
                let move = SKAction.move(to: pos, duration: 0.4)
                actions.append(move)

            case .shot:
                let shot = SKAction.move(to: hoop.position, duration: 0.5)
                actions.append(shot)
            }
        }

        ball.run(SKAction.sequence(actions))
    }

    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchStartTime = touch.timestamp

        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)

        for node in nodes {

            if node.name == "dropdown" {
                toggleDropdown()
                return
            }

            if node.name == "shoot" {
                shootBall()
                return
            }

            if node.name == "simulate" {
                simulatePlay()
                return
            }

            if let name = node.name, name.starts(with: "def_") {
                let val = name.replacingOccurrences(of: "def_", with: "")
                if let def = DefenseType(rawValue: val) {
                    currentDefense = def
                    createDefense(type: def)
                }
                toggleDropdown()
                return
            }

            if let shape = node as? SKShapeNode,
               let name = shape.name,
               name.contains("player_") {
                selectedPlayer = shape
                return
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let player = selectedPlayer else { return }

        let location = touch.location(in: self)
        player.position = location

        if let index = players.firstIndex(of: player) {
            recordedActions.append(.move(player: index, position: location))
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let player = selectedPlayer else {
            selectedPlayer = nil
            return
        }

        let duration = touch.timestamp - touchStartTime

        if duration < 0.2 {
            passBall(to: player)
        }

        selectedPlayer = nil
    }
}
