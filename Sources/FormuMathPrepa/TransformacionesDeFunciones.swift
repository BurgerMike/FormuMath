//
//  TransformacionesDeFunciones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Transformaciones: traslación, escalado, reflexión, estiramiento horizontal/vertical.
public enum TransformacionesDeFunciones {
    /// Dada f(x), devuelve g(x) = a * f( b*(x - h) ) + k
    /// - a: escala vertical (negativo refleja en X)
    /// - b: escala horizontal (negativo refleja en Y)
    /// - h: traslación horizontal
    /// - k: traslación vertical
    public static func transformar(_ f: @escaping (Double)->Double,
                                   a: Double = 1, b: Double = 1,
                                   h: Double = 0, k: Double = 0) -> (Double)->Double {
        { x in a * f(b * (x - h)) + k }
    }

    /// Inversa numérica por bisección en intervalo [L,R] para f monótona.
    public static func inversaNumerica(_ f: @escaping (Double)->Double,
                                       en rango: ClosedRange<Double>,
                                       y objetivo: Double,
                                       tol: Double = 1e-9,
                                       maxIter: Int = 100) -> Double? {
        var L = rango.lowerBound, R = rango.upperBound
        var fL = f(L) - objetivo
        var fR = f(R) - objetivo
        if fL == 0 { return L }
        if fR == 0 { return R }
        guard fL * fR <= 0 else { return nil } // no hay raíz garantizada
        for _ in 0..<maxIter {
            let M = 0.5*(L+R)
            let fM = f(M) - objetivo
            if abs(fM) < tol { return M }
            if fL * fM <= 0 { R = M; fR = fM } else { L = M; fL = fM }
        }
        return 0.5*(L+R)
    }
}
