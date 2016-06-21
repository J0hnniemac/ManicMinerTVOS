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
    init(scene: LevelScene) {
        self.scene = scene
    }
    func add(entity: GKEntity) {
        entities.insert(entity)
    }
    func remove(entity: GKEntity) {
        if let spriteNode = entity.componentForClass(SpriteComponent.self)?.spritenode {
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
    }
    

}