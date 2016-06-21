//
//  PlayerIdle.swift
//  mm2
//
//  Created by John McManus on 11/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit

class PlayerIdle : GKState {
    
    var entity: Player
    
    required init(entity: Player) {
        self.entity = entity
      


}

    override func didEnterWithPreviousState(previousState: GKState?) {
        
        if entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState != AnimationState.Idle {
                entity.componentForClass(AnimatePlayerComponent.self)?.requestedAnimationState = AnimationState.Idle
            print("StateMachine:Idle")
        }
        
    }


}