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
    var pointer = SKShapeNode()
    
    var velXFloat: CGFloat = 0
    var velYFloat: CGFloat = 0
        
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
        
        
        sand.physicsBody?.isDynamic = false
        sand.physicsBody?.categoryBitMask = 1
        sand.physicsBody?.friction = 1
        
        pointer = SKShapeNode(rect: CGRect(x: 0, y: -5, width: 70, height: 10))
        pointer.zPosition = 10
        pointer.fillColor = .white
        
        addChild(ball)
        addChild(sand)
        addChild(pointer)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        var velX: Double = velXFloat
        var velY: Double = velYFloat
        
        let vel = ball.physicsBody?.angularVelocity
        
        if ball.physicsBody?.angularVelocity ?? 0 <= 1, ball.physicsBody?.angularVelocity ?? 0 >= -1 {
            
            if ball.frame.contains(location) {
                print("ang: \(vel)")
                
                velX = CGFloat(cos(Double(pointer.zRotation)) * 100)
                velY = CGFloat(sin(Double(pointer.zRotation)) * 100)
                
            ball.physicsBody?.applyImpulse(CGVector(dx: velX, dy: velY))
                
            }
        } else {
            print("else ang: \(vel)")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if ball.frame.contains(location) == false  {
            
            pointer.zRotation = CGFloat(atan2(location.y - ball.position.y, location.x - ball.position.x))

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        pointer.position = ball.position
        
    }
}
