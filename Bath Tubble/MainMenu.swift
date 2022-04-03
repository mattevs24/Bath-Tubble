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
    var leaderBoard: SKSpriteNode!
    var aboutButton:SKSpriteNode!
                
    override func didMove(to view: SKView) {
        createLogo()
        createButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodesArray = self.nodes(at: location)
        if nodesArray.first?.name == "newGameButton" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: true))
            let gameMenu = GameMenu(size: self.size)
            gameMenu.scaleMode = .aspectFit
            self.view?.presentScene(gameMenu, transition: transition)
        } else if nodesArray.first?.name == "leaderBoard" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            let gameMenu = SettingsMenu(size: self.size)
            run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: true))
            gameMenu.scaleMode = .aspectFit
            self.view?.presentScene(gameMenu, transition: transition)
        } else if nodesArray.first?.name == "AboutButton" {
            let transition = SKTransition.push(with: .left, duration: 0.5)
            let gameMenu = AboutMenu(size: self.size)
            run(SKAction.playSoundFileNamed("swoosh2.caf", waitForCompletion: true))
            gameMenu.scaleMode = .aspectFit
            self.view?.presentScene(gameMenu, transition: transition)
        }
    }
    
    func createLogo() {
        logoSprite = SKSpriteNode(imageNamed: "2")
        logoSprite.position = CGPoint(x: frame.width/2, y: 500)
        logoSprite.size.width = frame.width*4/5
        logoSprite.size.height = frame.width*4/5
        addChild(logoSprite)
        
        //additional settings for logoSprite
    }
    
    func createButtons() {
        newGameButton = SKSpriteNode(imageNamed: "Start")
        newGameButton.position = CGPoint(x: frame.width/2, y: frame.height/2)
        newGameButton.size.width = frame.width/2
        newGameButton.size.height = frame.height/6
        newGameButton.name = "newGameButton"
        addChild(newGameButton)
        
        
        leaderBoard = SKSpriteNode(imageNamed: "Leaderboard")
        leaderBoard.position = CGPoint(x: frame.width/2, y: frame.height/3)
        leaderBoard.size.width = frame.width/2
        leaderBoard.size.height = frame.height/6
        leaderBoard.name = "leaderBoard"
        addChild(leaderBoard)
        
        aboutButton = SKSpriteNode(imageNamed: "About")
        aboutButton.position = CGPoint(x: frame.width/2, y: frame.height/4)
        aboutButton.size.width = frame.width/2
        aboutButton.size.height = frame.height/6
        aboutButton.name = "aboutButton"
        addChild(aboutButton)
    }
}
