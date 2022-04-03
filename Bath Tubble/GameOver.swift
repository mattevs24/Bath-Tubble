//
//  GameOver.swift
//  Mattble
//
//  Created by Matthew Evans on 02/04/2022.
//

import UIKit
import SpriteKit

class GameOver: SKScene {
    //MARK: - Properties
    var gameOverSign: SKSpriteNode!
    var label1: SKLabelNode!
    var label2: SKLabelNode!
    var returntoMenu: SKSpriteNode!
    
    var winner: Int = 1
    var score: Int = Int.random(in: 2000...5000)
    
    override func didMove(to view: SKView) {
        createLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesArray = self.nodes(at: location)
        if nodesArray.first?.name == "return" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            let gameMenu = MainMenu(size: self.size)
            run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
            gameMenu.scaleMode = .aspectFit
            self.view?.presentScene(gameMenu, transition: transition)
        }
    }
    
    /*
     
     func createBackground() {
     
     }
     
     */
    
    func createLabels() {
        gameOverSign = SKSpriteNode(imageNamed: "gameover")
        gameOverSign.size = CGSize(width: 200, height: 150)
        gameOverSign.position = CGPoint(x: frame.width/2, y: frame.height*4/5)
        addChild(gameOverSign)
        
        label1 = SKLabelNode(text: winner == 1 ? "Player 1 Wins!" : "Player 2 Wins!")
        label1.fontSize = 55
        label1.position = CGPoint(x: frame.width/2, y: frame.height*8/14)
        addChild(label1)
        
        label2 = SKLabelNode(text: "Score: \(score)")
        label2.fontSize = 55
        label2.position = CGPoint(x: frame.width/2, y: frame.height*7/14)
        addChild(label2)
        
        returntoMenu = SKSpriteNode(imageNamed: "")
        returntoMenu.name = "return"
        returntoMenu.size = CGSize(width: 200, height: 80)
        returntoMenu.position = CGPoint(x: frame.width/2, y: frame.height*6/14-30)
        addChild(returntoMenu)
        
        //need to add additional support for uiview leaderboard
    }
}
