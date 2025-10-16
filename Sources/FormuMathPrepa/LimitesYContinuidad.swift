//
//  LimitesYContinuidad.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum LimitesYContinuidad {
    /// Regla de límites por evaluación directa si es continuo en x0.
    public static func limitePorContinuidad(_ f: (Double)->Double, x0: Double) -> Double {
        f(x0)
    }

    /// Cociente incremental (aprox) para detectar continuidad numérica.
    public static func esContinuoEn(_ f: (Double)->Double, x0: Double, h: Double = 1e-6, tol: Double = 1e-6) -> Bool {
        let L = f(x0)
        let Lh1 = f(x0 + h)
        let Lh2 = f(x0 - h)
        return abs(Lh1 - L) < tol && abs(Lh2 - L) < tol
    }

    /// Límites notables: (sin x)/x → 1 (x→0), (1 - cos x)/x → 0 (x→0)
    public static func limiteSenoSobreX(_ x: Double) -> Double {
        if x == 0 { return 1 }
        return sin(x)/x
    }
    public static func limiteUnoMenosCosSobreX(_ x: Double) -> Double {
        if x == 0 { return 0 }
        return (1 - cos(x))/x
    }
}
