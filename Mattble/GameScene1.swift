//
//  GameScene.swift
//  Mattble
//
//  Created by Matthew Evans on 02/04/2022.
//

//need to add sounds and white playing card texture for the cards

import SpriteKit
import GameplayKit
import SwiftUI
import AVFoundation

class GameScene1: SKScene {
    
    var cardBack1: SKShapeNode!
    var cardBack2: SKShapeNode!
    
    var cardFront1: SKShapeNode?
    var cardFront2: SKShapeNode?
    
    var cardFront1Other: SKShapeNode?
    var cardFront2Other: SKShapeNode?
    
    var currentCard1: Int!
    var currentCard2: Int!
    
    var player1cards: [Int]!
    var player2cards: [Int]!
    var correctIcon: String!
    var player1Icons: [Int]?
    var player2Icons: [Int]?
    
    var player1: SKLabelNode!
    var player2: SKLabelNode!
    
    var music: AVAudioPlayer!
    
    var gameStarted: Bool = false //touch enabled for game
    
    var countdown: SKSpriteNode!
    var gameCont = MultiplayerGameSystem()
    
    override func update(_ currentTime: TimeInterval) {
        player1.text = "\(player1cards?.count ?? 0)"
        player2.text = "\(player2cards?.count ?? 0)"
    }

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
    
    //MARK: - touchesBegan
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            let nodesArray = self.nodes(at: location)
            
            
            player1Icons = gameCont.cards[currentCard1]
            player2Icons = gameCont.cards[currentCard2]
            
            correctIcon = uniqueMatch(A: player1Icons!, B: player2Icons!)
            
            if nodesArray.first?.name == correctIcon {
                let node = nodesArray[0]
                let receiver = node.parent
                if receiver == cardFront1 {
                    moveCard(giver: 2)
                    run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
                } else if receiver == cardFront1Other {
                    moveCard(giver: 2)
                    run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
                } else if receiver == cardFront2 {
                    moveCard(giver: 1)
                    run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
                } else {
                    moveCard(giver: 1)
                    run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
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
        player1.zPosition = -100
        player1.fontColor = .black
        
        player2.position = CGPoint(x: frame.width*4/5+10, y: 667-250)
        player2.fontSize = 36
        player2.fontName = ""
        player2.zPosition = -100
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
            player1Icons(index: 0, other: false)
            cardFront1?.zPosition = 0
            createPlayer2Card()
            player2Icons(index: 0, other: false)
            cardFront2?.zPosition = 0
            cardBack1.removeFromParent()
            cardBack2.removeFromParent()
        }
        let transitionSeq = SKAction.sequence([transition, remove, activatePlaying])
        
        countdown.run(transitionSeq)
    }
    
    //MARK: - playerCards creation
    
    func createPlayer1Card() {
        cardFront1 = SKShapeNode(circleOfRadius: 120)
        cardFront1?.fillColor = .white
        cardFront1?.fillTexture = SKTexture(imageNamed: "cardTexture")
        cardFront1?.name = "player1Card"
        cardFront1?.zPosition = -60
        
        cardFront1?.position = CGPoint(x: frame.width/2, y: frame.height/4)
        
        addChild(cardFront1!)
    }
    
    func createPlayer2Card() {
        cardFront2 = SKShapeNode(circleOfRadius: 120)
        cardFront2?.fillColor = .white
        cardFront2?.fillTexture = SKTexture(imageNamed: "cardTexture")
        cardFront2?.name = "player2Card"
        cardFront2?.zPosition = -60
        
        cardFront2?.position = CGPoint(x: frame.width/2, y: frame.height*3/4)
        
        addChild(cardFront2!)
    }
    
    func createPlayer1Other() {
        cardFront1Other = SKShapeNode(circleOfRadius: 120)
        cardFront1Other?.fillColor = .white
        cardFront1Other?.fillTexture = SKTexture(imageNamed: "cardTexture")
        cardFront1Other?.name = "player1Card"
        cardFront1Other?.zPosition = -60
        
        cardFront1Other?.position = CGPoint(x: frame.width/2, y: frame.height/4)
        
        addChild(cardFront1Other!)
    }
    
    func createPlayer2Other() {
        cardFront2Other = SKShapeNode(circleOfRadius: 120)
        cardFront2Other?.fillColor = .white
        cardFront2Other?.fillTexture = SKTexture(imageNamed: "cardTexture")
        cardFront2Other?.name = "player2Card"
        cardFront2Other?.zPosition = -60
        
        cardFront2Other?.position = CGPoint(x: frame.width/2, y: frame.height*3/4)
        
        addChild(cardFront2Other!)
    }
    
    //MARK: - PlayerIcons
    
