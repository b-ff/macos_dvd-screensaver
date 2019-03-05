//
//  SwiftDVDScreenSaver.swift
//  dvd-screensaver
//
//  Created by Вячеслав Бирюков on 01.03.19.
//  Copyright © 2019 Вячеслав Бирюков. All rights reserved.
//

import ScreenSaver

let IMAGE_WIDTH: Int = 250
let IMAGE_HEIGHT: Int = 117

class SwiftDVDScreenSaver: ScreenSaverView {
    var pointX: Int = 0
    var pointY: Int = 0
    var offsetX: Int = IMAGE_WIDTH
    var offsetY: Int = IMAGE_HEIGHT
    var step: Int = 2
    
    var isMovingLeft: Bool = true
    var isMovingUp: Bool = true
    var isBounced: Bool = false
    
    var imageNames = [
        "dvd-red",
        "dvd-yellow",
        "dvd-green",
        "dvd-blue",
    ]
    
    var currentImageIndex: Int = 0
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        pointX = Int(arc4random_uniform(UInt32(self.bounds.width) - UInt32(offsetX)))
        pointY = Int(arc4random_uniform(UInt32(self.bounds.height) - UInt32(offsetY)))
    }
    
    override func startAnimation() {
        super.startAnimation()
    }
    
    override func stopAnimation() {
        super.stopAnimation()
    }
    
    func calculateMove () {
        if (self.pointX <= 0) {
            self.isMovingLeft = true
            self.isBounced = true
        } else if (self.pointX >= Int(self.bounds.width) - offsetX) {
            self.isMovingLeft = false
            self.isBounced = true
        }
        
        if (self.pointY <= 0) {
            self.isMovingUp = true
            self.isBounced = true
        } else if (self.pointY >= Int(self.bounds.height) - offsetY) {
            self.isMovingUp = false
            self.isBounced = true
        }
        
        self.pointX += self.isMovingLeft ? step : -step
        self.pointY += self.isMovingUp ? step : -step
    }
    
    override func animateOneFrame() {
        NSColor.white.setFill()
        NSRectFill(self.bounds)
        
        if (self.isBounced) {
            if (self.currentImageIndex >= self.imageNames.count - 1) {
                self.currentImageIndex = 0
            } else {
                self.currentImageIndex += 1
            }
            
            self.isBounced = false
        }
        
        let image: NSImage? = NSImage(byReferencingFile: "images/\(self.imageNames[self.currentImageIndex]).png")
        
        if (image != nil) {
            image!.draw(in: self.bounds)
            let imageView: NSImageView = NSImageView(image: image!)
            self.addSubview(imageView)
            imageView.draw(self.bounds)
        
//            let hello: String = "Current image is: \(self.imageNames[self.currentImageIndex]) and it's \(String(describing: image))!"
//            
//            hello.draw(
//                at: NSPoint(x: self.pointX, y: self.pointY),
//                withAttributes: nil
//            )
        }
        
        
        self.calculateMove()
    }
}
