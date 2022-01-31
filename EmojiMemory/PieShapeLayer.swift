//
//  PieShapeLayer.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/30/22.
//

import UIKit

class PieShapeLayer: CAShapeLayer {
    
    var startAngle: CGFloat = -.pi/2
    var endAngle: CGFloat = .pi * 2
    
    override init() {
        super.init()
    }
    
    init(startAngle: CGFloat, endAngle:CGFloat) {
        super.init()
        self.startAngle = startAngle
        self.endAngle = endAngle

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func display() {
        let piePath = UIBezierPath(
            arcCenter: CGPoint(x: 10, y: 10),
            radius: 40,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        self.path = piePath.cgPath
    }
}
