//
//  MoveHorizontalNastie.swift
//  mm2
//
//  Created by John McManus on 14/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit
import SpriteKit
class MoveHorizontalNastieComponent: GKComponent {
    let node: SKSpriteNode
    let scene: LevelScene
    let leftRange :Int
    let rightRange :Int
    var leftPoint :CGPoint
    var rightPoint :CGPoint
    var speed : CGFloat
    
    init(entity: HorizontalEnemy, scene : LevelScene) {
        
        node = entity.componentForClass(SpriteComponent)!.spritenode
        self.scene = scene
     
        leftRange = entity.nastie.rangeofMovementLU
        rightRange = entity.nastie.rangeofMovementRD
        speed = CGFloat(entity.nastie.speed)
        let lTiming = CGFloat(leftRange) / (CGFloat(leftRange) + CGFloat(rightRange))
        
        let rTiming = CGFloat(rightRange) / (CGFloat(leftRange) + CGFloat(rightRange))
        
        let lDuration = speed * lTiming
        let rDuration = speed * rTiming
        
        let startPoint = node.position
        leftPoint = node.position
        rightPoint = node.position
        
        leftPoint.x = leftPoint.x - CGFloat(leftRange)
        rightPoint.x = rightPoint.x + CGFloat(rightRange)
        super.init()
        let mv1 = SKAction.moveTo(leftPoint, duration: Double(lDuration))
        let mv11 = SKAction.moveTo(startPoint, duration: Double(lDuration))
        
        let lAni = SKAction.runBlock({self.flipAnimLeft()})
        let rAni = SKAction.runBlock({self.flipAnimRight()})
        
        
        let mv2 = SKAction.moveTo(rightPoint, duration: Double(rDuration))
        let mv22 = SKAction.moveTo(startPoint, duration: Double(rDuration))
        let seq = SKAction.sequence([mv1,rAni,mv11,mv2,lAni,mv22])
        let rep = SKAction.repeatActionForever(seq)
        node.runAction(rep)
        //node.node.position
        
    }
    

    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        
        
    }

    func flipAnimLeft(){
    print(__FUNCTION__)
        //player.componentForClass(MovePlayerComponent)?.moveLeft()
        entity?.componentForClass(AnimateNastiesComponent)?.requestedAnimationState = .MovingLeft
        
        
    }
    
    func flipAnimRight(){
        print(__FUNCTION__)
        entity?.componentForClass(AnimateNastiesComponent)?.requestedAnimationState = .MovingRight
    }
}