//
//  Helpers.swift
//  mm2
//
//  Created by John McManus on 09/11/2015.
//  Copyright © 2015 AppyAppster Limited. All rights reserved.
//
import SpriteKit
extension SKSpriteNode {

    func tileNode (tile: SKTexture){
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        let tileSize = CGRect(x: 0.0, y: 0.0, width: tile.size().width, height: tile.size().height)
        CGContextDrawTiledImage(context, tileSize, tile.CGImage)
        let tiledBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let finalImage = SKTexture(CGImage: tiledBackground.CGImage!)
        
        self.texture = finalImage
    }
}
