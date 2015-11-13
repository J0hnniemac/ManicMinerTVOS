//
//  PlayerJump.swift
//  mm2
//
//  Created by John McManus on 11/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit

class PlayerJumpUp : GKState {
    var entity: Player
        required init(entity: Player) {
        self.entity = entity
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState != AnimationState.Idle {
            entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState = AnimationState.JumpUp
            print("StateMachine:JumpUp")
        }
        
    }
}

class PlayerJumpLeft : GKState {
    var entity: Player
    required init(entity: Player) {
        self.entity = entity
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState != AnimationState.Idle {
            entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState = AnimationState.JumpLeft
            print("StateMachine:JumpLeft")
        }
        
    }
    
    
}

class PlayerJumpRight : GKState {
    var entity: Player
    required init(entity: Player) {
        self.entity = entity
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        if entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState != AnimationState.Idle {
            entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState = AnimationState.JumpRight
            print("StateMachine:JumpRight")
        }
        
    }
    
    
}