//
//  Vectores2D.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public struct Vec2: Equatable, CustomStringConvertible {
    public var x: Double
    public var y: Double

    public init(_ x: Double, _ y: Double) { self.x = x; self.y = y }

    public var description: String { "(\(x), \(y))" }

    public static let cero = Vec2(0,0)

    public var norma: Double { (x*x + y*y).squareRoot() }

    public func normalizado() -> Vec2 {
        let n = norma
        if n < 1e-15 { return .cero }
        return Vec2(x/n, y/n)
    }

    public static func + (a: Vec2, b: Vec2) -> Vec2 { Vec2(a.x + b.x, a.y + b.y) }
    public static func - (a: Vec2, b: Vec2) -> Vec2 { Vec2(a.x - b.x, a.y - b.y) }
    public static func * (a: Vec2, k: Double) -> Vec2 { Vec2(a.x * k, a.y * k) }
    public static func * (k: Double, a: Vec2) -> Vec2 { a * k }
    public static func / (a: Vec2, k: Double) -> Vec2 { Vec2(a.x / k, a.y / k) }

    /// Producto punto a·b
    public static func dot(_ a: Vec2, _ b: Vec2) -> Double { a.x*b.x + a.y*b.y }

    /// “Producto cruz” 2D → escalar z (magnitud de z de a×b)
    public static func crossZ(_ a: Vec2, _ b: Vec2) -> Double { a.x*b.y - a.y*b.x }

    /// Ángulo entre vectores (radianes), retorna nil si alguno es nulo.
    public static func angulo(_ a: Vec2, _ b: Vec2) -> Double? {
        let na = a.norma, nb = b.norma
        if na < 1e-15 || nb < 1e-15 { return nil }
        var c = dot(a, b) / (na * nb)
        c = max(-1.0, min(1.0, c))
        return acos(c)
    }

    /// Proyección de a sobre b (vector).
    public static func proyeccion(_ a: Vec2, sobre b: Vec2) -> Vec2 {
        let nb2 = dot(b, b)
        if nb2 < 1e-15 { return .cero }
        let esc = dot(a, b) / nb2
        return b * esc
    }
}
