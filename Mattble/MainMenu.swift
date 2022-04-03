//
//  MainMenu.swift
//  Mattble
//
//  Created by Matthew Evans on 02/04/2022.
//

import UIKit
import GameplayKit
import SwiftUI
import UIKit

//need to add textures thorughout! just left blacnk for now


class MainMenu: SKScene {
    
    var background: SKEmitterNode!
    var logoSprite: SKSpriteNode!
    var newGameButton: SKSpriteNode!
    var settingsMenuButton: SKSpriteNode!
                
    override func didMove(to view: SKView) {
        createBackground()
        createLogo()
        createButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesArray = self.nodes(at: location)
        if nodesArray.first?.name == "newGameButton" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
            let gameMenu = GameMenu(size: self.size)
            gameMenu.scaleMode = .aspectFit
            self.view?.presentScene(gameMenu, transition: transition)
        } else if nodesArray.first?.name == "settingsMenuButton" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            let gameMenu = SettingsMenu(size: self.size)
            run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: false))
            gameMenu.scaleMode = .aspectFit
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
    
    func createLogo() {
        logoSprite = SKSpriteNode(imageNamed: "")
        logoSprite.position = CGPoint(x: frame.width/2, y: 500)
        logoSprite.size.width = frame.width/2
        logoSprite.size.height = frame.height/4
        addChild(logoSprite)
        
        //additional settings for logoSprite
    }
    
    func createButtons() {
        newGameButton = SKSpriteNode(imageNamed: "")
        newGameButton.position = CGPoint(x: frame.width/2, y: frame.height/2)
        newGameButton.size.width = frame.width/2
        newGameButton.size.height = frame.height/6
        newGameButton.name = "newGameButton"
        addChild(newGameButton)
        
        
        settingsMenuButton = SKSpriteNode(imageNamed: "")
        settingsMenuButton.position = CGPoint(x: frame.width/2, y: frame.height/3)
        settingsMenuButton.size.width = frame.width/2
        settingsMenuButton.size.height = frame.height/6
        settingsMenuButton.name = "settingsMenuButton"
        addChild(settingsMenuButton)
    }
}
