//
//  GameSplashScreen.swift
//  mmt1
//
//  Created by John McManus on 03/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameSplashScreen : GKState {
    
   // var theScene: GameScene
    var theView: SKView
    var vcDelegate : GameViewController
    init( theView :SKView, vcDelegate :GameViewController) {
        print("\(__FUNCTION__) GameSplashScreen")
        //     self.theScene = theScene
        self.theView = theView
        self.vcDelegate = vcDelegate
        super.init()
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GameLevelScreen.Type:
            return true
        default:
            return false
        }
    }
    
    
    override func didEnterWithPreviousState(previousState: GKState?) {
        // Does not matter which state, just present the SplashScreen
        loadSplashScreen()
    }
    
    
    func loadSplashScreen(){
        print("\(__FUNCTION__)")
    
        let splashScreen = "Start"
        let sceneInfoFromFile = SplashScene(fileNamed: splashScreen )
        sceneInfoFromFile!.vcDelegate = vcDelegate
        sceneInfoFromFile?.scaleMode = .Fill
        theView.presentScene(sceneInfoFromFile)
    }
    
    
}