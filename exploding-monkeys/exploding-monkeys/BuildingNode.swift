//
//  BuildingNode.swift
//  exploding-monkeys
//
//  Created by Renan Kosicki on 9/29/15.
//  Copyright © 2015 Renan Kosicki | K-Mobi. All rights reserved.
//

import SpriteKit

class BuildingNode: SKSpriteNode {
    var currentImage: UIImage!
    
    func setup() {
        name = "building"
        
        currentImage = drawBuilding(size)
        texture = SKTexture(image: currentImage)
        
        configurePhysics()
    }
    
    func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody!.dynamic = false
        physicsBody!.categoryBitMask = CollisionTypes.Building.rawValue
        physicsBody!.contactTestBitMask = CollisionTypes.Banana.rawValue
    }
    
    func drawBuilding(size: CGSize) -> UIImage {
        // 1
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // 2
        let rectangle = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var color: UIColor
        
        switch GKRandomSource.sharedRandom().nextIntWithUpperBound(3) {
        case 0:
            color = UIColor(hue: 0.502, saturation: 0.98, brightness: 0.67, alpha: 1)
        case 1:
            color = UIColor(hue: 0.999, saturation: 0.99, brightness: 0.67, alpha: 1)
        default:
            color = UIColor(hue: 0, saturation: 0, brightness: 0.67, alpha: 1)
        }
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddRect(context, rectangle)
        CGContextDrawPath(context, .Fill)
        
        // 3
        let lightOnColor = UIColor(hue: 0.190, saturation: 0.67, brightness: 0.99, alpha: 1)
        let lightOffColor = UIColor(hue: 0, saturation: 0, brightness: 0.34, alpha: 1)
        
        for var row: CGFloat = 10; row < size.height - 10; row += 40 {
            for var col: CGFloat = 10; col < size.width - 10; col += 40 {
                if RandomInt(min: 0, max: 1) == 0 {
                    CGContextSetFillColorWithColor(context, lightOnColor.CGColor)
                } else {
                    CGContextSetFillColorWithColor(context, lightOffColor.CGColor)
                }
                
                CGContextFillRect(context, CGRect(x: col, y: row, width: 15, height: 20))
            }
        }
        
        // 4
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}
