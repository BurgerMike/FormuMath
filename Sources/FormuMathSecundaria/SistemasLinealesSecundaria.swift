//
//  SistemasLinealesSecundaria.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum SistemasLinealesSecundaria {
    /// Sustitución para 2x2:
    /// a1 x + b1 y = c1
    /// a2 x + b2 y = c2
    public static func resolver2x2(a1: Double, b1: Double, c1: Double,
                                   a2: Double, b2: Double, c2: Double) -> (Double, Double)? {
        let det = a1*b2 - a2*b1
        if abs(det) < 1e-12 { return nil }
        let x = (c1*b2 - c2*b1) / det
        let y = (a1*c2 - a2*c1) / det
        return (x,y)
    }

    /// Igualación simple: y = m1 x + n1 ; y = m2 x + n2
    public static func interseccionRectas(m1: Double, n1: Double, m2: Double, n2: Double) -> (Double, Double)? {
        if abs(m1 - m2) < 1e-12 { return nil }
        let x = (n2 - n1) / (m1 - m2)
        return (x, m1*x + n1)
    }
}
