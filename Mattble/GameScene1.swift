//
//  GameScene.swift
//  Mattble
//
//  Created by Matthew Evans on 02/04/2022.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene1: SKScene {
    
    var cardBack1: SKShapeNode!
    var cardBack2: SKShapeNode!
    
    var player1: SKLabelNode!
    var player2: SKLabelNode!
    
    var cards1: Int = 10
    var cards2: Int = 14
    
    var gameStarted: Bool = false
    
    var countdown: SKSpriteNode!
    

    override func didMove(to view: SKView) {
        createCardBacks()
        createPlayerNumbers()
        
        countdownToPlay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            guard let touch = touches.first else { return }
        }
    }
    
    func createCardBacks() {
        cardBack1 = SKShapeNode(circleOfRadius: 120)
        cardBack2 = SKShapeNode(circleOfRadius: 120)
        
        let texture = SKTexture(imageNamed: "logo")
        
        cardBack1.fillTexture = texture
        cardBack2.fillTexture = texture
        
        cardBack1.fillColor = .white
        cardBack2.fillColor = .white
        
        cardBack1.strokeColor = .blue
        cardBack2.strokeColor = .blue
        
        cardBack1.lineWidth = 10
        cardBack2.lineWidth = 10
        
        cardBack1.position = CGPoint(x: frame.width/2, y: frame.height/4*3)
        cardBack2.position = CGPoint(x: frame.width/2, y: frame.height/4)

        addChild(cardBack1)
        addChild(cardBack2)
    }
    
    func createPlayerNumbers() {
        player1 = SKLabelNode(text: "\(cards1)")
        player2 = SKLabelNode(text: "\(cards2)")
        
        player1.position = CGPoint(x: frame.width/5-10, y: 250)
        player1.fontSize = 36
        player1.fontName = ""
        player1.zPosition = 100
        player1.fontColor = .black
        
        player2.position = CGPoint(x: frame.width*4/5+10, y: 667-250)
        player2.fontSize = 36
        player2.fontName = ""
        player2.zPosition = 100
        player2.fontColor = .black
        player2.zRotation = .pi
        
        addChild(player1)
        addChild(player2)
    }
    
    func countdownToPlay() {
        let countdown3Texture = SKTexture(imageNamed: "logo")
        
        countdown = SKSpriteNode(texture: countdown3Texture)
        countdown.zPosition = 100 //top layer
        countdown.position = CGPoint(x: frame.width/2, y: frame.height/2)
        countdown.zRotation = .pi/2
        
        addChild(countdown)
        
        let countdown2Texture = SKTexture(imageNamed: "logo")
        let countdown1Texture = SKTexture(imageNamed: "logo")
        let countdownGoTexture = SKTexture(imageNamed: "logo")
        
        let transition = SKAction.animate(with: [countdown3Texture,countdown2Texture,countdown1Texture,countdownGoTexture], timePerFrame: 1)
        
        countdown.run(transition)
    }
    
}
