//
//  RK4Adaptativo.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum RK4Adaptativo {
    /// Resuelve y' = f(t,y) con control de paso (doble evaluación: paso h y dos de h/2).
    /// Devuelve muestras (t,y); ajusta h para mantener error ≈ tolAbs.
    public static func integrar(y0: Double,
                                t0: Double,
                                tf: Double,
                                hInicial: Double,
                                tolAbs: Double = 1e-6,
                                f: @escaping (Double,Double)->Double) -> [(Double,Double)] {
        var t = t0
        var y = y0
        var h = hInicial
        var out: [(Double,Double)] = [(t,y)]

        func rk4(_ t: Double, _ y: Double, _ h: Double) -> Double {
            let k1 = f(t, y)
            let k2 = f(t + 0.5*h, y + 0.5*h*k1)
            let k3 = f(t + 0.5*h, y + 0.5*h*k2)
            let k4 = f(t + h,       y + h*k3)
            return y + (h/6.0)*(k1 + 2.0*k2 + 2.0*k3 + k4)
        }

        // pequeño epsilon para comparaciones
        let eps = 1e-15
        let safety = 0.9
        let order: Double = 4.0 // RK4

        while t < tf - eps {
            if t + h > tf { h = tf - t }

            let yH   = rk4(t, y, h)
            let yH2  = rk4(t, y, h/2.0)
            let yH2b = rk4(t + h/2.0, yH2, h/2.0)

            let err = abs(yH2b - yH)
            // factor de ajuste con cota inferior para evitar división por ~0
            let ratio = tolAbs / max(err, 1e-16)
            let factor = min(5.0, max(0.2, safety * pow(ratio, 1.0/(order + 1.0))))

            if err < tolAbs {
                t += h
                y = yH2b
                out.append((t, y))
                h *= factor
            } else {
                h *= max(0.1, factor)
            }

            if h < 1e-12 { break }
        }

        return out
    }
}

