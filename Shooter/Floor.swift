//
//  Floor.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 18/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation
import SpriteKit


let NumberOfSegments = 32

class Floor: NSObject {
    var segments: [FloorSegment] = []
    
    init(height: CGFloat, scene: SKScene) {
        super.init()
        assert(Int(scene.size.width) % NumberOfSegments == 0, "Width must be divisible by number of segments", file: "Floor.swift", line: 0)
        
        let segmentWidth = scene.size.width / CGFloat(NumberOfSegments)
        
        for i in 0..<NumberOfSegments {
            let x: CGFloat = CGFloat(i) * segmentWidth
            let y: CGFloat = 0
            let rect = CGRect(x: x, y: y, width: segmentWidth, height: height)
            var s = FloorSegment(rect: rect)
            linkWithPrevious(s)
            self.segments.append(s)
            scene.addChild(s)
        }
    }
    
    func linkWithPrevious(floorSegment: FloorSegment) {
        // set up previous link as well as the previous element's next link
        // note that self.segments.last may be nil (when adding the first element)
        if let prev = self.segments.last {
            floorSegment.previous = prev
            prev.next = floorSegment
        }
    }
    
    var maxHeight: CGFloat {
        get {
            var max: CGFloat = 0
            for seg in self.segments {
                max = seg.visibleHeight > max ? seg.visibleHeight : max
            }
            return max
        }
    }
}
