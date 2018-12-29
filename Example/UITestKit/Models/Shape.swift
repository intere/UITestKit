//
//  Shape.swift
//  UITestKit_Example
//
//  Created by Eric Internicola on 12/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum Shape: String, CaseIterable {
    case triangle
    case circle
    case square
    case rhombus
    case star
    case pentagon
    case rectangle
    case ellipse

    var image: UIImage? {
        return UIImage(named: rawValue)
    }

    /// Info about the shape.
    /// **Sources:
    /// - https://www.smartickmethod.com/blog/math/geometry/geometric-plane-shapes/
    /// - Wikipedia
    var description: String {
        switch self {
        case .triangle:
            return "The triangle is a shape that is formed by 3 straight lines that are called sides.  There are different ways of classifying triangles, according to their sides or angles."

        case .circle:
            return "The circle is a shape that can be made by tracing a curve that is always the same distance from a point that we call the center.  The distance around a circle is called the circumference of the circle."

        case .rectangle:
            return "The rectangle is a shape that has 4 sides.  The distinguishing characteristic of a rectangle is that all 4 angles measure 90 degrees."

        case .rhombus:
            return "The rhombus is a shape formed by 4 straight lines. Its 4 sides measure the same length but, unlike the rectangle, any of all 4 angles measure 90 degrees."

        case .square:
            return "The square is a type of rectangle, but also a type of rhombus. It has characteristics of both of these. That is to say, all 4 angles are right angles, and all 4 sides are equal in length."
        case .star:
            return "In geometry, a star polygon is a type of non-convex polygon. Only the regular star polygons have been studied in any depth; star polygons in general appear not to have been formally defined."
        case .pentagon:
            return "In geometry, a pentagon (from the Greek πέντε pente and γωνία gonia, meaning five and angle) is any five-sided polygon or 5-gon. The sum of the internal angles in a simple pentagon is 540°."
        case .ellipse:
            return "In mathematics, an ellipse is a curve in a plane surrounding two focal points such that the sum of the distances to the two focal points is constant for every point on the curve. As such, it is a generalization of a circle, which is a special type of an ellipse having both focal points at the same location. The shape of an ellipse (how \"elongated\" it is) is represented by its eccentricity, which for an ellipse can be any number from 0 (the limiting case of a circle) to arbitrarily close to but less than 1."
        }
    }
}
