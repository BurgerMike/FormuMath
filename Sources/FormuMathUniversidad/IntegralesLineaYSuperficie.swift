//
//  IntegralesLineaYSuperficie.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum IntegralesLineaYSuperficie {
    /// Integral de línea ∫_C F·dr sobre curva param. r(t) en [a,b] por Simpson compuesto (n par).
    public static func integralDeLinea(F: @escaping (Double,Double)->(Double,Double),
                                       r: @escaping (Double)->(Double,Double),
                                       a: Double, b: Double, n: Int = 100) -> Double {
        precondition(n > 0 && n % 2 == 0)
        let h = (b-a)/Double(n)
        func integrando(_ t: Double) -> Double {
            let (x,y) = r(t)
            let (Fx,Fy) = F(x,y)
            let (xp,yp) = derivada(r, t: t)
            return Fx*xp + Fy*yp
        }
        var S = 0.0
        for i in 0...n {
            let t = a + Double(i)*h
            let w = (i == 0 || i == n) ? 1.0 : (i % 2 == 0 ? 2.0 : 4.0)
            S += w * integrando(t)
        }
        return S * h / 3.0
    }

    /// Integral de superficie sobre z = g(x,y) en [ax,bx]×[ay,by] de F·n dS, con n orientada hacia arriba.
    /// F = (P,Q,R). Aproxima con Simpson 2D (m,n pares).
    public static func flujoSobreSuperficie(P: @escaping (Double,Double,Double)->Double,
                                            Q: @escaping (Double,Double,Double)->Double,
                                            R: @escaping (Double,Double,Double)->Double,
                                            g: @escaping (Double,Double)->Double,
                                            ax: Double, bx: Double, ay: Double, by: Double,
                                            m: Int = 20, n: Int = 20) -> Double {
        precondition(m > 0 && n > 0 && m % 2 == 0 && n % 2 == 0)
        let hx = (bx-ax)/Double(m), hy = (by-ay)/Double(n)
        func integrando(_ x: Double, _ y: Double) -> Double {
            // n dS = (-g_x, -g_y, 1) dx dy
            let gx = (g(x+1e-6,y) - g(x-1e-6,y)) / (2e-6)
            let gy = (g(x,y+1e-6) - g(x,y-1e-6)) / (2e-6)
            let z = g(x,y)
            return -P(x,y,z)*gx - Q(x,y,z)*gy + R(x,y,z)
        }
        var S = 0.0
        for i in 0...m {
            for j in 0...n {
                let x = ax + Double(i)*hx
                let y = ay + Double(j)*hy
                let wx = (i==0 || i==m) ? 1.0 : (i%2==0 ? 2.0 : 4.0)
                let wy = (j==0 || j==n) ? 1.0 : (j%2==0 ? 2.0 : 4.0)
                S += wx*wy*integrando(x,y)
            }
        }
        return S * hx * hy / 9.0
    }

    private static func derivada(_ r: @escaping (Double)->(Double,Double), t: Double) -> (Double,Double) {
        let h = 1e-6
        let (x1,y1) = r(t+h), (x0,y0) = r(t-h)
        return ((x1-x0)/(2*h), (y1-y0)/(2*h))
    }
}
