//
//  PlayList.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SwiftUI
import SpriteKit

struct PlayList: View {

    var body: some View {

        NavigationView {

            List(BasketballGameScene.savedPlays) { play in

                NavigationLink(destination: SavedPlayView(play: play)) {

                    VStack(alignment: .leading) {

                        Text(play.name)
                            .font(.headline)

                        Text("\(play.frames.count) Frames")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Saved Plays")
        }
    }
}

struct SavedPlayView: View {

    let play: SavedPlay

    var scene: SKScene {

        let scene = ReplayScene(size: CGSize(width: 390, height: 844))
        scene.scaleMode = .resizeFill

        scene.savedFrames = play.frames
        scene.defenseType = play.defenseType

        return scene
    }

    var body: some View {

        SpriteView(scene: scene)
            .ignoresSafeArea()
            .navigationTitle(play.name)
    }
}

class ReplayScene: SKScene {

    var savedFrames: [BasketballGameScene.Frame] = []
    var defenseType: BasketballGameScene.DefenseType = .man

    var players: [SKShapeNode] = []
    var defenders: [SKShapeNode] = []

    var ball = SKShapeNode(circleOfRadius: 12)

    override func didMove(to view: SKView) {

        backgroundColor = .white

        createCourt()
        createPlayers()
        createDefense()
        createBall()

        replay()
    }

    func createCourt() {

        let court = SKShapeNode(rectOf: CGSize(width: 350, height: 500))
        court.strokeColor = .black
        court.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(court)

        let hoop = SKShapeNode(circleOfRadius: 15)
        hoop.strokeColor = .orange
        hoop.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(hoop)
    }

    func createPlayers() {

        for _ in 0..<5 {

            let p = SKShapeNode(circleOfRadius: 20)
            p.fillColor = .blue

            addChild(p)
            players.append(p)
        }
    }

    func createDefense() {

        let cx = frame.midX
        let topY = frame.midY + 120
        let lowY = frame.midY - 120

        switch defenseType {

        case .man:

            for _ in 0..<5 {

                let d = SKShapeNode(circleOfRadius: 20)
                d.fillColor = .red

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

            for pos in positions {

                let d = SKShapeNode(circleOfRadius: 20)
                d.fillColor = .red
                d.position = pos

                addChild(d)
                defenders.append(d)
            }

        case .zone32:

            let positions = [
                CGPoint(x: cx - 100, y: topY),
                CGPoint(x: cx, y: topY),
                CGPoint(x: cx + 100, y: topY),
                CGPoint(x: cx - 60, y: lowY),
                CGPoint(x: cx + 60, y: lowY)
            ]

            for pos in positions {

                let d = SKShapeNode(circleOfRadius: 20)
                d.fillColor = .red
                d.position = pos

                addChild(d)
                defenders.append(d)
            }
        }
    }

    func createBall() {

        ball.fillColor = .orange
        addChild(ball)
    }

    func replay() {

        guard savedFrames.count > 1 else { return }

        var actions: [SKAction] = []

        for i in 1..<savedFrames.count {

            let prev = savedFrames[i - 1]
            let curr = savedFrames[i]

            let duration = max(0.02, curr.time - prev.time)

            let step = SKAction.run {

                for (index, pos) in curr.playerPositions.enumerated() {

                    if index < self.players.count {

                        self.players[index].position = pos

                        if self.defenseType == .man {

                            self.defenders[index].position = CGPoint(
                                x: pos.x,
                                y: pos.y + 60
                            )
                        }
                    }
                }

                self.ball.position = curr.ballPosition
            }

            actions.append(step)
            actions.append(SKAction.wait(forDuration: duration))
        }

        run(SKAction.sequence(actions))
    }
}
