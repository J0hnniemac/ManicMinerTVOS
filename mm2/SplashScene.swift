//
//  SplashScene.swift
//  mm2
//
//  Created by John McManus on 05/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation
import SpriteKit


class SplashScene: SKScene {
    var vcDelegate : GameViewController!
    var nativeSize = CGSize.zero
    
    override func didMoveToView(view: SKView) {
        
        print("\(__FUNCTION__):ClassSplashScene")
        
        /* Setup your scene here */
        setupCamera()
       
    }
    func setupCamera(){
        let camera = SKCameraNode()
        self.camera = camera
        addChild(camera)
        updateCameraScale()

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
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            //self.addChild(sprite)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
        
        
    
    
    
    
    
    
}
