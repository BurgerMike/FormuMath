//
//  MatricesIntro.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Intro de matrices (2x2 y 3x3): operaciones, determinante, inversa 2x2, sistema 2x2/3x3.
public enum MatricesIntro {

    public struct M2: Equatable {
        public var a11: Double, a12: Double
        public var a21: Double, a22: Double
        public init(_ a11: Double,_ a12: Double,_ a21: Double,_ a22: Double) {
            self.a11=a11; self.a12=a12; self.a21=a21; self.a22=a22
        }
    }

    public struct M3: Equatable {
        public var a11: Double,a12: Double,a13: Double
        public var a21: Double,a22: Double,a23: Double
        public var a31: Double,a32: Double,a33: Double
        public init(_ a11: Double,_ a12: Double,_ a13: Double,
                    _ a21: Double,_ a22: Double,_ a23: Double,
                    _ a31: Double,_ a32: Double,_ a33: Double) {
            self.a11=a11; self.a12=a12; self.a13=a13
            self.a21=a21; self.a22=a22; self.a23=a23
            self.a31=a31; self.a32=a32; self.a33=a33
        }
    }

    // Determinantes
    public static func det(_ A: M2) -> Double { A.a11*A.a22 - A.a12*A.a21 }

    public static func det(_ A: M3) -> Double {
        // Regla de Sarrus
        let p1 = A.a11*A.a22*A.a33 + A.a12*A.a23*A.a31 + A.a13*A.a21*A.a32
        let p2 = A.a13*A.a22*A.a31 + A.a11*A.a23*A.a32 + A.a12*A.a21*A.a33
        return p1 - p2
    }

    // Inversa 2x2 (si det != 0)
    public static func inversa(_ A: M2) -> M2? {
        let d = det(A)
        if abs(d) < 1e-12 { return nil }
        return M2( A.a22/d, -A.a12/d, -A.a21/d, A.a11/d )
    }

    // Producto M2xM2
    public static func mul(_ A: M2, _ B: M2) -> M2 {
        M2(
            A.a11*B.a11 + A.a12*B.a21, A.a11*B.a12 + A.a12*B.a22,
            A.a21*B.a11 + A.a22*B.a21, A.a21*B.a12 + A.a22*B.a22
        )
    }

    // Resolver sistema 2x2: A x = b
    public static func resolver2x2(A: M2, b: (Double,Double)) -> (Double,Double)? {
        guard let inv = inversa(A) else { return nil }
        let x1 = inv.a11*b.0 + inv.a12*b.1
        let x2 = inv.a21*b.0 + inv.a22*b.1
        return (x1,x2)
    }

    // Resolver 3x3 por Cramer (sencillo para prepa)
    public static func resolver3x3(A: M3, b: (Double,Double,Double)) -> (Double,Double,Double)? {
        let D  = det(A); if abs(D) < 1e-12 { return nil }
        let Ax = M3(b.0, A.a12, A.a13,  b.1, A.a22, A.a23,  b.2, A.a32, A.a33)
        let Ay = M3(A.a11, b.0, A.a13,  A.a21, b.1, A.a23,  A.a31, b.2, A.a33)
        let Az = M3(A.a11, A.a12, b.0,  A.a21, A.a22, b.1,  A.a31, A.a32, b.2)
        return (det(Ax)/D, det(Ay)/D, det(Az)/D)
    }
}
