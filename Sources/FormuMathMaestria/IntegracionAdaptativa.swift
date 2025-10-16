//
//  IntegracionAdaptativa.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum IntegracionAdaptativa {
    // Simpson 1/3 adaptativo en [a,b]
    public static func simpson(_ f: @escaping (Double)->Double, a: Double, b: Double, tol: Double = 1e-8, maxRec: Int = 20) -> Double {
        func S(_ a: Double, _ b: Double) -> Double {
            let c = 0.5*(a+b)
            return (b-a)/6.0 * (f(a) + 4*f(c) + f(b))
        }
        let whole = S(a,b)
        func rec(_ a: Double, _ b: Double, _ whole: Double, _ tol: Double, _ depth: Int) -> Double {
            let c = 0.5*(a+b)
            let left = S(a,c), right = S(c,b)
            let diff = left + right - whole
            if abs(diff) <= 15*tol || depth >= maxRec {
                return left + right + diff/15.0
            }
            return rec(a,c,left,tol/2,depth+1) + rec(c,b,right,tol/2,depth+1)
        }
        return rec(a,b,whole,tol,0)
    }

    // Boole (regla 4ª) compuesta (m múltiplo de 4)
    public static func booleCompuesta(_ f: @escaping (Double)->Double, a: Double, b: Double, m: Int = 8) -> Double {
        precondition(m > 0 && m % 4 == 0)
        let h = (b-a)/Double(m)
        var S = 0.0
        for i in stride(from: 0, through: m-4, by: 4) {
            let x0 = a + Double(i)*h
            let x1 = x0 + h, x2 = x0 + 2*h, x3 = x0 + 3*h, x4 = x0 + 4*h
            S += (2*h/45.0) * (7*f(x0) + 32*f(x1) + 12*f(x2) + 32*f(x3) + 7*f(x4))
        }
        return S
    }
}
