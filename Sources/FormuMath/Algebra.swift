//
//  Algebra.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//

import Foundation

/// Algebra formulas / Fórmulas de álgebra
public enum Algebra {
    /// Solve linear ax + b = 0 / Resolver ax + b = 0
    public static func solveLinear(a: Double, b: Double) -> Double? {
        guard a != 0 else { return nil }
        return -b / a
    }
    public static func resolverLineal(a: Double, b: Double) -> Double? { solveLinear(a: a, b: b) }

    /// Solve quadratic ax² + bx + c = 0 / Resolver cuadrática
    public static func solveQuadratic(a: Double, b: Double, c: Double) -> (Double?, Double?) {
        guard a != 0 else { return b == 0 ? (nil, nil) : (-c/b, nil) }
        let d = b*b - 4*a*c
        if d < 0 { return (nil, nil) }
        let sqrtD = Foundation.sqrt(d)
        return ((-b + sqrtD)/(2*a), (-b - sqrtD)/(2*a))
    }
    public static func resolverCuadratica(a: Double, b: Double, c: Double) -> (Double?, Double?) {
        solveQuadratic(a: a, b: b, c: c)
    }

    /// GCD / MCD (Euclides)
    public static func gcd(_ a: Int, _ b: Int) -> Int {
        var x = abs(a), y = abs(b)
        while y != 0 { let t = x % y; x = y; y = t }
        return x
    }
    public static func mcd(_ a: Int, _ b: Int) -> Int { gcd(a, b) }

    /// LCM / MCM
    public static func lcm(_ a: Int, _ b: Int) -> Int {
        guard a != 0 && b != 0 else { return 0 }
        return abs(a / gcd(a, b) * b)
    }
    public static func mcm(_ a: Int, _ b: Int) -> Int { lcm(a, b) }
}
