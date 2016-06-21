//
//  Player.swift
//  mm2
//
//  Created by John McManus on 10/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Player :GKEntity {
    var playerMovementStateMachine:GKStateMachine!
    var playerJumpStateMachine:GKStateMachine!
    
    let entityManager : EntityManager
    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        playerMovementStateMachine = GKStateMachine(states: [
            PlayerIdle(entity: self),
            PlayerMoveLeft(entity: self),
            PlayerMoveRight(entity: self)])
       
        playerJumpStateMachine = GKStateMachine(states: [
            PlayerJump(entity: self),
            PlayerJumpIdle(entity: self)])
        
        let text = SKTexture(imageNamed: "walkright02")
        //playerStart
        let spNode = entityManager.scene.childNodeWithName("//playerStart")
        
        let spriteComponent = SpriteComponent(entity: self, texture: text, size: CGSize(width: 20.0, height: 65.0), name: "player", position : (spNode?.position)!,scene : entityManager.scene)
        
        spriteComponent.spritenode.physicsBody = SKPhysicsBody(rectangleOfSize: spriteComponent.spritenode.size)
        spriteComponent.spritenode.physicsBody?.categoryBitMask = PhysicsCategory.Player
        spriteComponent.spritenode.physicsBody?.collisionBitMask = 0
        spriteComponent.spritenode.physicsBody?.contactTestBitMask = PhysicsCategory.Nastie | PhysicsCategory.Key | PhysicsCategory.Finish | PhysicsCategory.SinkyFloor
        
        spriteComponent.spritenode.physicsBody?.allowsRotation = false
        spriteComponent.spritenode.physicsBody?.affectedByGravity = false
        spriteComponent.spritenode.physicsBody?.dynamic = true
        
        
        addComponent(spriteComponent)
        let moveComponent = MovePlayerComponent(entity: self)
        addComponent(moveComponent)
        let aniComp = AnimatePlayerComponent(entity: self, scene:  entityManager.scene )
        addComponent(aniComp)
        playerMovementStateMachine.enterState(PlayerIdle)
        playerJumpStateMachine.enterState(PlayerJumpIdle)
        
    
    }
    
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        playerMovementStateMachine.updateWithDeltaTime(seconds)
        playerJumpStateMachine.updateWithDeltaTime(seconds)
    }
    
    
}