//
//  EntityManager.swift
//  mm2
//
//  Created by John McManus on 10/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import Foundation
import SpriteKit
import GameplayKit

class EntityManager {
    
    var entities = Set<GKEntity>()
    let scene: LevelScene
    
    //lazy var componentSystems: [GKComponentSystem] = {
    //  let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
    // let meleeSystem = GKComponentSystem(componentClass: MeleeComponent.self)
    //let firingSystem = GKComponentSystem(componentClass: FiringComponent.self)
    //let castleSystem = GKComponentSystem(componentClass: CastleComponent.self)
    //let aiSystem = GKComponentSystem(componentClass: AiComponent.self)
    //return [moveSystem, meleeSystem, firingSystem, castleSystem, aiSystem]
    //}()
    
    
    init(scene: LevelScene) {
        self.scene = scene
        
    }

    
    func add(entity: GKEntity) {
        entities.insert(entity)
        
        if let spriteNode = entity.componentForClass(SpriteComponent.self)?.spritenode {
            if spriteNode.name == "player" {
                if let spawnNode = scene.childNodeWithName("//playerStart"){
                    spriteNode.position = spawnNode.position
                } else {
                    print("could not find playerStart")
                    spriteNode.position = CGPoint(x: 100.0, y: 100.0)
                }
            }
            if spriteNode.name == "robot1" {
                if let spawnNode = scene.childNodeWithName("//robotStart"){
                    spriteNode.position = spawnNode.position
                } else {
                    print("could not find robotStart")
                    spriteNode.position = CGPoint(x: 100.0, y: 100.0)
                }
            }
            
            
            scene.addChild(spriteNode)
        }
        
        
    }
    
    func remove(entity: GKEntity) {
        
        if let spriteNode = entity.componentForClass(SpriteComponent.self)?.spritenode {
            spriteNode.removeFromParent()
        }
        
        //   toRemove.insert(entity)
        entities.remove(entity)
    }

    
    
    

}