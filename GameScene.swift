//
//  GameScene.swift
//  Sports
//
//  Created by Oleksandr Andrusyshyn on 4/23/26.
//
import SwiftUI
import SpriteKit

class GameScene: SKScene, @MainActor SKPhysicsContactDelegate {
    
    @Binding var powers: CGFloat
    
    init(powers: Binding<CGFloat>, size: CGSize){
        _powers = powers
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var hits = 0
        
    var ball = SKShapeNode()
    var sand = SKShapeNode()
    var pointer = SKShapeNode()
    var goal = SKShapeNode()
    
    var velXFloat: CGFloat = 0
    var velYFloat: CGFloat = 0
    
    let label = SKLabelNode(text: "")
    let cameraF = SKCameraNode()
    
    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        addChild(label)
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
        ball.physicsBody?.node?.name = "Gball"
        
//        Sand Properties
        sand = SKShapeNode(rectOf: CGSize(width: 1000, height: 50))
        sand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1000, height: 50))
        sand.fillColor = .yellow
        sand.position = CGPoint(x: size.width/2, y: 50)
        
        
        sand.physicsBody?.isDynamic = false
        sand.physicsBody?.categoryBitMask = 1
        sand.physicsBody?.friction = 1
        
        pointer = SKShapeNode(rect: CGRect(x: 0, y: -5, width: 70, height: 10))
        pointer.zPosition = 10
        pointer.fillColor = .white
        
//      Goal
        goal = SKShapeNode(rectOf: CGSize(width: 30, height: 40))
        goal.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 40))
        goal.physicsBody?.isDynamic = false
        goal.physicsBody?.collisionBitMask = 1
        goal.physicsBody?.contactTestBitMask = 1
        goal.position = CGPoint(x: size.width * 0.90, y: 90)
        goal.fillColor = .gray
        goal.physicsBody?.node?.name = "Ggoal"
        
        addChild(ball)
        addChild(sand)
        addChild(pointer)
        addChild(goal)
        
        self.camera = cameraF
        self.addChild(cameraF)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        var velX: Double = velXFloat
        var velY: Double = velYFloat
        
        
        if ball.physicsBody?.angularVelocity ?? 0 <= 0.1, ball.physicsBody?.angularVelocity ?? 0 >= -0.1 {
            if ball.frame.contains(location) {
                
                velX = CGFloat(cos(Double(pointer.zRotation)) * 20 * (powers))
                velY = CGFloat(sin(Double(pointer.zRotation)) * 20 * (powers))
                
                hits += 1
                
                ball.physicsBody?.applyImpulse(CGVector(dx: velX, dy: velY))
                
            }
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
        cameraF.position = ball.position
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Ggoal" {
            pointer.removeFromParent()
            ball.removeFromParent()
            label.text = "You finnished in \(hits) hits!"
            print("goal")
        }

    }
}
