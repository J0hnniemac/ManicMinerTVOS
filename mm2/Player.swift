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
    init(entityManager: EntityManager) {
        super.init()
        playerMovementStateMachine = GKStateMachine(states: [
            PlayerIdle(entity: self),
            PlayerMoveLeft(entity: self),
            PlayerMoveRight(entity: self),
            PlayerJumpUp(entity: self),
            PlayerJumpLeft(entity: self),
            PlayerJumpRight(entity: self)])
       
        
        let text = SKTexture(imageNamed: "walkright02")
        let spriteComponent = SpriteComponent(entity: self, texture: text, size: CGSize(width: 20.0, height: 65.0), name: "player")
        addComponent(spriteComponent)
        let moveComponent = MovePlayerComponent(entity: self)
        addComponent(moveComponent)
        let aniComp = AnimatePlayerComponent(entity: self, scene:  entityManager.scene )
        addComponent(aniComp)
        playerMovementStateMachine.enterState(PlayerIdle)
        
        
        print(self)
    }
    
    
    
    
    
}