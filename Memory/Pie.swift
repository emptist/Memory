//
//  Pie.swift
//  Memory
//
//  Created by jk on 2020/6/7.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct Pie: Shape {
    var startAngle,endAngle: Angle
    var clockwise: Bool = true
    
    /// path is required to conform to Shape protocal
    /// - Parameter rect: is the RectAngle to draw self in
    /// - Returns: Path
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX,y: rect.midY)
        let radius = min(rect.width,rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        p.addLine(to: center)
        return p
    }
}
