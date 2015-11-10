//
//  GameCompleteState.swift
//  mmt1
//
//  Created by John McManus on 03/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameLevelComplete : GKState {
    //var theScene: SKScene
    var theView: SKView
    init(theView :SKView) {
        
      //  self.theScene = theScene
        self.theView = theView
        print("init GameLevelComplete")
    }

    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GameLevelScreen.Type, is GameSplashScreen.Type:
            return true
        default:
            return false
        }
    }
    override func didEnterWithPreviousState(previousState: GKState?) {
        LoadLevel()
    }
    func LoadLevel(){
        
        print("\(__FUNCTION__):Overlay:EndLevel")
        let overlayScreen = "EndLevel"
        let sceneInfoFromFile = SKScene(fileNamed: overlayScreen)!
        let contentTemplateNode = sceneInfoFromFile.childNodeWithName("//overlayNode")
        let contentNode: SKNode
        contentNode = contentTemplateNode!.copy() as! SKNode
        theView.scene!.childNodeWithName("//overlayNode")?.removeFromParent()
        let pos = CGPoint(x: (theView.scene?.size.width)! / 2 , y: (theView.scene?.size.height)! / 2)
        contentNode.position = pos
        theView.scene!.addChild(contentNode)
        
        
        
    }
}
