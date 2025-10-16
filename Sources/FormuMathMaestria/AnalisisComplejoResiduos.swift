//
//  AnalisisComplejoResiduos.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum ComplejoResiduos {
    public struct PoloSimple {
        /// Residuo de f(z)=g(z)/h(z) en z0, donde h(z0)=0 y h'(z0)≠0, usando Res = g(z0)/h'(z0).
        public static func residuo(g: (Double,Double)->(Double,Double),
                                   h: (Double,Double)->(Double,Double),
                                   dh: (Double,Double)->(Double,Double),
                                   z0: (Double,Double)) -> (Double,Double) {
            let gz = g(z0.0, z0.1)
            let dhz = dh(z0.0, z0.1)
            // División compleja: (a+ib)/(c+id)
            let (a,b) = gz; let (c,d) = dhz
            let den = c*c + d*d
            precondition(den > 0)
            return ( (a*c + b*d)/den, (b*c - a*d)/den )
        }
    }

    /// Producto y suma de complejos (utilidades chicas)
    public static func mul(_ z:(Double,Double), _ w:(Double,Double)) -> (Double,Double) {
        (z.0*w.0 - z.1*w.1, z.0*w.1 + z.1*w.0)
    }
    public static func add(_ z:(Double,Double), _ w:(Double,Double)) -> (Double,Double) {
        (z.0 + w.0, z.1 + w.1)
    }
}
