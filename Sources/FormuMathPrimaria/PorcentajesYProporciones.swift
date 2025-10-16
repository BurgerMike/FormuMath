//
//  PorcentajesyProporciones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum PorcentajesYProporciones {
    /// p% de x
    public static func porcentaje(de x: Double, p: Double) -> Double { x * p / 100.0 }

    /// Aumento/reducción porcentual: x -> x * (1 + p/100)
    public static func variar(_ x: Double, porcentaje p: Double) -> Double { x * (1 + p/100.0) }

    /// Decimal ↔ porcentaje
    public static func aPorcentaje(_ x: Double) -> Double { x * 100.0 }
    public static func desdePorcentaje(_ p: Double) -> Double { p / 100.0 }

    /// Razón a:b como valor a/b
    public static func razon(_ a: Double, _ b: Double) -> Double {
        precondition(b != 0, "b != 0")
        return a / b
    }

    /// Proporción a:b = c:d (validación por producto cruzado con tolerancia)
    public static func esProporcion(a: Double, b: Double, c: Double, d: Double, tol: Double = 1e-9) -> Bool {
        precondition(b != 0 && d != 0, "b y d != 0")
        return abs(a*d - b*c) <= tol
    }

    /// Regla de tres directa: a : b = c : x  →  x = b*c/a
    public static func reglaDeTres(a: Double, b: Double, c: Double) -> Double {
        precondition(a != 0, "a != 0")
        return (b * c) / a
    }
}
