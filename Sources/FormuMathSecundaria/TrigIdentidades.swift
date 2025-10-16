//
//  TrigIdentidades.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum TrigIdentidades {
    // Conversión
    public static func gradosARadianes(_ deg: Double) -> Double { deg * .pi / 180.0 }
    public static func radianesAGrados(_ rad: Double) -> Double { rad * 180.0 / .pi }

    // Identidad pitagórica
    public static func identidadPitagorica(sin x: Double) -> Double {
        // Devuelve cos^2 + sin^2 (debería ser 1)
        let s = sin(x), c = cos(x)
        return s*s + c*c
    }

    // Sumas/Restas de ángulos
    public static func sinSuma(_ a: Double, _ b: Double) -> Double { sin(a)*cos(b) + cos(a)*sin(b) }
    public static func sinResta(_ a: Double, _ b: Double) -> Double { sin(a)*cos(b) - cos(a)*sin(b) }
    public static func cosSuma(_ a: Double, _ b: Double) -> Double { cos(a)*cos(b) - sin(a)*sin(b) }
    public static func cosResta(_ a: Double, _ b: Double) -> Double { cos(a)*cos(b) + sin(a)*sin(b) }
    public static func tanSuma(_ a: Double, _ b: Double) -> Double { (tan(a) + tan(b)) / (1 - tan(a)*tan(b)) }
    public static func tanResta(_ a: Double, _ b: Double) -> Double { (tan(a) - tan(b)) / (1 + tan(a)*tan(b)) }

    // Resolución de triángulo rectángulo con cateto opuesto y ángulo (en radianes).
    public static func hipotenusaDesdeOpuesto(_ op: Double, anguloRad: Double) -> Double {
        precondition(op >= 0)
        return op / sin(anguloRad)
    }
    public static func adyacenteDesdeOpuesto(_ op: Double, anguloRad: Double) -> Double {
        precondition(op >= 0)
        return op / tan(anguloRad)
    }

    // Arcos con dominio seguro
    public static func arcos(_ x: Double) -> Double? {
        guard x >= -1 && x <= 1 else { return nil }
        return acos(x)
    }
    public static func arcsinSeguro(_ x: Double) -> Double? {
        guard x >= -1 && x <= 1 else { return nil }
        return asin(x)
    }
}
