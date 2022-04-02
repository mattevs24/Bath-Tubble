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
    
    var cardFront1: SKShapeNode?
    var cardFront2: SKShapeNode?
    
    var cardFront1Other: SKShapeNode?
    var cardFront2Other: SKShapeNode?
    
    var player1: SKLabelNode!
    var player2: SKLabelNode!
    
    var currentCard1: Int!
    var currentCard2: Int!
    
    var player1cards: [Int]!
    var player2cards: [Int]!
    var correctIcon: Int?
    var player1Icons: [Int]?
    var player2Icons: [Int]?
    
    var gameStarted: Bool = false //touch enabled for game
    
    var countdown: SKSpriteNode!
    var gameCont = MultiplayerGameSystem()

    override func didMove(to view: SKView) {
        
        createCardBacks()
        createPlayerNumbers()
        
        //set up the deck to be sorted into the piles
        gameCont.indexes.shuffle()
        gameCont.indexes.remove(at: 1)
        player1cards = Array(gameCont.indexes.prefix(27))
        player2cards = Array(gameCont.indexes.suffix(27))
        
        currentCard1 = player1cards[0]
        currentCard2 = player2cards[0]
        
        countdownToPlay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            let nodesArray = self.nodes(at: location)
            
            
            player1Icons = gameCont.cards[currentCard1]
            player2Icons = gameCont.cards[currentCard2]
            
            correctIcon = uniqueMatch(A: player1Icons!, B: player2Icons!)
            
            if nodesArray.first?.name == "correct" {   //should be "correct" = String(correctIcon)
                let index = nodesArray.first?.name == "correct"
                let node = nodesArray[index!]
                let receiver = node.parent
                if receiver == cardFront1 {
                    moveCard(giver: 2)
                } else if receiver == cardFront1Other {
                    moveCard(giver: 2)
                } else if receiver == cardFront2 {
                    moveCard(giver: 1)
                } else {
                    moveCard(giver: 1)
                }
            }
            
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
        player1 = SKLabelNode(text: "\(player1cards?.count ?? 0)")
        player2 = SKLabelNode(text: "\(player2cards?.count ?? 0)")
        
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
    
    //MARK: - Countdown
    
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
            createPlayer1Card()
            cardFront1?.zPosition = 0
            createPlayer2Card()
            cardFront2?.zPosition = 0
            cardBack1.removeFromParent()
            cardBack2.removeFromParent()
            player1Icons(index: 0, other: false)
            player2Icons(index: 0, other: false)
        }
        let transitionSeq = SKAction.sequence([transition, remove, activatePlaying])
        
        countdown.run(transitionSeq)
    }
    
    //MARK: - playerCards creation
    
    func createPlayer1Card() {
        cardFront1 = SKShapeNode(circleOfRadius: 120)
        cardFront1?.name = "player1Card"
        cardFront1?.fillColor = .green
        cardFront1?.zPosition = -10
        
        cardFront1?.position = CGPoint(x: frame.width/2, y: frame.height/4*3)
        
        addChild(cardFront1!)
    }
    
    func createPlayer2Card() {
        cardFront2 = SKShapeNode(circleOfRadius: 120)
        cardFront2?.name = "player2Card"
        cardFront2?.fillColor = .green
        cardFront2?.zPosition = -10
        
        cardFront2?.position = CGPoint(x: frame.width/2, y: frame.height/4)
        
        addChild(cardFront2!)
    }
    
    func createPlayer1Other() {
        cardFront1Other = SKShapeNode(circleOfRadius: 120)
        cardFront1Other?.name = "player1Card"
        cardFront1Other?.fillColor = .green
        cardFront1Other?.zPosition = -10
        
        cardFront1Other?.position = CGPoint(x: frame.width/2, y: frame.height/4*3)
        
        addChild(cardFront1Other!)
    }
    
    func createPlayer2Other() {
        cardFront2Other = SKShapeNode(circleOfRadius: 120)
        cardFront2Other?.name = "player2Card"
        cardFront2Other?.fillColor = .green
        cardFront2Other?.zPosition = -10
        
        cardFront2Other?.position = CGPoint(x: frame.width/2, y: frame.height/4)
        
        addChild(cardFront2Other!)
    }
    
    //MARK: - PlayerIcons
    
    func player1Icons(index:Int, other: Bool) {
        if other {
            var icon = SKSpriteNode(imageNamed: "logo")
            icon.position = CGPoint.zero
            icon.name = "correct"
            icon.size = CGSize(width: 40, height: 40)
            cardFront1Other?.addChild(icon)
            
            for i in 0...6 {
                let addx = 90*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 90*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "logo")
                icon.name = "incorrect"
                icon.position = CGPoint(x:addx, y:addy)
                icon.size = CGSize(width: 40, height: 40)
                cardFront1Other?.addChild(icon)
            }
        } else {
            var icon = SKSpriteNode(imageNamed: "logo")
            icon.position = CGPoint.zero
            icon.name = "correct"
            icon.size = CGSize(width: 40, height: 40)
            cardFront1?.addChild(icon)
            
            for i in 0...6 {
                let addx = 90*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 90*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "logo")
                icon.position = CGPoint(x:addx, y:addy)
                icon.name = "incorrect"
                icon.size = CGSize(width: 40, height: 40)
                cardFront1?.addChild(icon)
            }
        }
    }
    
    func player2Icons(index:Int, other: Bool) {
        if other {
            var icon = SKSpriteNode(imageNamed: "logo")
            icon.name = "correct"
            icon.position = CGPoint.zero
            icon.size = CGSize(width: 40, height: 40)
            cardFront2Other?.addChild(icon)
            
            for i in 0...6 {
                let addx = 90*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 90*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "logo")
                icon.name = "incorrect"
                icon.position = CGPoint(x:addx, y: addy)
                icon.size = CGSize(width: 40, height: 40)
                cardFront2Other?.addChild(icon)
            }
        } else {
            var icon = SKSpriteNode(imageNamed: "logo")
            icon.position = CGPoint.zero
            icon.name = "correct"
            icon.size = CGSize(width: 40, height: 40)
            cardFront2?.addChild(icon)
            
            for i in 0...6 {
                let addx = 90*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 90*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "logo")
                icon.name = "incorrect"
                icon.position = CGPoint(x:addx, y: addy)
                icon.size = CGSize(width: 40, height: 40)
                cardFront2?.addChild(icon)
            }
        }
    }
    
    //MARK: - moveCard
    
    func moveCard(giver:Int) {
        //raise the receiver +10
        //add new card under giver @ -10
        //translate given card
        //remove card after the translation
        //move new card up 10
        //move new card up 10
        //move old other card down 10
        
        if giver == 1 {
            if cardFront1 == nil {
                if cardFront2 == nil {
                    cardFront2Other?.zPosition += 10
                } else {
                    cardFront2?.zPosition += 10
                }
                createPlayer1Card()
                player1Icons(index: 0, other: false)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/4), duration: 0.5)
                cardFront1Other?.run(action)
                cardFront1Other = nil //need to nil
                cardFront1?.zPosition += 10
                if cardFront2 == nil {
                    cardFront2Other?.zPosition -= 10
                } else {
                    cardFront2?.zPosition -= 10
                }
            } else {
                if cardFront2 == nil {
                    cardFront2Other?.zPosition += 10
                } else {
                    cardFront2?.zPosition += 10
                }
                createPlayer1Other()
                player1Icons(index: 0, other: true)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/4), duration: 0.5)
                cardFront1?.run(action)
                cardFront1 = nil
                cardFront1Other?.zPosition += 10
                if cardFront2 == nil {
                    cardFront2Other?.zPosition -= 10
                } else {
                    cardFront2?.zPosition -= 10
                }
            }

        } else if giver == 2 {
            if cardFront2 == nil {
                if cardFront1 == nil {
                    cardFront1Other?.zPosition += 10
                } else {
                    cardFront1?.zPosition += 10
                }
                createPlayer2Card()
                player2Icons(index: 0, other: false)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*3/4), duration: 0.5)
                cardFront2Other?.run(action)
                cardFront2Other = nil
                cardFront2?.zPosition += 10
                if cardFront1 == nil {
                    cardFront1Other?.zPosition -= 10
                } else {
                    cardFront1?.zPosition -= 10
                }
            } else {
                if cardFront1 == nil {
                    cardFront1Other?.zPosition += 10
                } else {
                    cardFront1?.zPosition += 10
                }
                createPlayer2Other()
                player2Icons(index: 0, other: true)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*3/4), duration: 0.5)
                cardFront2?.run(action)
                cardFront2 = nil
                cardFront2Other?.zPosition += 10
                if cardFront1 == nil {
                    cardFront1Other?.zPosition -= 10
                } else {
                    cardFront1?.zPosition -= 10
                }
            }
        }
    }
    
    func uniqueMatch(A:[Int],B:[Int]) -> Int {
        if Array(Set(A).intersection(Set(B))).count == 1{
            return Array(Set(A).intersection(Set(B)))[0]
        } else {
            return 0
        }
    }
}
