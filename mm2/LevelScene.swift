//
//  LevelScene.swift
//  mm2
//
//  Created by John McManus on 05/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import SpriteKit
import GameController
import GameplayKit
class LevelScene: SKScene {
    var vcDelegate : GameViewController!
    
    var levelInfo : LevelConfigurationInfo!
    
    var nativeSize = CGSize.zero
    
    //Hud Info
    var score_label :SKLabelNode!
    var highScore_label :SKLabelNode!
    var airBar_label :SKSpriteNode!
    
    
    //MARK:Entities and Components
    var entityManager: EntityManager!
    var player :Player!
    
    var lastUpdateTimeInterval: NSTimeInterval = 0
    let maximumUpdateDeltaTime: NSTimeInterval = 1.0 / 60.0
    lazy var componentSystems: [GKComponentSystem] = {
        let spriteSystem = GKComponentSystem(componentClass: SpriteComponent.self)
        
        return [spriteSystem]}()
    
    
    override func didMoveToView(view: SKView) {
        print("\(__FUNCTION__):LevelScene")
        let camera = SKCameraNode()
        self.camera = camera
        addChild(camera)
        
        /* Setup your scene here */
        setupCamera()
        let levelName = "Level\(vcDelegate.level)"
        levelInfo = LevelConfigurationInfo(fileName: levelName)
        
        
        //print("Levelinfo")
        printLevelInfo()
        
        drawFloors()
        drawWalls()
        setupHud()
        
        entityManager = EntityManager(scene: self)
        player = Player(entityManager: entityManager)
        
        entityManager.add(player)
        
        //player.componentForClass(MovePlayerComponent)?.moveLeft()
        vcDelegate.levelScene = self
    }
    
    
    
    func setupCamera(){
        let camera = SKCameraNode()
        self.camera = camera
        addChild(camera)
        updateCameraScale()
        
    }
    func printLevelInfo(){
        print("==== Level Info =====")
        
        print(levelInfo.fileName)
        print(levelInfo.levelName)
        print(levelInfo.floorTexture)
        print(levelInfo.backgroundTexture)
        print(levelInfo.goalTexture)
        print(levelInfo.itemTexture)
        print(levelInfo.wallTexture)
        
        //levelInfo.nastieConfigurations
        
        for nastie in levelInfo.nasties {
            
            print(nastie)
            
            
        }
        
        print("=================")
        
    }
    
    func drawFloors(){
        //Get the floors from the scene
        self.enumerateChildNodesWithName("//floor", usingBlock: {
            node, stop in
            let floorImage = self.levelInfo.floorTexture
            if let floor = node as? SKSpriteNode {
                floor.tileNode(SKTexture(imageNamed: floorImage!))
            }
        })
        
    }
    func drawWalls(){
        //Get the floors from the scene
        self.enumerateChildNodesWithName("//wall", usingBlock: {
            node, stop in
            let wallImage = self.levelInfo.wallTexture
            if let wall = node as? SKSpriteNode {
                wall.tileNode(SKTexture(imageNamed: wallImage!))
            }
        })
        
    }
    
    func setupHud(){
        
        if let levelName_label = self.childNodeWithName("//levelName") as? SKLabelNode {
            
            levelName_label.text = levelInfo.levelName
            
        }
        score_label = self.childNodeWithName("//score") as? SKLabelNode
        highScore_label = self.childNodeWithName("//highscore") as? SKLabelNode
        score_label.text = "\(vcDelegate.score)"
        highScore_label.text = "\(vcDelegate.highscore)"
        
        
        
    }
    
    func updateCameraScale() {
        /*
        Because the game is normally playing in landscape, use the scene's current and
        original heights to calculate the camera scale.
        */
        nativeSize = size
        if let camera = camera {
            
            camera.setScale(1.0)
            camera.position.x = size.width * 0.5
            camera.position.y = size.height * 0.5
            /*
            camera.setScale(0.8)
            camera.position.x = size.width * 0.25
            camera.position.y = size.height * 0.4
            */
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            // let location = touch.locationInNode(self)
            let location = touch.locationInView(touch.view)
            
          //  print("touchloc:\(location)")
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print(__FUNCTION__)
        //stop movement
       player.playerMovementStateMachine.enterState(PlayerIdle)
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        //print(__FUNCTION__)
        //stop movement
        player.playerMovementStateMachine.enterState(PlayerIdle)

    }
    
    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
        
        
        // Calculate the amount of time since `update` was last called.
        var deltaTime = currentTime - lastUpdateTimeInterval
        // If more than `maximumUpdateDeltaTime` has passed, clamp to the maximum; otherwise use `deltaTime`.
        deltaTime = deltaTime > maximumUpdateDeltaTime ? maximumUpdateDeltaTime : deltaTime
        
        // The current time will be used as the last update time in the next execution of the method.
        lastUpdateTimeInterval = currentTime
        
        
        //run the update bits
        
        for comp in player.components {
        comp.updateWithDeltaTime(deltaTime)
        }
        
        
        
        
    }
    
    
    func moveLeft (){
        print(__FUNCTION__)
        player.componentForClass(MovePlayerComponent)?.moveLeft()
    }
    
    func moveRight(){
        print(__FUNCTION__)
        player.componentForClass(MovePlayerComponent)?.moveRight()
    }
    
    func moveJump(){
        print(__FUNCTION__)
        player.componentForClass(MovePlayerComponent)?.moveJump()
    }

}