    func player1Icons(index:Int, other: Bool) {
        if other {
            var shuffled = gameCont.cards[currentCard1]
            shuffled!.shuffle()
            var icon = SKSpriteNode(imageNamed: "\(shuffled![0])")
            var rotation = CGFloat(Double.random(in: 0...2*Double.pi))
            var scalar = CGFloat(Double.random(in: 0.8...1.5))
            icon.zRotation = rotation
            icon.position = CGPoint.zero
            icon.name = "\(shuffled![0])"
            icon.size = CGSize(width: 40*scalar, height: 40*scalar)
            icon.zPosition = 5
            cardFront1Other?.addChild(icon)
            
            for i in 0...6 {
                let addx = 80*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 80*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "\(shuffled![i+1])")
                rotation = CGFloat(Double.random(in: 0...2*Double.pi))
                scalar = CGFloat(Double.random(in: 0.8...1.5))
                icon.zRotation = rotation
                icon.name = "\(shuffled![i+1])"
                icon.position = CGPoint(x:addx, y:addy)
                icon.size = CGSize(width: 40*scalar, height: 40*scalar)
                icon.zPosition = 5
                cardFront1Other?.addChild(icon)
            }
        } else {
            var shuffled = gameCont.cards[currentCard1]
            shuffled!.shuffle()
            var icon = SKSpriteNode(imageNamed: "\(shuffled![0])")
            icon.position = CGPoint.zero
            var rotation = CGFloat(Double.random(in: 0...2*Double.pi))
            var scalar = CGFloat(Double.random(in: 0.8...1.5))
            icon.zRotation = rotation
            icon.name = "\(shuffled![0])"
            icon.size = CGSize(width: 40*scalar, height: 40*scalar)
            icon.zPosition = 5
            cardFront1?.addChild(icon)
            
            for i in 0...6 {
                let addx = 80*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 80*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "\(shuffled![i+1])")
                rotation = CGFloat(Double.random(in: 0...2*Double.pi))
                scalar = CGFloat(Double.random(in: 0.8...1.5))
                icon.zRotation = rotation
                icon.position = CGPoint(x:addx, y:addy)
                icon.name = "\(shuffled![i+1])"
                icon.size = CGSize(width: 40*scalar, height: 40*scalar)
                icon.zPosition = 5
                cardFront1?.addChild(icon)
            }
        }
    }
    
    func player2Icons(index:Int, other: Bool) {
        if other {
            var shuffled = gameCont.cards[currentCard2]
            shuffled!.shuffle()
            var icon = SKSpriteNode(imageNamed: "\(shuffled![0])")
            icon.name = "\(shuffled![0])"
            var rotation = CGFloat(Double.random(in: 0...2*Double.pi))
            var scalar = CGFloat(Double.random(in: 0.8...1.5))
            icon.zRotation = rotation
            icon.position = CGPoint.zero
            icon.size = CGSize(width: 40*scalar, height: 40*scalar)
            icon.zPosition = 5
            cardFront2Other?.addChild(icon)
            
            for i in 0...6 {
                let addx = 80*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 80*cos((2.0/7.0)*Double.pi*Double(i))
                icon = SKSpriteNode(imageNamed: "\(shuffled![i+1])")
                rotation = CGFloat(Double.random(in: 0...2*Double.pi))
                scalar = CGFloat(Double.random(in: 0.8...1.5))
                icon.zRotation = rotation
                icon.name = "\(shuffled![i+1])"
                icon.position = CGPoint(x:addx, y: addy)
                icon.size = CGSize(width: 40*scalar, height: 40*scalar)
                icon.zPosition = 5
                cardFront2Other?.addChild(icon)
            }
        } else {
            var shuffled = gameCont.cards[currentCard2]
            shuffled!.shuffle()
            var icon = SKSpriteNode(imageNamed: "\(shuffled![0])")
            icon.position = CGPoint.zero
            var rotation = CGFloat(Double.random(in: 0...2*Double.pi))
            var scalar = CGFloat(Double.random(in: 0.8...1.5))
            icon.zRotation = rotation
            icon.name = "\(shuffled![0])"
            icon.size = CGSize(width: 40*scalar, height: 40*scalar)
            icon.zPosition = 5
            cardFront2?.addChild(icon)
            
            for i in 0...6 {
                let addx = 80*sin((2.0/7.0)*Double.pi*Double(i))
                let addy = 80*cos((2.0/7.0)*Double.pi*Double(i))
                rotation = CGFloat(Double.random(in: 0...2*Double.pi))
                scalar = CGFloat(Double.random(in: 0.8...1.5))
                icon.zRotation = rotation
                icon = SKSpriteNode(imageNamed: "\(shuffled![i+1])")
                icon.name = "\(shuffled![i+1])"
                icon.position = CGPoint(x:addx, y: addy)
                icon.size = CGSize(width: 40*scalar, height: 40*scalar)
                icon.zPosition = 5
                cardFront2?.addChild(icon)
            }
        }
    }
    
    //MARK: - moveCard
    
    /*
     need to add a transition to the game over menu when the player1cards.count == 0 and same for player2cards.count == 0 ie at the points marked with a break point below in moveCard()
     
     */
    
    func moveCard(giver:Int) {
        //raise the receiver +10
        //add new card under giver @ -10
        //translate given card
        //remove card after the translation
        //move new card up 10
        //move new card up 10
        //move old other card down 10
        
        if giver == 1 {
            if cardFront1 == nil {                                                  //if cardFront1Other
                if cardFront2 == nil {                                              //if cardFront2 == nil
                    cardFront2Other?.zPosition += 60                                //raise cardFront2Other
                } else {
                    cardFront2?.zPosition += 60                                     //raise cardfront2
                }
                //the move card to the other array
                let random = Int.random(in:1...player2cards.count-1)                //generate random index
                player2cards.insert(currentCard1, at: random)                       //insert currentcard1
                let index = player1cards.firstIndex(of: currentCard1)               //index of currentcard1
                player1cards.remove(at: index!)                                     //remove currentcard1
                if player1cards.count==2 {                                          //if one element left
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5) //create transition
                    let gameMenu = GameOver(size: self.size)                        //create scene
                    gameMenu.scaleMode = .aspectFit
                    self.view?.presentScene(gameMenu, transition: transition)       //transition to scene
                }
                currentCard1 = player1cards[0]                                      //new currentcard1
                
                createPlayer1Card()                                                 //create cardFront1
                player1Icons(index: 0, other: false)                                //add icons down
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*3/4), duration: 0.5)                                                   //create move action
                cardFront1Other?.run(action)                                        //run action
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.cardFront1Other?.removeFromParent()                       //dispatchqueue to
                    self?.cardFront1Other = nil                                     //delete items
                }
                cardFront1?.zPosition += 60                                         //raise cardfront1
                if cardFront2 == nil {
                    cardFront2Other?.zPosition -= 60                                //lowers cardFront2Other
                } else {
                    cardFront2?.zPosition -= 60                                     //lowers cardFront2
                }
            } else {
                if cardFront2 == nil {
                    cardFront2Other?.zPosition += 60
                } else {
                    cardFront2?.zPosition += 60
                }
                //the move card to the other array
                let random = Int.random(in:1...player2cards.count-1)
                player2cards.insert(currentCard1, at: random)
                let index = player1cards.firstIndex(of: currentCard1)
                player1cards.remove(at: index!)
                if player1cards.count==2 {
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let gameMenu = GameOver(size: self.size)
                    gameMenu.scaleMode = .aspectFit
                    self.view?.presentScene(gameMenu, transition: transition)
                }
                currentCard1 = player1cards[0]
                
                createPlayer1Other()
                player1Icons(index: 0, other: true)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*3/4), duration: 0.5)
                cardFront1?.run(action)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.cardFront1?.removeFromParent()
                    self?.cardFront1 = nil
                }
                cardFront1Other?.zPosition += 60
                if cardFront2 == nil {
                    cardFront2Other?.zPosition -= 60
                } else {
                    cardFront2?.zPosition -= 60
                }
            }

        } else if giver == 2 {
            if cardFront2 == nil {
                if cardFront1 == nil {
                    cardFront1Other?.zPosition += 60
                } else {
                    cardFront1?.zPosition += 60
                }
                //the move card to the other array
                let random = Int.random(in:1...player1cards.count-1)
                player1cards.insert(currentCard2, at: random)
                let index = player2cards.firstIndex(of: currentCard2)
                player2cards.remove(at: index!)
                if player2cards.count==2 {
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let gameMenu = GameOver(size: self.size)
                    gameMenu.scaleMode = .aspectFit
                    self.view?.presentScene(gameMenu, transition: transition)
                }
                currentCard2 = player2cards[0]
                
                createPlayer2Card()
                player2Icons(index: 0, other: false)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/4), duration: 0.5)
                cardFront2Other?.run(action)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.cardFront2Other?.removeFromParent()
                    self?.cardFront2Other = nil
                }
                cardFront2?.zPosition += 60
                if cardFront1 == nil {
                    cardFront1Other?.zPosition -= 60
                } else {
                    cardFront1?.zPosition -= 60
                }
            } else {
                if cardFront1 == nil {
                    cardFront1Other?.zPosition += 600
                } else {
                    cardFront1?.zPosition += 600
                }
                //the move card to the other array
                let random = Int.random(in:1...player1cards.count-1)
                player1cards.insert(currentCard2, at: random)
                let index = player2cards.firstIndex(of: currentCard2)
                player2cards.remove(at: index!)
                if player2cards.count==2 {
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let gameMenu = GameOver(size: self.size)
                    gameMenu.scaleMode = .aspectFit
                    self.view?.presentScene(gameMenu, transition: transition)
                }
                currentCard2 = player2cards[0]
                
                createPlayer2Other()
                player2Icons(index: 0, other: true)
                let action = SKAction.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/4), duration: 10)
                cardFront2?.run(action)
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
                    self?.cardFront2?.removeFromParent()
                    self?.cardFront2 = nil
                }
                cardFront2Other?.zPosition += 60
                if cardFront1 == nil {
                    cardFront1Other?.zPosition -= 600
                } else {
                    cardFront1?.zPosition -= 600
                }
            }
        }
    }
    
    func uniqueMatch(A:[Int],B:[Int]) -> String {
        if Array(Set(A).intersection(Set(B))).count == 1{
            return String(Array(Set(A).intersection(Set(B)))[0])
        } else {
            return "0"
        }
    }
}
