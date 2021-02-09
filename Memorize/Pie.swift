//
//  Pie.swift
//  Memorize
//
//  Created by Александр Фомичев on 25.01.2021.
//  Copyright © 2021 Fomichev Alexander. All rights reserved.
//

import Foundation
import SwiftUI

struct Pie : Shape {
    var startAngle : Angle
    var endAngle: Angle
    var clockwise : Bool = false
    var animatableData: AnimatablePair<Double,Double>{
        get {
            AnimatablePair(startAngle.radians,endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height)/2
        let center = CGPoint(x:rect.midX, y:rect.midY)
        let start = CGPoint(x: center.x + radius * cos(CGFloat(startAngle.radians)),
                             y: center.y + radius * sin(CGFloat(startAngle.radians)))
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        p.addLine(to: center)
        return p
    }
}
