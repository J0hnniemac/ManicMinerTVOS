//
//  PlayerJump.swift
//  mm2
//
//  Created by John McManus on 11/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit


class PlayerJumpIdle : GKState {
    var entity: Player
    required init(entity: Player) {
        self.entity = entity
    }
    override func didEnterWithPreviousState(previousState: GKState?) {
        print("back to jumpidle")
        
        
    }
    
    
}
class PlayerJump : GKState {
    var jumpTime :NSTimeInterval = 0.8
    var lastTime :NSTimeInterval = 0.0

    var entity: Player
    required init(entity: Player) {
        self.entity = entity
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        lastTime = 0
        
                
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        
        lastTime = lastTime + seconds
        if lastTime > jumpTime {
        
            
            entity.playerJumpStateMachine.enterState(PlayerJumpIdle)
            
        }
        
    }
    
}