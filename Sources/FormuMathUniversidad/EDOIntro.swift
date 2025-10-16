//
//  EDOIntro.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Solución numérica de EDO: y' = f(t,y) con Euler y RK4. Soporta sistemas (y como vector).
public enum EDO {
    // Escalar -------------------------------------------------
    public static func euler(y0: Double, t0: Double, tf: Double, h: Double,
                             f: @escaping (Double,Double)->Double) -> [(t: Double, y: Double)] {
        var t = t0, y = y0
        var out: [(Double,Double)] = [(t,y)]
        while (h > 0 ? t < tf - 1e-12 : t > tf + 1e-12) {
            y += h * f(t,y)
            t += h
            out.append((t,y))
        }
        return out
    }

    public static func rk4(y0: Double, t0: Double, tf: Double, h: Double,
                           f: @escaping (Double,Double)->Double) -> [(t: Double, y: Double)] {
        var t = t0, y = y0
        var out: [(Double,Double)] = [(t,y)]
        while (h > 0 ? t < tf - 1e-12 : t > tf + 1e-12) {
            let k1 = f(t, y)
            let k2 = f(t + 0.5*h, y + 0.5*h*k1)
            let k3 = f(t + 0.5*h, y + 0.5*h*k2)
            let k4 = f(t + h, y + h*k3)
            y += (h/6.0) * (k1 + 2*k2 + 2*k3 + k4)
            t += h
            out.append((t,y))
        }
        return out
    }

    // Sistema y∈R^n ------------------------------------------
    public static func rk4Sistema(y0: [Double], t0: Double, tf: Double, h: Double,
                                  f: @escaping (Double,[Double])->[Double]) -> [(t: Double, y: [Double])] {
        var t = t0, y = y0
        var out: [(Double,[Double])] = [(t,y)]
        let n = y0.count

        func sum(_ a: [Double], _ b: [Double], _ s: Double) -> [Double] {
            var r = a
            for i in 0..<n { r[i] += s*b[i] }
            return r
        }

        while (h > 0 ? t < tf - 1e-12 : t > tf + 1e-12) {
            let k1 = f(t, y)
            let k2 = f(t + 0.5*h, sum(y, k1, 0.5*h))
            let k3 = f(t + 0.5*h, sum(y, k2, 0.5*h))
            let k4 = f(t + h,     sum(y, k3, h))
            var inc = [Double](repeating: 0, count: n)
            for i in 0..<n { inc[i] = (h/6.0)*(k1[i] + 2*k2[i] + 2*k3[i] + k4[i]) }
            y = sum(y, inc, 1.0)
            t += h
            out.append((t,y))
        }
        return out
    }
}
