//
//  EDPClasicas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum EDPClasicas {
    // Series separadas (muy básicas) para calor en barra (0,L) con T(0,t)=T(L,t)=0 y T(x,0)=f(x).
    // Se aproxima con N términos usando coeficientes por proyección discreta (trapecio simple).
    public static func calor1DSerie(L: Double, kappa: Double,
                                    N: Int,
                                    f0: @escaping (Double)->Double) -> (Double,Double,Double)->Double {
        // Pre-computa coeficientes a_n ≈ 2/L ∫_0^L f(x) sin(nπx/L) dx
        let M = max(200, N*20)
        let h = L/Double(M)
        var a = [Double](repeating: 0, count: N+1)
        for n in 1...N {
            var s = 0.0
            for i in 0...M {
                let x = Double(i)*h
                let w = (i == 0 || i == M) ? 0.5 : 1.0
                s += w * f0(x) * sin(Double(n) * Double.pi * x / L)
            }
            a[n] = (2.0 / L) * s * h
        }
        return { (x: Double, t: Double, _: Double) in
            var u = 0.0
            for n in 1...N {
                let lambda = Double(n) * Double.pi / L
                u += a[n] * exp(-kappa * lambda * lambda * t) * sin(lambda * x)
            }
            return u
        }
    }

    // Onda en cuerda fija (0,L). u(x,t)=∑(A_n cos(c nπ t/L)+B_n sin(...)) sin(nπx/L). Aquí fijamos B_n=0 y proyectamos A_n.
    public static func onda1DSerie(L: Double, c: Double, N: Int, u0: @escaping (Double)->Double) -> (Double,Double,Double)->Double {
        let M = max(200, N*20); let h = L/Double(M)
        var A = [Double](repeating: 0, count: N+1)
        for n in 1...N {
            var s = 0.0
            for i in 0...M {
                let x = Double(i)*h
                let w = (i == 0 || i == M) ? 0.5 : 1.0
                s += w * u0(x) * sin(Double(n) * Double.pi * x / L)
            }
            A[n] = (2.0 / L) * s * h
        }
        return { (x: Double, t: Double, _: Double) in
            var u = 0.0
            for n in 1...N {
                let omega = c * Double(n) * Double.pi / L
                u += A[n] * cos(omega * t) * sin(Double(n) * Double.pi * x / L)
            }
            return u
        }
    }

    // Esquema explícito FTCS para calor 1D: u_i^{n+1} = u_i^n + r (u_{i+1}^n - 2u_i^n + u_{i-1}^n), con r = κ Δt / Δx^2, r ≤ 1/2.
    public static func calor1D_Explicito(L: Double, kappa: Double, nx: Int, dt: Double, pasos: Int,
                                         condicionInicial: @escaping (Double)->Double) -> ([Double],[Double]) {
        let dx = L/Double(nx-1)
        let r = kappa*dt/(dx*dx)
        precondition(r <= 0.5, "Inestable: r debe ser ≤ 0.5")
        var x = (0..<nx).map { Double($0)*dx }
        var u = x.map(condicionInicial)
        var next = u
        for _ in 0..<pasos {
            for i in 1..<(nx-1) {
                next[i] = u[i] + r*(u[i+1] - 2*u[i] + u[i-1])
            }
            // Dirichlet 0 en extremos
            next[0] = 0; next[nx-1] = 0
            swap(&u,&next)
        }
        return (x,u)
    }
}
