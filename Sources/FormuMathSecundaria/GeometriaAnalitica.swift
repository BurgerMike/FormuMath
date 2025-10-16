//
//  GeometriaAnalitica.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum GeometriaAnalitica {
    public static func pendiente(p1: (Double,Double), p2: (Double,Double)) -> Double? {
        let dx = p2.0 - p1.0
        if abs(dx) < .ulpOfOne { return nil } // recta vertical
        return (p2.1 - p1.1)/dx
    }

    public static func distancia(p1: (Double,Double), p2: (Double,Double)) -> Double {
        let dx = p2.0 - p1.0, dy = p2.1 - p1.1
        return (dx*dx + dy*dy).squareRoot()
    }

    /// Recta general por dos puntos: Ax + By + C = 0
    public static func rectaGeneral(p1: (Double,Double), p2: (Double,Double)) -> (A: Double, B: Double, C: Double) {
        let A = p1.1 - p2.1
        let B = p2.0 - p1.0
        let C = p1.0*p2.1 - p2.0*p1.1
        return (A,B,C)
    }

    /// Intersección de dos rectas en forma general (A x + B y + C = 0).
    public static func interseccion(_ r1: (A: Double,B: Double,C: Double),
                                    _ r2: (A: Double,B: Double,C: Double)) -> (x: Double, y: Double)? {
        let det = r1.A * r2.B - r2.A * r1.B
        if abs(det) < 1e-12 { return nil } // paralelas o coincidentes
        let x = (r1.B * r2.C - r2.B * r1.C) / det
        let y = (r2.A * r1.C - r1.A * r2.C) / det
        return (x, y)
    }

    /// Círculo por centro y radio: (x-h)^2 + (y-k)^2 = r^2  → devuelve (h,k,r)
    public static func circulo(centro: (Double,Double), radio r: Double) -> (Double, Double, Double) {
        (centro.0, centro.1, r)
    }

    /// ¿Punto pertenece al círculo? (tolerancia)
    public static func puntoEnCirculo(p: (Double,Double), centro: (Double,Double), r: Double, tol: Double = 1e-9) -> Bool {
        let dx = p.0 - centro.0, dy = p.1 - centro.1
        return abs(dx*dx + dy*dy - r*r) <= tol
    }
}
