//
//  IntegralesMultiplesYVectorial.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Vectorial {
    // Operadores en R^3
    public static func grad(_ f: @escaping (Double,Double,Double)->Double,
                            _ x: Double,_ y: Double,_ z: Double, h: Double = 1e-5) -> (Double,Double,Double) {
        let fx = (f(x+h,y,z)-f(x-h,y,z))/(2*h)
        let fy = (f(x,y+h,z)-f(x,y-h,z))/(2*h)
        let fz = (f(x,y,z+h)-f(x,y,z-h))/(2*h)
        return (fx,fy,fz)
    }
    public static func div(_ F: @escaping (Double,Double,Double)->(Double,Double,Double),
                           _ x: Double,_ y: Double,_ z: Double, h: Double = 1e-5) -> Double {
        let Fx = { (x: Double, y: Double, z: Double) in F(x,y,z).0 }
        let Fy = { (x: Double, y: Double, z: Double) in F(x,y,z).1 }
        let Fz = { (x: Double, y: Double, z: Double) in F(x,y,z).2 }
        let dFx = (Fx(x+h,y,z)-Fx(x-h,y,z))/(2*h)
        let dFy = (Fy(x,y+h,z)-Fy(x,y-h,z))/(2*h)
        let dFz = (Fz(x,y,z+h)-Fz(x,y,z-h))/(2*h)
        return dFx + dFy + dFz
    }
    public static func curl(_ F: @escaping (Double,Double,Double)->(Double,Double,Double),
                            _ x: Double,_ y: Double,_ z: Double, h: Double = 1e-5) -> (Double,Double,Double) {
        let Fx = { (x: Double, y: Double, z: Double) in F(x,y,z).0 }
        let Fy = { (x: Double, y: Double, z: Double) in F(x,y,z).1 }
        let Fz = { (x: Double, y: Double, z: Double) in F(x,y,z).2 }
        let dFz_dy = (Fz(x,y+h,z)-Fz(x,y-h,z))/(2*h)
        let dFy_dz = (Fy(x,y,z+h)-Fy(x,y,z-h))/(2*h)
        let dFx_dz = (Fx(x,y,z+h)-Fx(x,y,z-h))/(2*h)
        let dFz_dx = (Fz(x+h,y,z)-Fz(x-h,y,z))/(2*h)
        let dFy_dx = (Fy(x+h,y,z)-Fy(x-h,y,z))/(2*h)
        let dFx_dy = (Fx(x,y+h,z)-Fx(x,y-h,z))/(2*h)
        return (dFz_dy - dFy_dz, dFx_dz - dFz_dx, dFy_dx - dFx_dy)
    }

    // Integral doble simple (rectángulo) por regla de Simpson compuesta (m,n pares).
    public static func integralDobleRect(_ f: @escaping (Double,Double)->Double,
                                         ax: Double, bx: Double, ay: Double, by: Double,
                                         m: Int = 10, n: Int = 10) -> Double {
        precondition(m > 0 && n > 0 && m%2==0 && n%2==0)
        let hx = (bx-ax)/Double(m), hy = (by-ay)/Double(n)
        var S = 0.0
        for i in 0...m {
            for j in 0...n {
                let x = ax + Double(i)*hx
                let y = ay + Double(j)*hy
                let wx = (i==0 || i==m) ? 1 : (i%2==0 ? 2 : 4)
                let wy = (j==0 || j==n) ? 1 : (j%2==0 ? 2 : 4)
                S += Double(wx*wy) * f(x,y)
            }
        }
        return S * hx * hy / 9.0
    }
}
