//
//  Untitled.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//

import Foundation

/// Numerical calculus / Cálculo numérico
public enum Calculus {
    /// Derivative (central difference) / Derivada (diferencia centrada)
    public static func derivative(_ f: (Double) -> Double, at x: Double, h: Double = 1e-6) -> Double {
        (f(x + h) - f(x - h)) / (2*h)
    }
    public static func derivada(_ f: (Double) -> Double, en x: Double, h: Double = 1e-6) -> Double {
        derivative(f, at: x, h: h)
    }

    /// Integral (trapezoidal) / Integral (regla del trapecio)
    public static func integral(_ f: (Double) -> Double, a: Double, b: Double, n: Int = 10_000) -> Double {
        guard n > 0 else { return 0 }
        let h = (b - a) / Double(n)
        var s = 0.5 * (f(a) + f(b))
        for i in 1..<n { s += f(a + Double(i)*h) }
        return s * h
    }
    public static func integralTrapecios(_ f: (Double) -> Double, a: Double, b: Double, n: Int = 10_000) -> Double {
        integral(f, a: a, b: b, n: n)
    }

    /// Newton-Raphson root / Raíz por Newton-Raphson
    public static func newtonRoot(_ f: (Double) -> Double, initialGuess x0: Double,
                                  tol: Double = 1e-8, maxIter: Int = 1000) -> Double? {
        var x = x0
        for _ in 0..<maxIter {
            let fx = f(x)
            let dfx = derivative(f, at: x)
            if abs(dfx) < 1e-12 { return nil }
            let x1 = x - fx/dfx
            if abs(x1 - x) < tol { return x1 }
            x = x1
        }
        return nil
    }
    public static func raizNewton(_ f: (Double) -> Double, x0: Double,
                                  tol: Double = 1e-8, maxIter: Int = 1000) -> Double? {
        newtonRoot(f, initialGuess: x0, tol: tol, maxIter: maxIter)
    }
}
