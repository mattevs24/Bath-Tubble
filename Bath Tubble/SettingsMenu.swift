//
//  SettingsMenu.swift
//  Bath Tubble
//
//  Created by Matthew Evans on 03/04/2022.
//

import UIKit
import SpriteKit

class SettingsMenu: SKScene {
    var leaderBoard: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        leaderBoard = SKSpriteNode(imageNamed: "")
        leaderBoard.size.width = frame.width*4/5
        leaderBoard.size.height = frame.height*4/5
        addChild(leaderBoard)
    }

}
