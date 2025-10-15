//
//  Untitled.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//

import Foundation

/// Trigonometry / Trigonometría
public enum Trig {
    /// Degrees → Radians / Grados → Radianes
    public static func deg2rad(_ deg: Double) -> Double { deg * .pi / 180 }
    public static func grad2rad(_ grados: Double) -> Double { deg2rad(grados) }

    /// Radians → Degrees / Radianes → Grados
    public static func rad2deg(_ rad: Double) -> Double { rad * 180 / .pi }
    public static func rad2grad(_ radianes: Double) -> Double { rad2deg(radianes) }

    /// Law of cosines (side) / Ley de cosenos (lado)
    public static func lawOfCosinesSide(a: Double, b: Double, gammaDeg: Double) -> Double {
        let g = deg2rad(gammaDeg)
        return (a*a + b*b - 2*a*b*cos(g)).squareRoot()
    }
    public static func leyDeCosenosLado(a: Double, b: Double, gammaGrados: Double) -> Double {
        lawOfCosinesSide(a: a, b: b, gammaDeg: gammaGrados)
    }

    /// Law of sines (solve angle B) / Ley de senos (hallar ángulo B)
    public static func lawOfSinesAngle(a: Double, Adeg: Double, b: Double) -> Double? {
        guard a != 0 else { return nil }
        let A = deg2rad(Adeg)
        let s = b * sin(A) / a
        guard abs(s) <= 1 else { return nil }
        return rad2deg(asin(s))
    }
    public static func leyDeSenosAngulo(a: Double, Agrados: Double, b: Double) -> Double? {
        lawOfSinesAngle(a: a, Adeg: Agrados, b: b)
    }

    /// 2D rotation of a point / Rotación 2D de un punto
    public static func rotate2D(x: Double, y: Double, angleDeg: Double) -> (x: Double, y: Double) {
        let a = deg2rad(angleDeg)
        let c = cos(a), s = sin(a)
        return (x*c - y*s, x*s + y*c)
    }
    public static func rotar2D(x: Double, y: Double, anguloGrados: Double) -> (x: Double, y: Double) {
        rotate2D(x: x, y: y, angleDeg: anguloGrados)
    }
}
