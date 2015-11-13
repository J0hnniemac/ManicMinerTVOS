//
//  SpriteComponent.swift
//  mm2
//
//  Created by John McManus on 10/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

//class EntityNode: SKSpriteNode {
//  weak var entity: GKEntity!
//}


class SpriteComponent: GKComponent {
  //  var walkRightTextures = [SKTexture]()
    let spritenode: SKSpriteNode
    init(entity: GKEntity, texture: SKTexture, size: CGSize, name: String) {
        spritenode = SKSpriteNode(texture: texture, size: size)
        
        
        
        spritenode.name = name
       /*
        walkRightTextures.append(SKTexture(imageNamed: "walkright01"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright02"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright03"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright04"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright03"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright02"))

        let a1 = SKAction.animateWithTextures(walkRightTextures, timePerFrame: 0.2)
        
        node.runAction(SKAction.repeatActionForever(a1))
        */
    }
    
    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        
    }

}
