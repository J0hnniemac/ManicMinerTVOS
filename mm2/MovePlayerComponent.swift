//
//  MovePlayerComponent.swift
//  mm2
//
//  Created by John McManus on 11/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//


import Foundation
import SpriteKit
import GameplayKit

//class EntityNode: SKSpriteNode {
//  weak var entity: GKEntity!
//}

class MovePlayerComponent: GKComponent {
    let node: SpriteComponent
    let moveStateMachine :GKStateMachine
    
    let speed :CGFloat = 24.0 //pixels per second
    init(entity: Player) {
        
        node = entity.componentForClass(SpriteComponent)!
        self.moveStateMachine = entity.playerMovementStateMachine
        //node.node.position
    }
    
    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        //based on speed move character.
        
        let deltaX :CGFloat = CGFloat(deltaTime) * speed
        
        if moveStateMachine.currentState is PlayerMoveLeft {
            if node.spritenode.position.x > 30{
                node.spritenode.position.x = node.spritenode.position.x - deltaX
            }
        }
        
        if moveStateMachine.currentState is PlayerMoveRight {
            // print("PlayerMoveRight")
            if node.spritenode.position.x < 800{
                node.spritenode.position.x = node.spritenode.position.x + deltaX
            }
        }
    }
    func moveLeft (){
        print(__FUNCTION__)
        moveStateMachine.enterState(PlayerMoveLeft)
    }
    
    func moveRight(){
        print(__FUNCTION__)
        moveStateMachine.enterState(PlayerMoveRight)
    }
    func moveJump(){
        print(__FUNCTION__)
        
        switch (moveStateMachine.currentState) {
        case is PlayerMoveLeft:
            moveStateMachine.enterState((PlayerJumpLeft))
        case is PlayerMoveRight:
            moveStateMachine.enterState((PlayerJumpRight))
        case is PlayerIdle:
            moveStateMachine.enterState((PlayerJumpUp))
        default:
            break
        }
       // moveStateMachine.enterState((PlayerJumpUp))
    }
    
}
