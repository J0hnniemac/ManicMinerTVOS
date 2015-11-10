//
//  GameViewController.swift
//  mm2
//
//  Created by John McManus on 05/11/2015.
//  Copyright (c) 2015 AppyAppster Limited. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameController
class GameViewController: UIViewController {
    var controllerList : [GCController]!
    var gameController : GCController!
    var score = 0
    var highscore = 0
    var lives = 10
    var level = 1
    var maxlevel = 2
    var screensStateMachine: GKStateMachine!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        screensStateMachine = GKStateMachine(states: [
            GameSplashScreen(theView: skView, vcDelegate: self),
            GameLevelScreen(theView: skView, vcDelegate: self),
            GameLevelComplete(theView: skView),
            GameLevelGameOver(theView: skView)])
        
        
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        getControllers()
        
        screensStateMachine.enterState(GameSplashScreen)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    
    func getControllers(){
        
        
        controllerList = GCController.controllers()
        if controllerList.count < 1 {
            print("no controller try and attach to them")
            attachControllers()
        }
        
    }
    
    func attachControllers(){
        print("\(__FUNCTION__)")
        registerForGameControllerNotifications() // Setup notification when Controller is found
        GCController.startWirelessControllerDiscoveryWithCompletionHandler({}) //Basic call to get game controllers
        
    }
    func registerForGameControllerNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleControllerDidConnectNotification:", name: GCControllerDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleControllerDidDisconnectNotification:", name: GCControllerDidDisconnectNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: GCControllerDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: GCControllerDidDisconnectNotification, object: nil)
    }
    
    @objc func handleControllerDidConnectNotification(notification: NSNotification) {
        print("\(__FUNCTION__)")
        // assign the gameController which is found - will break if more than 1
        gameController = notification.object as! GCController
        // we have a controller so go and setup handlers
        self.setupGCEvents2()
        
    }
    
    
    @objc func handleControllerDidDisconnectNotification(notification: NSNotification) {
        // if a controller disconnects we should see it
        print("\(__FUNCTION__)")
        
    }
    
    
    func setupGCEvents2(){
        
        
        
        // Add the gesture recognizer
        
        let selectTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "selectTapped:")
        
        let selectPressType = UIPressType.Select
        
        selectTapGestureRecognizer.allowedPressTypes = [NSNumber(integer: selectPressType.rawValue)];
        
        
        
        let menuTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "menuTapped:")
        
        let menuPressType = UIPressType.Menu
        
        menuTapGestureRecognizer.allowedPressTypes = [NSNumber(integer: menuPressType.rawValue)];
        
        
        
        
        
        let leftTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "leftTapped:")
        
        let leftPressType = UIPressType.LeftArrow
        
        leftTapGestureRecognizer.allowedPressTypes = [NSNumber(integer: leftPressType.rawValue)];
        
        
        
        let rightTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "rightTapped:")
        
        let rightPressType = UIPressType.RightArrow
        
        rightTapGestureRecognizer.allowedPressTypes = [NSNumber(integer: rightPressType.rawValue)];
        
        
        
        let playPauseTapGestureRecognizer = UITapGestureRecognizer(target: self, action: "playPauseTapped:")
        
        let playPausePressType = UIPressType.PlayPause
        
        playPauseTapGestureRecognizer.allowedPressTypes = [NSNumber(integer: playPausePressType.rawValue)];
        
        
        
        
        
        
        
        view.addGestureRecognizer(selectTapGestureRecognizer)
        
        view.addGestureRecognizer(menuTapGestureRecognizer)
        
        
        
        view.addGestureRecognizer(leftTapGestureRecognizer)
        
        view.addGestureRecognizer(rightTapGestureRecognizer)
        
        
        
        view.addGestureRecognizer(playPauseTapGestureRecognizer)
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func selectTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        
        // Handle select button tapped
        
        print(__FUNCTION__)
        
    }
    
    func menuTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        
        // Handle select button tapped
        
        print(__FUNCTION__)
        
    }
    
    func leftTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        
        // Handle select button tapped
        
        print(__FUNCTION__)
        
    }
    
    func rightTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        
        // Handle select button tapped
        
        print(__FUNCTION__)
        
    }
    
    
    
    func playPauseTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        
        // Handle select button tapped
        
        print(__FUNCTION__)
        switch self.screensStateMachine.currentState {
        case is GameSplashScreen:
            print("enterState(GameLevelScreen)")
            self.screensStateMachine.enterState(GameLevelScreen)
            break
        case is GameLevelScreen:
            print("enterState(GameLevelComplete)")
            self.screensStateMachine.enterState(GameLevelComplete)
            break
        case is GameLevelComplete:
            self.screensStateMachine.enterState(GameLevelScreen)
            break
        default:
            print("nothing to change to")
        }
    }
    

    
    
    func setupGCEvents(){
        //if it is a siri remote
        if let microGamepad = self.gameController.microGamepad {
            print("microGamepad found")
            registermicroGamepadEvents(microGamepad)
        }
    }
    
    func registermicroGamepadEvents(microGamepad :GCMicroGamepad){
        print("\(__FUNCTION__)")
        
        
        //setup the handlers
        gameController.controllerPausedHandler = { [unowned self] _ in
            self.pauseGame()
        }
        let buttonHandlerA: GCControllerButtonValueChangedHandler = {  button, _, pressed in
            print("buttonHandlerA")
            if button.pressed {
                self.screensStateMachine.enterState(GameSplashScreen)
            }
            
            
        }
        let buttonHandlerX: GCControllerButtonValueChangedHandler = {  button, _, pressed in
            print("buttonHandlerX")
            
            if button.pressed {
                switch self.screensStateMachine.currentState {
                case is GameSplashScreen:
                    print("enterState(GameLevelScreen)")
                    self.screensStateMachine.enterState(GameLevelScreen)
                    break
                case is GameLevelScreen:
                    print("enterState(GameLevelComplete)")
                    self.screensStateMachine.enterState(GameLevelComplete)
                    break
                case is GameLevelComplete:
                    self.screensStateMachine.enterState(GameLevelScreen)
                    break
                default:
                    print("nothing to change to")
                }
            }
            
        }
        
        let movementHandler: GCControllerDirectionPadValueChangedHandler = { (dpad: GCControllerDirectionPad, xValue: Float, yValue: Float) -> Void in
            
            if dpad.left.value  > 0  {
                print("left")
                
            }
            if dpad.right.value > 0 {
                print("right")
                
            }
        }
        
        
        
       // microGamepad.buttonA.pressedChangedHandler = buttonHandlerA
        //microGamepad.buttonX.pressedChangedHandler = buttonHandlerX
        
        microGamepad.allowsRotation = true
        microGamepad.dpad.valueChangedHandler = movementHandler
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.LeftArrow.rawValue),NSNumber(integer: UIPressType.RightArrow.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func tapped(tap :UITapGestureRecognizer){
    print(__FUNCTION__)
        print(tap.locationInView(super.view))
    
    }
    
    
    
    func pauseGame(){
        print("\(__FUNCTION__)")
        //Assigned to menu button
    }
    
    
    
}
