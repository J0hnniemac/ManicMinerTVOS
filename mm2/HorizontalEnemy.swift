//
//  HorizontalEnemy.swift
//  mm2
//
//  Created by John McManus on 14/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

class HorizontalEnemy :GKEntity {
    
    let entityManager : EntityManager
    let nastie : LevelConfigurationInfo.nastiesConfiguration
    init(entityManager: EntityManager, nastie : LevelConfigurationInfo.nastiesConfiguration) {
            self.entityManager = entityManager
        self.nastie = nastie
        super.init()
        let text = SKTexture(imageNamed: nastie.LUTextureList[0])
        
        let spsearch = "//\(nastie.spawnPointName)"
        print("sp:\(spsearch)")
            
        
            
        let spNode = entityManager.scene.childNodeWithName(spsearch)
        
        let spriteComponent = SpriteComponent(entity: self, texture: text, size: CGSize(width: 20.0, height: 65.0), name: nastie.name, position :(spNode?.position)!,scene : entityManager.scene)
        addComponent(spriteComponent)
        spriteComponent.spritenode.physicsBody = SKPhysicsBody(rectangleOfSize: spriteComponent.spritenode.size)
        spriteComponent.spritenode.physicsBody?.categoryBitMask = PhysicsCategory.Nastie
        spriteComponent.spritenode.physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Key | PhysicsCategory.Finish
        spriteComponent.spritenode.physicsBody?.allowsRotation = false
        spriteComponent.spritenode.physicsBody?.affectedByGravity = false

        
        let hzmove = MoveHorizontalNastieComponent(entity: self, scene: entityManager.scene)
        addComponent(hzmove)
        
        let hzani = AnimateNastiesComponent(entity: self, scene: entityManager.scene)
        addComponent(hzani)
        
        
    }
    
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        
    }
    
    
}
