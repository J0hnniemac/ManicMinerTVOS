//
//  PlayerMoveLeft.swift
//  mm2
//
//  Created by John McManus on 11/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit

class PlayerMoveLeft :  GKState {
    
    unowned var entity: Player
    
    var animationComponent: AnimatePlayerComponent {
        guard let animationComponent = entity.componentForClass(AnimatePlayerComponent.self) else { fatalError("Player entity must have an AnimationComponent.") }
        return animationComponent
    }
    required init(entity: Player) {
        self.entity = entity
        
        
        
        
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        animationComponent.requestedAnimationState = AnimationState.WalkLeft
        print("StateMachine:WalkLeft")
    }
    
    
}