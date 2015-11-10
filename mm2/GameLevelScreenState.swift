//
//  GameLevelScreenState.swift
//  mmt1
//
//  Created by John McManus on 03/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit
import SpriteKit





class GameLevelScreen : GKState {
    var currentLevel :Int = 0
    var lastLevel :Int = 2
   // var theScene: GameScene
    var theView: SKView
    var vcDelegate : GameViewController
    init( theView :SKView, vcDelegate :GameViewController) {
        print("\(__FUNCTION__) GameLevelScreen")
   //     self.theScene = theScene
        self.theView = theView
        self.vcDelegate = vcDelegate
        super.init()
    }
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        print("\(__FUNCTION__)")
        if previousState is GameSplashScreen {
            vcDelegate.level = 1
            print("reset current level to 1")
            LoadLevel()
        }
        
        if previousState is GameLevelComplete {
            vcDelegate.level++
            if vcDelegate.level > vcDelegate.maxlevel {vcDelegate.level = 1}
            LoadLevel()
        }
        
        
    }
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        print("\(__FUNCTION__)")
        switch stateClass {
        case is GameLevelGameOver.Type, is GameLevelComplete.Type, is GameSplashScreen.Type:
            return true
        default:
            return false
        }
    }
    
    func LoadLevel(){
        print("\(__FUNCTION__)")
        let levelName = "Level\(vcDelegate.level)"
        let sceneInfoFromFile = LevelScene(fileNamed: levelName )
        sceneInfoFromFile?.scaleMode = .Fill
        sceneInfoFromFile!.vcDelegate = vcDelegate
       
        
       
        theView.presentScene(sceneInfoFromFile)
        
        
        
    }
    
    
}
