//
//  GameMenu.swift
//  Mattble
//
//  Created by Matthew Evans on 02/04/2022.
//

import UIKit
import GameplayKit
import SwiftUI

class GameMenu: SKScene {
    
    var background: SKEmitterNode!
    var gamescene1button: SKSpriteNode!
    var gamesceneAIbutton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createBackground()
        createButtons()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesArray = self.nodes(at: location)
        if nodesArray.first?.name == "multiplayer" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            let gameMenu = GameScene1(size: self.size)
            self.view?.presentScene(gameMenu, transition: transition)
        } else if nodesArray.first?.name == "singleplayer" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            let gameMenu = GameSceneAI(size: self.size)
            self.view?.presentScene(gameMenu, transition: transition)
        }
    }
    
    func createBackground() {
        background = SKEmitterNode(fileNamed: "Starfield.sks")
        background.advanceSimulationTime(10)
        background.position = CGPoint(x: frame.width/2, y: 700)
        background.zPosition = -10
        addChild(background)
    }
    
    func createButtons() {
        // add button for multiplayer - option to be added iwth more development
        //need to add names to these to be able to detect by touch
        
        gamescene1button = SKSpriteNode(imageNamed: "")
        gamesceneAIbutton = SKSpriteNode(imageNamed: "")
        
        gamescene1button.name = "multiplayer"
        gamesceneAIbutton.name = "singleplayer"
        
        gamescene1button.position = CGPoint(x: frame.width/2, y: frame.height/3*2)
        gamesceneAIbutton.position = CGPoint(x: frame.width/2, y: frame.height/3)
        
        gamescene1button.size.width = frame.width/2
        gamescene1button.size.height = frame.height/6
        
        gamesceneAIbutton.size.width = frame.width/2
        gamesceneAIbutton.size.height = frame.height/6
        
        addChild(gamescene1button)
        addChild(gamesceneAIbutton)
    }
}
