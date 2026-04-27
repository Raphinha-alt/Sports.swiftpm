//
//  PlayMaker.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SpriteKit

class BasketballGameScene: SKScene {

    override func didMove(to view: SKView) {

        backgroundColor = .darkGray

        print("🔥 Scene is running")

        drawCourt()
        spawnPlayers()
    }

    // MARK: COURT (VERY SIMPLE, ALWAYS VISIBLE)
    func drawCourt() {

        let court = SKShapeNode(rectOf: CGSize(width: 300, height: 500))
        court.fillColor = .orange
        court.strokeColor = .white
        court.lineWidth = 4
        court.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(court)

        let hoop = SKShapeNode(circleOfRadius: 10)
        hoop.fillColor = .red
        hoop.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(hoop)
    }

    // MARK: PLAYERS (STATIC BUT GUARANTEED VISIBLE)
    func spawnPlayers() {

        for i in 0..<5 {

            let offense = SKShapeNode(circleOfRadius: 12)
            offense.fillColor = .blue
            offense.position = CGPoint(
                x: frame.midX + CGFloat(i - 2) * 40,
                y: frame.midY + 120
            )
            addChild(offense)

            let defense = SKShapeNode(circleOfRadius: 12)
            defense.fillColor = .red
            defense.position = CGPoint(
                x: frame.midX + CGFloat(i - 2) * 40,
                y: frame.midY + 40
            )
            addChild(defense)
        }

        let ball = SKShapeNode(circleOfRadius: 6)
        ball.fillColor = .orange
        ball.position = CGPoint(x: frame.midX, y: frame.midY + 120)
        addChild(ball)

        let label = SKLabelNode(text: "WORKING BASKETBALL SCENE")
        label.fontSize = 20
        label.fontColor = .white
        label.position = CGPoint(x: frame.midX, y: frame.midY + 220)
        addChild(label)
    }
}
