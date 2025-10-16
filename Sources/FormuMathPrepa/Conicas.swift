//
//  Conicas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Conicas {
    // Formas canónicas centradas
    // Parabola: (y - k)^2 = 4p (x - h)  ó  (x - h)^2 = 4p (y - k)
    public static func parabolaFocoDirectriz(h: Double, k: Double, p: Double, horizontal: Bool)
        -> (foco: (Double,Double), directriz: (A: Double,B: Double,C: Double)) {
        if horizontal {
            // abre hacia +/- x
            return ((h + p, k), (A: 1, B: 0, C: -(h - p))) // x = h - p  → 1*x + 0*y + C = 0
        } else {
            // abre hacia +/- y
            return ((h, k + p), (A: 0, B: 1, C: -(k - p))) // y = k - p
        }
    }

    // Elipse: ((x-h)^2)/a^2 + ((y-k)^2)/b^2 = 1 (a >= b)
    public static func elipseEjes(h: Double, k: Double, a: Double, b: Double)
        -> (c: Double, focos: [(Double,Double)], excentricidad: Double) {
        precondition(a >= b && a > 0 && b > 0)
        let c = (a*a - b*b).squareRoot()
        let e = c/a
        return (c, [(h - c, k), (h + c, k)], e)
    }

    // Hipérbola: ((x-h)^2)/a^2 - ((y-k)^2)/b^2 = 1
    public static func hiperbolaEjes(h: Double, k: Double, a: Double, b: Double)
        -> (c: Double, focos: [(Double,Double)], excentricidad: Double) {
        precondition(a > 0 && b > 0)
        let c = (a*a + b*b).squareRoot()
        let e = c/a
        return (c, [(h - c, k), (h + c, k)], e)
    }
}
