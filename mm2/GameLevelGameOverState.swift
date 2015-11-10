//
//  GameScreensStates.swift
//  mmt1
//
//  Created by John McManus on 02/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//
import GameplayKit
import SpriteKit

class GameLevelGameOver : GKState {
  //  var theScene: GameScene
    var theView: SKView
    init( theView :SKView) {
       
    //    self.theScene = theScene
        self.theView = theView
        print("init GameLevelGameOver")
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GameSplashScreen.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        LoadLevel()
    }
    func LoadLevel(){
        
        
     //   let splashScreen = "End"
       // let sceneInfoFromFile = SKScene(fileNamed: splashScreen)!
        //theScene.childNodeWithName("//_worldNode")?.removeFromParent()
        //theScene.addChild(contentNode)


        
    }
    
}



