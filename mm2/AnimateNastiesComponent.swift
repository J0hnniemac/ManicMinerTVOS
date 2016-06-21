//
//  AnimateNastiesComponent.swift
//  mm2
//
//  Created by John McManus on 14/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum HorizontalNastiesAnimationState: String {
    case MovingRight = "MovingRight"
    case MovingLeft = "MovingLeft"
    case Idle = "Idle"
}





class AnimateNastiesComponent: GKComponent {
    /// The animation state represented in this animation.
    let animationState: HorizontalNastiesAnimationState
    let node: SKSpriteNode
    let scene: LevelScene
    var requestedAnimationState: HorizontalNastiesAnimationState?
    
    var moveLeftTextures = [SKTexture]()
    var moveRightTextures = [SKTexture]()
    var moveLeftAnim :SKAction!
    var moveRightAnim :SKAction!
    let HEentity :HorizontalEnemy
    init(entity: HorizontalEnemy, scene : LevelScene) {
        self.HEentity = entity
        node = entity.componentForClass(SpriteComponent)!.spritenode
        self.scene = scene
        animationState = .Idle
        //node.node.position
        super.init()
        self.setupTextures()
        self.createAnim()
    }
    func setupTextures(){
        for textName in HEentity.nastie.LUTextureList {
            moveLeftTextures.append(SKTexture(imageNamed: textName))
        }
        for textName in HEentity.nastie.RDTextureList {
            moveRightTextures.append(SKTexture(imageNamed: textName))
        }
    }
    func createAnim(){
        let a1 = SKAction.animateWithTextures(moveLeftTextures, timePerFrame: 0.2)
        let r1 = SKAction.repeatActionForever(a1)
        moveLeftAnim = r1
        let a2 = SKAction.animateWithTextures(moveRightTextures, timePerFrame: 0.2)
        let r2 = SKAction.repeatActionForever(a2)
        moveRightAnim = r2
        
    }
    
    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        //print ("Nastie Animation:\(animationState)")
        //based on speed move character.
        if let animationState = requestedAnimationState {
            print ("Run Animation:\(animationState)")
            runAnim(animationState)
            requestedAnimationState = nil
        }
        
        
        
        
        
        //checkForCollisions()
    }
    func runAnim(animationState :HorizontalNastiesAnimationState){
        print(__FUNCTION__)
        print(animationState)
        switch(animationState){
        case .Idle:
            runIdleAnim()
        case .MovingLeft:
            runLeftAnim()
        case .MovingRight:
            runRightAnim()
        }
    }
    func runIdleAnim(){
        print(__FUNCTION__)
        node.removeActionForKey("walkleft")
        node.removeActionForKey("walkright")
        
    }
    func runLeftAnim(){
        print(__FUNCTION__)
        node.removeActionForKey("moveright")
        node.removeActionForKey("moveleft")
        node.runAction(moveLeftAnim, withKey: "moveleft")
        
    }
    func runRightAnim(){
        print(__FUNCTION__)
        node.removeActionForKey("moveright")
        node.removeActionForKey("moveleft")
        node.runAction(moveRightAnim, withKey: "moveright")
        
    }


}