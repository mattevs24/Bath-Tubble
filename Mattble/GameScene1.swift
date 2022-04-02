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
    
    var cardFront1: SKShapeNode!
    var cardFront2: SKShapeNode!
    
    var player1: SKLabelNode!
    var player2: SKLabelNode!
    
    var cards1: Int = 10
    var cards2: Int = 14
    
    var gameStarted: Bool = false
    
    var countdown: SKSpriteNode!
    var gameCont = MultiplayerGameSystem()
    

    override func didMove(to view: SKView) {
        var player1cards: [Int]
        var player2cards: [Int]
        
        createCardBacks()
        createPlayerNumbers()
        
        //set up the deck to be sorted into the piles
        gameCont.indexes.shuffled()
        gameCont.indexes.remove(at: 1)
        player1cards = Array(gameCont.indexes.prefix(27))
        player2cards = Array(gameCont.indexes.suffix(27))
        
        countdownToPlay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
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
        let remove = SKAction.removeFromParent()
        
        let transition = SKAction.animate(with: [countdown3Texture,countdown2Texture,countdown1Texture,countdownGoTexture], timePerFrame: 1)
        let activatePlaying = SKAction.run { [unowned self] in
            self.gameStarted.toggle()
            createCard()
            cardBack1.removeFromParent()
            cardBack2.removeFromParent()
            player1Icons(index: 0)
            player2Icons(index: 0)
        }
        let transitionSeq = SKAction.sequence([transition, remove, activatePlaying])
        
        countdown.run(transitionSeq)
    }
    
    func createCard() {
        cardFront1 = SKShapeNode(circleOfRadius: 120)
        cardFront2 = SKShapeNode(circleOfRadius: 120)
        cardFront1.name = "player1Icon"
        cardFront2.name = "player2Icon"
        
        cardFront1.fillColor = .green
        cardFront2.fillColor = .green
        
        cardFront1.position = CGPoint(x: frame.width/2, y: frame.height/4*3)
        cardFront2.position = CGPoint(x: frame.width/2, y: frame.height/4)
        
        addChild(cardFront1)
        addChild(cardFront2)
    }
    
    func player1Icons(index:Int) {
        var icon = SKSpriteNode(imageNamed: "logo")
        icon.name = "player1Icon"
        icon.position = CGPoint.zero
        icon.size = CGSize(width: 40, height: 40)
        cardFront1.addChild(icon)
        
        for i in 0...6 {
            let addx = 90*sin((2.0/7.0)*Double.pi*Double(i))
            let addy = 90*cos((2.0/7.0)*Double.pi*Double(i))
            icon = SKSpriteNode(imageNamed: "logo")
            icon.position = CGPoint(x:addx, y:addy)
            icon.name = "player1Icon"
            icon.size = CGSize(width: 40, height: 40)
            cardFront1.addChild(icon)
        }
    }
    
    func player2Icons(index:Int) {
        var icon = SKSpriteNode(imageNamed: "logo")
        icon.name = "player2Icon"
        icon.position = CGPoint.zero
        icon.size = CGSize(width: 40, height: 40)
        cardFront2.addChild(icon)
        
        for i in 0...6 {
            let addx = 90*sin((2.0/7.0)*Double.pi*Double(i))
            let addy = 90*cos((2.0/7.0)*Double.pi*Double(i))
            icon = SKSpriteNode(imageNamed: "logo")
            icon.position = CGPoint(x:addx, y: addy)
            icon.name = "player2Icon"
            icon.size = CGSize(width: 40, height: 40)
            cardFront2.addChild(icon)
        }
    }
    
    func moveCard(giver:Int, receiver: Int, indexGiver: Int, indexReceiver: Int) {
        //raise the receiver +10
        let giverID = "player\(giver)Icon"
        let receiverID = "player\(receiver)Icon"
        
        childNode(withName: receiverID)?.zPosition += 10
        
        //add new card under giver @ -10
        
        //translate given card
        
        //remove card after the translation
        
        //move new card up 10
        
        //move receiver -10
    }
}
