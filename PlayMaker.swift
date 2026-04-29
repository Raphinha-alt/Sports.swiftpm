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
    override func didMove(to view: SKView) {
        backgroundColor =
            .white
        drawCourt()
        createPlayers()
        createDefense()
        createBall()
    }
    func drawCourt() {
        let court = SKShapeNode(rectOf: CGSize(width: 350, height: 500))
        court.strokeColor =
            .black
        court.lineWidth = 4
        court.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(court)
        let hoop = SKShapeNode(circleOfRadius: 15)
        hoop.strokeColor =
            .orange
        hoop.lineWidth = 4
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
        for pos in positions {
            let player = SKShapeNode(circleOfRadius: 20)
            player.fillColor = offenseColor
            player.position = pos
            player.name = "player"
            addChild(player)
            players.append(player)
        }
    }
    func createDefense() {
        let positions = [
            CGPoint(x: frame.midX - 120, y: 320),
            CGPoint(x: frame.midX + 120, y: 320),
            CGPoint(x: frame.midX, y: 420),
            CGPoint(x: frame.midX - 60, y: 520),
            CGPoint(x: frame.midX + 60, y: 520)
        ]
        for pos in positions {
            let defender = SKShapeNode(circleOfRadius: 20)
            defender.fillColor = defenseColor
            defender.position = pos
            addChild(defender)
            defenders.append(defender)
        }
    }
    func createBall() {
        ball.fillColor = ballColor
        ball.position = CGPoint(x: frame.midX, y: 350)
        addChild(ball)
    }
}
