//
//  GameScene.swift
//  Sports
//
//  Created by Oleksandr Andrusyshyn on 4/23/26.
//
import SwiftUI
import SpriteKit

class GameScene: SKScene, @MainActor SKPhysicsContactDelegate {
    var ball = SKShapeNode()
    var sand = SKShapeNode()
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func didMove(to view: SKView) {
//        Ball Physics
        ball = SKShapeNode(circleOfRadius: 20)
        ball.fillColor = .white
        ball.position = CGPoint(x: size.width/2, y: size.height/2)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.friction = 1
        ball.physicsBody?.angularDamping = 1
        ball.physicsBody?.linearDamping = 1
        ball.physicsBody?.restitution = 0.7
        ball.physicsBody?.collisionBitMask = 1
        
//        Sand Properties
        sand = SKShapeNode(rectOf: CGSize(width: 1000, height: 50))
        sand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1000, height: 50))
        sand.fillColor = .yellow
        sand.position = CGPoint(x: size.width/4, y: 50)
        sand.zRotation = 35
        
        sand.physicsBody?.isDynamic = false
        sand.physicsBody?.categoryBitMask = 1
        sand.physicsBody?.friction = 1
        
        addChild(ball)
        addChild(sand)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let velX = ball.physicsBody?.velocity.dx
        let velY = ball.physicsBody?.velocity.dy
        let vel = ball.physicsBody?.angularVelocity
        
        if ball.physicsBody?.angularVelocity ?? 0 <= 1, ball.physicsBody?.angularVelocity ?? 0 >= -1 {
            
            if ball.frame.contains(location) {
                print("ang: \(vel)")
            ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
            }
        } else {
            print("else ang: \(vel)")
        }
    }
}
