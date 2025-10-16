//
//  EDOAnaliticas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum EDOAnaliticas {
    /// y' + p(x) y = q(x)  → factor integrante μ = e^{∫p dx}
    public static func linealPrimerOrden(p: @escaping (Double)->Double,
                                         q: @escaping (Double)->Double,
                                         x0: Double, y0: Double) -> (Double)->Double {
        return { x in
            let mu = exp(integralNum(p, a: x0, b: x))
            let mu0 = exp(0.0)
            let I = integralNum({ t in muAt(p, x0: x0, x: t) * q(t) }, a: x0, b: x)
            return (y0 * mu0 + I) / mu
        }
    }

    /// y'' + a y' + b y = 0 con a,b constantes
    public static func segundoOrdenConst(a: Double, b: Double, y0: Double, dy0: Double) -> (Double)->Double {
        let D = a*a - 4*b
        if D > 0 {
            let r1 = (-a - sqrt(D))/2, r2 = (-a + sqrt(D))/2
            let c2 = (dy0 - r1*y0)/(r2 - r1)
            let c1 = y0 - c2
            return { x in c1*exp(r1*x) + c2*exp(r2*x) }
        } else if D == 0 {
            let r = -a/2
            let c2 = dy0 - r*y0
            return { x in (y0 + c2*x)*exp(r*x) }
        } else {
            let alpha = -a/2, beta = sqrt(-D)/2
            // y = e^{alpha x}(C1 cos beta x + C2 sin beta x)
            let C2 = (dy0 - alpha*y0)/beta
            let C1 = y0
            return { x in exp(alpha*x)*(C1*cos(beta*x) + C2*sin(beta*x)) }
        }
    }

    // --- Helpers numéricos ---
    private static func muAt(_ p: @escaping (Double)->Double, x0: Double, x: Double) -> Double {
        exp(integralNum(p, a: x0, b: x))
    }
    private static func integralNum(_ f: @escaping (Double)->Double, a: Double, b: Double, n: Int = 200) -> Double {
        // Simpson compuesto (n par)
        let m = (n % 2 == 0) ? n : n+1
        let h = (b-a)/Double(m)
        var S = 0.0
        for i in 0...m {
            let x = a + Double(i)*h
            let w = (i==0 || i==m) ? 1.0 : (i%2==0 ? 2.0 : 4.0)
            S += w*f(x)
        }
        return S*h/3.0
    }
}
