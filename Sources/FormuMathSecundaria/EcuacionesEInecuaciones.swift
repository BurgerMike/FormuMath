//
//  EcuacionesElnecuaciones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum EcuacionesEInecuaciones {
    public enum TipoError: Error { case aCero }

    // ax + b = 0
    public static func resolverLineal(a: Double, b: Double) throws -> Double {
        guard abs(a) > 1e-15 else { throw TipoError.aCero }
        return -b/a
    }

    // ax^2 + bx + c = 0
    public static func resolverCuadratica(a: Double, b: Double, c: Double) -> (Double?, Double?) {
        if abs(a) < 1e-15 {
            let x = try? resolverLineal(a: b, b: c)
            return (x, nil)
        }
        let D = b*b - 4*a*c
        if D < 0 { return (nil, nil) }
        let s = sqrt(D)
        return ((-b - s)/(2*a), (-b + s)/(2*a))
    }

    /// Inecuación lineal: ax + b {<, ≤, >, ≥} 0  -> devuelve intervalo(s) de solución
    public static func inecuacionLineal(a: Double, b: Double, comparador: String) -> [ClosedRange<Double>] {
        // comparador: "<", "<=", ">", ">="
        if abs(a) < 1e-15 {
            switch comparador {
            case "<":  return b < 0 ? [(-Double.infinity)...(Double.infinity)] : []
            case "<=": return b <= 0 ? [(-Double.infinity)...(Double.infinity)] : []
            case ">":  return b > 0 ? [(-Double.infinity)...(Double.infinity)] : []
            case ">=": return b >= 0 ? [(-Double.infinity)...(Double.infinity)] : []
            default:   return []
            }
        }
        let x0 = -b/a
        let menor = a > 0 ? (-Double.infinity)...x0 : x0...(Double.infinity)
        let mayor = a > 0 ? x0...(Double.infinity) : (-Double.infinity)...x0
        switch comparador {
        case "<":  return [menor].map { $0.lowerBound..<$0.upperBound }.map { $0.lowerBound...($0.upperBound - 0) }
        case "<=": return [menor]
        case ">":  return [mayor].map { $0.lowerBound..<$0.upperBound }.map { $0.lowerBound...($0.upperBound - 0) }
        case ">=": return [mayor]
        default:   return []
        }
    }
}
