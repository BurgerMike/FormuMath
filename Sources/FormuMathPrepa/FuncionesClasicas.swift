//
//  FuncionesClasicas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum FuncionesClasicas {

    // Lineal: y = m x + b
    public static func lineal(m: Double, b: Double) -> (Double) -> Double {
        { x in m*x + b }
    }

    // Cuadrática: y = a x^2 + b x + c
    public static func cuadratica(a: Double, b: Double, c: Double) -> (Double) -> Double {
        { x in a*x*x + b*x + c }
    }

    public static func verticeCuadratica(a: Double, b: Double, c: Double) -> (x: Double, y: Double) {
        let xv = -b/(2*a)
        return (xv, a*xv*xv + b*xv + c)
    }

    public static func discriminante(a: Double, b: Double, c: Double) -> Double {
        b*b - 4*a*c
    }

    public static func raicesCuadratica(a: Double, b: Double, c: Double) -> (Double?, Double?) {
        let D = discriminante(a: a, b: b, c: c)
        if D < 0 { return (nil, nil) }
        let sD = sqrt(D)
        return ((-b - sD)/(2*a), (-b + sD)/(2*a))
    }

    // Racional: y = (p(x)) / (q(x)) evaluado por Horner
    public static func racional(num: [Double], den: [Double]) -> (Double) -> Double {
        { x in
            let n = horner(num, x)
            let d = horner(den, x)
            precondition(abs(d) > 0, "Denominador 0")
            return n/d
        }
    }

    // Exponencial: y = A * r^x  (r>0)
    public static func exponencial(A: Double, r: Double) -> (Double) -> Double {
        { x in A * pow(r, x) }
    }

    // Logarítmica: y = a + b * log_c(x)  (x>0, c>0,c≠1)
    public static func logaritmica(a: Double, b: Double, base c: Double) -> (Double) -> Double {
        { x in
            precondition(x > 0 && c > 0 && c != 1)
            return a + b * (Foundation.log(x)/Foundation.log(c))
        }
    }

    // Utilidades
    private static func horner(_ coef: [Double], _ x: Double) -> Double {
        guard var acc = coef.last else { return 0 }
        for c in coef.dropLast().reversed() { acc = acc * x + c }
        return acc
    }
}
