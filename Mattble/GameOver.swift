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
            self.view?.presentScene(gameMenu, transition: transition)
        }
    }
    
    /*
     
     func createBackground() {
     
     }
     
     */
    
    func createLabels() {
        gameOverSign = SKSpriteNode(imageNamed: "")
        gameOverSign.size = CGSize(width: 200, height: 150)
        gameOverSign.position = CGPoint(x: frame.width/2, y: frame.height*4/5)
        addChild(gameOverSign)
        
        label1 = SKLabelNode(text: "shdflkjahsfdlk")
        label1.fontSize = 70
        label1.position = CGPoint(x: frame.width/2, y: frame.height*8/14)
        addChild(label1)
        
        label2 = SKLabelNode(text: "asdlkjfhalskdf")
        label2.fontSize = 70
        label2.position = CGPoint(x: frame.width/2, y: frame.height*7/14)
        addChild(label2)
        
        returntoMenu = SKSpriteNode(imageNamed: "")
        returntoMenu.name = "return"
        returntoMenu.size = CGSize(width: 200, height: 80)
        returntoMenu.position = CGPoint(x: frame.width/2, y: frame.height*6/14)
        addChild(returntoMenu)
        
        //need to add additional support for uiview leaderboard
    }
}
