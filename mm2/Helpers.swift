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
        CGContextDrawTiledImage(context, tileSize, tile.CGImage())
        var tiledBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tiledBackground = tiledBackground.imageRotatedByDegrees(180, flip: false)
        let finalImage = SKTexture(CGImage: tiledBackground.CGImage!)
        
        self.texture = finalImage
    }
}

extension UIImage {
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(M_PI))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}



struct PhysicsCategory {
    static let None      : UInt32 = 1 << 0
    static let Player      : UInt32 = 1 << 1      // 2
    static let Key      : UInt32 = 1 << 2      // 4
    static let Nastie  : UInt32 = 1 << 3      // =8
    static let Finish : UInt32 = 1 << 4      // = 16
    static let SinkyFloor : UInt32 = 1 << 5 //=32
    static let All       : UInt32 = 1 << 21
}
