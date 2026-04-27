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
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func didMove(to view: SKView) {
        ball = SKShapeNode(circleOfRadius: 20)
        ball.fillColor = .white
        ball.position = CGPoint(x: size.width/2, y: size.height/2)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.friction = 1
        ball.physicsBody?.angularDamping = 1
        ball.physicsBody?.linearDamping = 1
        ball.physicsBody?.restitution = 0.75
        ball.physicsBody?.collisionBitMask = 1
        
        addChild(ball)
    }
}
