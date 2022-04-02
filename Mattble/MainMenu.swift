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
        //placeholder
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
        addChild(newGameButton)
        
        
        settingsMenuButton = SKSpriteNode(imageNamed: "")
        settingsMenuButton.position = CGPoint(x: frame.width/2, y: frame.height/3)
        settingsMenuButton.size.width = frame.width/2
        settingsMenuButton.size.height = frame.height/6
        addChild(settingsMenuButton)
    }
}
