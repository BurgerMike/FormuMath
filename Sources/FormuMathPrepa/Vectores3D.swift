//
//  Vectores3D.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public struct Vec3: Equatable, CustomStringConvertible {
    public var x: Double, y: Double, z: Double
    public init(_ x: Double, _ y: Double, _ z: Double) { self.x = x; self.y = y; self.z = z }

    public var description: String { "(\(x), \(y), \(z))" }

    public static func + (a: Vec3, b: Vec3) -> Vec3 { Vec3(a.x+b.x, a.y+b.y, a.z+b.z) }
    public static func - (a: Vec3, b: Vec3) -> Vec3 { Vec3(a.x-b.x, a.y-b.y, a.z-b.z) }
    public static func * (a: Vec3, k: Double) -> Vec3 { Vec3(a.x*k, a.y*k, a.z*k) }
    public static func * (k: Double, a: Vec3) -> Vec3 { a * k }
    public static func / (a: Vec3, k: Double) -> Vec3 { Vec3(a.x/k, a.y/k, a.z/k) }

    public var norma: Double { (x*x + y*y + z*z).squareRoot() }
    public func normalizado() -> Vec3 {
        let n = norma; return n < 1e-15 ? Vec3(0,0,0) : self / n
    }

    public static func dot(_ a: Vec3, _ b: Vec3) -> Double { a.x*b.x + a.y*b.y + a.z*b.z }

    public static func cross(_ a: Vec3, _ b: Vec3) -> Vec3 {
        Vec3(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x)
    }

    /// Ángulo entre vectores (radianes), nil si alguno es nulo
    public static func angulo(_ a: Vec3, _ b: Vec3) -> Double? {
        let na = a.norma, nb = b.norma
        if na < 1e-15 || nb < 1e-15 { return nil }
        var c = dot(a,b)/(na*nb); c = max(-1,min(1,c))
        return acos(c)
    }

    /// Proyección vectorial de a sobre b
    public static func proyeccion(_ a: Vec3, sobre b: Vec3) -> Vec3 {
        let nb2 = dot(b,b); if nb2 < 1e-15 { return Vec3(0,0,0) }
        let esc = dot(a,b)/nb2
        return b * esc
    }
}
