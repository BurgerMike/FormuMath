//
//  NewtonRaphson.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum NewtonRaphson {
    /// Newton 1D con derivada numérica si no se provee; retorna nil si no converge.
    public static func resolver(f: @escaping (Double)->Double,
                                df: ((Double)->Double)? = nil,
                                x0: Double, tol: Double = 1e-10, maxIter: Int = 80) -> Double? {
        var x = x0
        let dfx: (Double)->Double = df ?? { x in
            let h = 1e-6
            return (f(x+h) - f(x-h))/(2*h)
        }
        for _ in 0..<maxIter {
            let fx = f(x)
            let d = dfx(x)
            if abs(d) < 1e-15 { return nil }
            let xn = x - fx/d
            if abs(xn - x) < tol { return xn }
            x = xn
        }
        return nil
    }
}
