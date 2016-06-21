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
    // let moveStateMachine :GKStateMachine
    //  let jumpStateMachine :GKStateMachine
    let speed :CGFloat = 50.0 //pixels per second
    
    var grounded = false
    
    var gravity :CGFloat = 90.0
    var jumpForce :CGFloat = 200.0
    var jumpEnded = true
    
    // let scene : LevelScene
    let player : Player
    init(entity: Player) {
        self.player = entity
        node = entity.componentForClass(SpriteComponent)!
        
        //   self.moveStateMachine = entity.playerMovementStateMachine
        //  self.jumpStateMachine = entity.playerJumpStateMachine
        //node.node.position
    }
    
    override func updateWithDeltaTime(deltaTime: NSTimeInterval) {
        super.updateWithDeltaTime(deltaTime)
        //based on speed move character.
        
        let deltaX :CGFloat = CGFloat(deltaTime) * speed
        
        if player.playerMovementStateMachine.currentState is PlayerMoveLeft {
            node.spritenode.position.x = node.spritenode.position.x - deltaX
        }
        
        if player.playerMovementStateMachine.currentState is PlayerMoveRight {
            
            node.spritenode.position.x = node.spritenode.position.x + deltaX
        }
        
        
        if (!grounded || player.playerJumpStateMachine.currentState is PlayerJump)  && node.spritenode.position.y > 0{
            
            //apply gravity
            
            if jumpEnded {
                if !(player.playerMovementStateMachine.currentState is PlayerIdle) {
                    player.playerMovementStateMachine.enterState(PlayerIdle)
                                    }
            }
            
            let deltaY :CGFloat = CGFloat(deltaTime) * gravity
            node.spritenode.position.y = node.spritenode.position.y - deltaY
            grounded = false
        }
        
        
        if player.playerJumpStateMachine.currentState is PlayerJump {
            
            let deltaY :CGFloat = CGFloat(deltaTime) * jumpForce
            node.spritenode.position.y = node.spritenode.position.y + deltaY
            
        }
        
        checkForCollisions()
        
    }
    func moveLeft (){
        print(__FUNCTION__)
        player.playerMovementStateMachine.enterState(PlayerMoveLeft)
    }
    
    func moveRight(){
        print(__FUNCTION__)
        player.playerMovementStateMachine.enterState(PlayerMoveRight)
    }
    func moveJump(){
        print(__FUNCTION__)
        if !(player.playerJumpStateMachine.currentState is  PlayerJump) && grounded {
            player.playerJumpStateMachine.enterState((PlayerJump))
            jumpEnded = false
            
            //    grounded = false
            //   print("try and jump")
            
        }
        // moveStateMachine.enterState((PlayerJumpUp))
    }
    
    
    func checkForCollisions(){
    
        if !(player.playerJumpStateMachine.currentState is  PlayerJump) {
            checkBottomOfPlayer()
        }
        
        checkRightOfPlayer()
        checkLeftOfPlayer()
   // checkPlayer()
    }
    
    
    
    func checkBottomOfPlayer(){
    
    //bottom of player
        let y = node.spritenode.position.y - (node.spritenode.size.height / 2)
        let xLeft = node.spritenode.position.x - (node.spritenode.size.width / 2)
        let xRight = node.spritenode.position.x + (node.spritenode.size.width / 2)
        
        let pointsToCheck = [CGPoint(x: xLeft, y: y),CGPoint(x: node.spritenode.position.x, y: y),CGPoint(x: xRight, y: y)]
   
        
        grounded = false
        for coord in pointsToCheck {
            let nodes = player.entityManager.scene.nodesAtPoint(coord)
            for checkNode in nodes {
                
                if checkNode.name?.rangeOfString("floor") != nil {
                    if !grounded {grounded = true
                    jumpEnded = true
                    }
                }
                if checkNode.name?.rangeOfString("hwall") != nil {
                    if !grounded {grounded = true
                    jumpEnded = true}
                }
                if checkNode.name?.rangeOfString("vwall") != nil {
                    if !grounded {grounded = true
                    jumpEnded = true}
                    //on a wall
                }
                
            }
        }

    
    
    
    
    }
    
    
    func checkRightOfPlayer(){
        
        let yBottom = node.spritenode.position.y - (node.spritenode.size.height / 2) + 3
        let yTop = node.spritenode.position.y + (node.spritenode.size.height / 2)
        let xRight = node.spritenode.position.x + (node.spritenode.size.width / 2)
        
        let y1 = node.spritenode.position.y - (node.spritenode.size.height / 3)
        let y2 = node.spritenode.position.y + (node.spritenode.size.height / 3)
        let rightPointsToCheck = [CGPoint(x: xRight, y: yTop),CGPoint(x: xRight, y: yBottom),CGPoint(x: xRight, y: y1),CGPoint(x: xRight, y: y2)]
//        let rightPointsToCheck = [CGPoint(x: xRight, y: yTop),CGPoint(x: xRight, y: y1),CGPoint(x: xRight, y: y2)]
        for coord in rightPointsToCheck {
            let nodes = player.entityManager.scene.nodesAtPoint(coord)
            
            for checkNode in nodes {
                if checkNode.name?.rangeOfString("vwall") != nil {
                    print("stop right wall")
                    
                    player.playerMovementStateMachine.enterState(PlayerIdle)
                    jumpEnded = true
                    player.playerJumpStateMachine.enterState(PlayerJumpIdle)
                    node.spritenode.position.x = node.spritenode.position.x - 1
                }
            }
        }
    }
    
    
    func checkLeftOfPlayer(){
        
        let yBottom = node.spritenode.position.y - (node.spritenode.size.height / 2) + 3
        let yTop = node.spritenode.position.y + (node.spritenode.size.height / 2)
        let xLeft = node.spritenode.position.x - (node.spritenode.size.width / 2)
        
        let y1 = node.spritenode.position.y - (node.spritenode.size.height / 3)
        let y2 = node.spritenode.position.y + (node.spritenode.size.height / 3)
        let leftPointsToCheck = [CGPoint(x: xLeft, y: yTop),CGPoint(x: xLeft, y: yBottom),CGPoint(x: xLeft, y: y1),CGPoint(x: xLeft, y: y2)]
        //        let rightPointsToCheck = [CGPoint(x: xRight, y: yTop),CGPoint(x: xRight, y: y1),CGPoint(x: xRight, y: y2)]
        for coord in leftPointsToCheck {
            let nodes = player.entityManager.scene.nodesAtPoint(coord)
            
            for checkNode in nodes {
                if checkNode.name?.rangeOfString("vwall") != nil {
                    print("stop right wall")
                    
                    player.playerMovementStateMachine.enterState(PlayerIdle)
                    jumpEnded = true
                    player.playerJumpStateMachine.enterState(PlayerJumpIdle)
                    node.spritenode.position.x = node.spritenode.position.x + 1
                }
            }
        }
    }

    
    
    
    func checkPlayer(){
        
        let levelnode = player.entityManager.scene.childNodeWithName("//levelLayout")
        
        let levelobjects = levelnode?.children
        for obj in levelobjects! {
        
            if CGRectIntersectsRect(node.spritenode.frame, obj.frame){
            
                print("player is touching :\(obj.name))")
                
            
                
                // are we standing on top
                
                let y = node.spritenode.position.y - (node.spritenode.size.height / 2)
                let xLeft = node.spritenode.position.x - (node.spritenode.size.width / 2)
                let xRight = node.spritenode.position.x + (node.spritenode.size.width / 2)
                
                
                let oy = obj.position.y + (obj.position.y / 2)
                let oxLeft = obj.position.x - (obj.position.x / 2)
                let oxRight = obj.position.x + (obj.position.x / 2)
                
                if y >= oy {
                    print("above")
                
                    if (xLeft >= oxLeft && xLeft <= oxRight ) || (xRight >= oxLeft && xRight <= oxRight ) {
                    print("also in x axis")
                    grounded = true
                    }
                }
                
                
                
            }
        
        
        
        }
        
    }
    
    
    
    
   }
