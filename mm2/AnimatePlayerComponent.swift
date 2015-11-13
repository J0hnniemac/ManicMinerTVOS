//
//  AnimatePlayerComponent.swift
//  mm2
//
//  Created by John McManus on 12/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum AnimationState: String {
    case Idle = "Idle"
    case WalkRight = "WalkRight"
    case WalkLeft = "WalkLeft"
    case JumpUp = "JumpUp"
    case JumpRight = "JumpRight"
    case JumpLeft = "JumpLeft"
}

//setup the Animationn Frames




class AnimatePlayerComponent: GKComponent {
    /// The animation state represented in this animation.
    let animationState: AnimationState
    let node: SKSpriteNode
    let scene: LevelScene
    var requestedAnimationState: AnimationState?
    var walkLeftTextures = [SKTexture]()
    var walkRightTextures = [SKTexture]()
    var walkLeftAnim :SKAction!
    var walkRightAnim :SKAction!
    
    var jumpLeftAnim :SKAction!
    var jumpRightAnim :SKAction!
    var jumpUpAnim :SKAction!
    init(entity: Player, scene : LevelScene) {
        
        node = entity.componentForClass(SpriteComponent)!.spritenode
        self.scene = scene
        animationState = .Idle
        //node.node.position
        super.init()
        self.setupTextures()
        self.createAnim()
    }
    
    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        //based on speed move character.
        if let animationState = requestedAnimationState {
            print ("Run Animation:\(animationState)")
            runAnim(animationState)
            requestedAnimationState = nil
        }
        
        checkForCollisions()
    }
    
    func setupTextures(){
        
        walkLeftTextures.append(SKTexture(imageNamed: "walkleft01"))
        walkLeftTextures.append(SKTexture(imageNamed: "walkleft02"))
        walkLeftTextures.append(SKTexture(imageNamed: "walkleft03"))
        walkLeftTextures.append(SKTexture(imageNamed: "walkleft04"))
        walkLeftTextures.append(SKTexture(imageNamed: "walkleft03"))
        walkLeftTextures.append(SKTexture(imageNamed: "walkleft02"))
        
        walkRightTextures.append(SKTexture(imageNamed: "walkright01"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright02"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright03"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright04"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright03"))
        walkRightTextures.append(SKTexture(imageNamed: "walkright02"))
        
        
        
        
        
    }
    
    func createAnim(){
        
        let a1 = SKAction.animateWithTextures(walkLeftTextures, timePerFrame: 0.2)
        let r1 = SKAction.repeatActionForever(a1)
        walkLeftAnim = r1
        
        
        
        let a2 = SKAction.animateWithTextures(walkRightTextures, timePerFrame: 0.2)
        let r2 = SKAction.repeatActionForever(a2)
        walkRightAnim = r2
        
        
        let jl1 = SKAction.moveByX(-50, y: 90, duration: 0.5)
        let jl2 = SKAction.moveByX(-50, y: -90, duration: 0.5)
        let jl1seq = SKAction.sequence([jl1,jl2])
        let grp1 = SKAction.group([jl1seq, a1])
        
        jumpLeftAnim = grp1
        
        let jr1 = SKAction.moveByX(50, y: 90, duration: 0.5)
        let jr2 = SKAction.moveByX(50, y: -90, duration: 0.5)
        let jr1seq = SKAction.sequence([jr1,jr2])
        let grp2 = SKAction.group([jr1seq, a2])
        
        jumpRightAnim = grp2
        
        
        
        let ju1 = SKAction.moveByX(0, y: 90, duration: 0.5)
        let ju2 = SKAction.moveByX(0, y: -90, duration: 0.5)
        jumpUpAnim = SKAction.sequence([ju1,ju2])
        //walkRightAnim = SKAction.moveByX(0, y: 30, duration: 2)
        
    }
    
    
    func runAnim(animationState :AnimationState){
        print(__FUNCTION__)
        print(animationState)
        switch(animationState){
        case .Idle:
            runIdleAnim()
        case .WalkLeft:
            runWalkLeftAnim()
        case .WalkRight:
            runWalkRightAnim()
        case .JumpRight:
            doJumpRightAnim()
        case .JumpLeft:
            doJumpLeftAnim()
        case .JumpUp:
            doJumpUpAnim()
        }
    }
    
    func runIdleAnim(){
        print(__FUNCTION__)
        node.removeActionForKey("walkleft")
        node.removeActionForKey("walkright")
        
    }
    func runWalkLeftAnim(){
        print(__FUNCTION__)
        
        if !node.hasActions() {
            node.runAction(walkLeftAnim, withKey: "walkleft")
            
        }else {
            if let _ = node.actionForKey("walkright")  {
                node.removeActionForKey("walkright")
                node.runAction(walkLeftAnim, withKey: "walkleft")
            }
        }
        
    }
    func runWalkRightAnim(){
        print(__FUNCTION__)
        if !node.hasActions() {
            node.runAction(walkRightAnim, withKey: "walkright")
        } else {
            
            if let _ = node.actionForKey("walkleft"){
                node.removeActionForKey("walkleft")
                node.runAction(walkRightAnim, withKey: "walkright")
            }
        }
    }
    
    func doJumpUpAnim(){
     print(__FUNCTION__)
            if !node.hasActions() {
                node.runAction(jumpUpAnim, withKey: "jumpup")
            }
        
    }
    func doJumpLeftAnim(){
 print(__FUNCTION__)
        if let _ = node.actionForKey("walkleft"){
            node.removeActionForKey("walkleft")
            node.runAction(jumpLeftAnim, withKey: "jumpleft")
        }
        


    }
    func doJumpRightAnim(){
         print(__FUNCTION__)
        if let _ = node.actionForKey("walkright"){
        node.removeActionForKey("walkright")
        node.runAction(jumpRightAnim, withKey: "jumpright")
        }
    }
    
    func checkForCollisions(){
    
    //check below player to stop falling when moving down.
        
        // get the bottom of player
        let y = node.position.y - (node.size.height / 2)
        let xLeft = node.position.x - (node.size.width / 2)
        let xRight = node.position.x + (node.size.width / 2)
        
        let pointsToCheck = [CGPoint(x: xLeft, y: y),CGPoint(x: node.position.x, y: y),CGPoint(x: xRight, y: y)]
        
    
        for coord in pointsToCheck {
        
        let nodes = scene.nodesAtPoint(coord)
        
            for checkNode in nodes {
            
                if checkNode.name == "floor" {
                    print("stop fall")
                    
                    node.removeActionForKey("jumpright")
                    node.removeActionForKey("jumpleft")
                    node.removeActionForKey("jumpup")
                    

                }
            
            }
        
        }
        
    }
    
}
