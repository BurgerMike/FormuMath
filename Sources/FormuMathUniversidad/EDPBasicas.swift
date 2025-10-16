//
//  EDPBasicas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum EDPBasicas {
    /// Solución por separación 1D de Laplace en barra (0,L) con u(0,y)=0, u(L,y)=0, u(x,0)=0, u(x,H)=f(x) -> ejemplo básico:
    /// Aquí damos una "receta" para calor 1D estacionario equivalente a Laplace en 2D rectángulo delgado.
    public static func laplace1D_Rectangulo(L: Double, H: Double, N: Int,
                                            fronteraSuperior: @escaping (Double)->Double) -> (Double,Double)->Double {
        // u(x,y) = sum a_n sinh(n pi y / L) / sinh(n pi H / L) * sin(n pi x / L)
        let M = max(200, N*20)
        let hx = L/Double(M)
        var a = [Double](repeating: 0, count: N+1)
        for n in 1...N {
            var s = 0.0
            for i in 0...M {
                let x = Double(i)*hx
                let w = (i==0 || i==M) ? 0.5 : 1.0
                s += w * fronteraSuperior(x) * sin(Double(n)*Double.pi*x/L)
            }
            a[n] = (2.0/L) * s * hx
        }
        return { (x: Double, y: Double) in
            var u = 0.0
            for n in 1...N {
                let k = Double(n)*Double.pi/L
                u += a[n] * sinh(k*y) / sinh(k*H) * sin(k*x)
            }
            return u
        }
    }
}
