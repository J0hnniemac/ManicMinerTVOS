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
    init(entity: GKEntity, texture: SKTexture, size: CGSize, name: String, position :CGPoint, scene : SKScene) {
        spritenode = SKSpriteNode(texture: texture, size: size)
        spritenode.position = position
        spritenode.name = name
        
        scene.addChild(spritenode)
        //if let spawnNode = entity.scene.childNodeWithName("//playerStart"){
         //   spriteNode.position = spawnNode.position

          }
    
    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        
    }

}
