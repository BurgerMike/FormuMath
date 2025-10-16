//
//  Progresiones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Progresiones {
    /// Enésimo término de una PA: a_n = a1 + (n-1)d
    public static func an_PA(a1: Double, d: Double, n: Int) -> Double {
        a1 + Double(n - 1) * d
    }

    /// Suma de n términos de una PA: S_n = n/2 (2a1 + (n-1)d)
    public static func suma_PA(a1: Double, d: Double, n: Int) -> Double {
        Double(n) / 2.0 * (2.0 * a1 + Double(n - 1) * d)
    }

    /// Enésimo término de una PG: a_n = a1 * r^(n-1)
    public static func an_PG(a1: Double, r: Double, n: Int) -> Double {
        a1 * pow(r, Double(n - 1))
    }

    /// Suma de n términos de una PG (r != 1): S_n = a1 (r^n - 1) / (r - 1)
    public static func suma_PG(a1: Double, r: Double, n: Int) -> Double {
        if abs(r - 1.0) < 1e-12 { return a1 * Double(n) }
        return a1 * (pow(r, Double(n)) - 1.0) / (r - 1.0)
    }
}
