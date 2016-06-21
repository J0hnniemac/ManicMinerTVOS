//
//  LevelConfigInfo.swift
//  mm2
//
//  Created by John McManus on 08/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//

import Foundation


struct LevelConfigurationInfo {
    
    
    struct nastiesConfiguration {
        
        let name :String
        let spawnPointName :String
       // let texture :String
        let speed :Int
        let directionHorizontal :Bool
        let rangeofMovementLU :Int
        let rangeofMovementRD :Int
        let LUTextureList: [String]
        let RDTextureList: [String]
        
        init(nastiesConfigurationInfo: [String: AnyObject]) {
            
            name = nastiesConfigurationInfo["name"] as! String
            spawnPointName = nastiesConfigurationInfo["spawnPointName"] as! String
            speed = nastiesConfigurationInfo["speed"] as! Int
            directionHorizontal = nastiesConfigurationInfo["directionHorizontal"] as! Bool
            
         //   texture = nastiesConfigurationInfo["texture"] as! String
            
            
            rangeofMovementLU = nastiesConfigurationInfo["rangeofMovementLU"] as! Int
            rangeofMovementRD = nastiesConfigurationInfo["rangeofMovementRD"] as! Int
            LUTextureList = nastiesConfigurationInfo["LUTextureList"] as! [String]
            RDTextureList = nastiesConfigurationInfo["RDTextureList"] as! [String]
            
        }
        
    }
    
    
    
    private let configurationInfo: [String: AnyObject]
    let fileName :String
    let nastieConfigurations :[nastiesConfiguration]
    
    init(fileName: String){
        self.fileName = fileName
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: "plist")!
        configurationInfo = NSDictionary(contentsOfURL: url) as! [String: AnyObject]
        
        
        
        let nastieConfigurationsArray = configurationInfo["nastiesConfiguration"] as! [[String: AnyObject]]
        
        // let levelNasties = nastiesConfiguration.map{nastiesConfiguration(configurationInfo : $0)}
        
        
        //let botConfigurations = configurationInfo["taskBotConfigurations"] as! [[String: AnyObject]]
        
        // Map the array of `TaskBot` configuration dictionaries to an array of `TaskBotConfiguration` instances.
        nastieConfigurations = nastieConfigurationsArray.map { nastiesConfiguration(nastiesConfigurationInfo: $0) }
        print("break")
        
    }
    
    //levelName :String
    //backgroundTexture :String
    //wallTexture :String
    //floorTexture :String
    //itemTexture :String
    //goalTexture :String
    //nastiesConfiguration[] :Array
    //spawnID :String
    //texture :String
    //speed :Number
    //directionHorizontal :Bool
    //rangeofMovementLU :Number
    //rangeofMovementRD :Number
    
    //MARK: Properties
    
    var levelName: String? {
        return configurationInfo["levelName"] as! String?
    }
    var backgroundTexture: String? {
        return configurationInfo["backgroundTexture"] as! String?
    }
    var wallTexture: String? {
        return configurationInfo["wallTexture"] as! String?
    }
    var floorTexture: String? {
        return configurationInfo["floorTexture"] as! String?
    }
    var itemTexture: String? {
        return configurationInfo["itemTexture"] as! String?
    }
    var goalTexture: String? {
        return configurationInfo["goalTexture"] as! String?
    }
   // var conveyorTexture: String? {
   //     return configurationInfo["conveyorTexture"] as! String?
  //  }
    
    var conveyorTextures :[String]? {
    return configurationInfo["conveyorTextures"] as! [String]?
    }
    var robotTexture: String? {
        return configurationInfo["robotTexture"] as! String?
    }
    var nasties : [nastiesConfiguration] {
        
        return nastieConfigurations
        
    }
}