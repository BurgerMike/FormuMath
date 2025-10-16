//
//  TrigonometriaAvanzada.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum TrigonometriaAvanzada {
    // Identidades de doble y mitad de ángulo
    public static func sinDoble(_ x: Double) -> Double { 2*sin(x)*cos(x) }
    public static func cosDoble(_ x: Double) -> Double { cos(x)*cos(x) - sin(x)*sin(x) } // = 2cos^2-1
    public static func tanDoble(_ x: Double) -> Double { 2*tan(x)/(1 - tan(x)*tan(x)) }

    public static func sinMitad(_ x: Double) -> Double { sqrt((1 - cos(x))/2) } // rama principal
    public static func cosMitad(_ x: Double) -> Double { sqrt((1 + cos(x))/2) } // rama principal

    // Producto a suma (casos típicos)
    public static func sinxSiny_a_suma(_ x: Double, _ y: Double) -> (Double, Double) {
        // sin x sin y = [cos(x-y) - cos(x+y)]/2
        let v = (cos(x - y) - cos(x + y)) / 2
        return (v, v) // helper para pruebas (mismo valor dos veces)
    }

    // Ley de senos y cosenos (triángulos no rectángulos)
    public static func ladoPorLeyDeCosenos(a: Double, b: Double, gammaRad: Double) -> Double {
        // c^2 = a^2 + b^2 - 2ab cos γ
        let c2 = a*a + b*b - 2*a*b*cos(gammaRad)
        return c2.squareRoot()
    }

    public static func anguloPorLeyDeSenos(lado: Double, opuesto: Double, anguloOpuestoRad: Double) -> Double? {
        // sin(θ)/lado = sin(α)/opuesto
        let s = lado * sin(anguloOpuestoRad) / opuesto
        if s < -1 || s > 1 { return nil }
        return asin(s)
    }
}
