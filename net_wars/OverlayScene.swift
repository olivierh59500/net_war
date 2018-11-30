//
//  OverlayScene.swift
//  net_wars
//
//  Created by Estuardo Valenzuela on 11/29/18.
//  Copyright © 2018 Estuardo Valenzuela. All rights reserved.
//

import SpriteKit
import UIKit

class OverlayScene: SKScene {
    var hudNode: SKSpriteNode!
    var fireNode: SKSpriteNode!
    var boostNode: SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = UIColor.clear
        
        // HUD
        self.hudNode = SKSpriteNode(imageNamed: "art.scnassets/hud.png")
            self.hudNode.size = CGSize(width: self.frame.width, height: self.frame.height)
            self.hudNode.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
            self.addChild(self.hudNode)
        
        // Fire button
        self.fireNode = SKSpriteNode(imageNamed: "art.scnassets/firebutton.png")
        
        // Boost button
        self.fireNode = SKSpriteNode(imageNamed: "art.scnassets/boostbutton.png")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
