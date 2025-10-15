//
//  Basicos.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//

import Foundation

public enum Basics {
    /// Addition / Suma
    public static func add(_ a: Double, _ b: Double) -> Double { a + b }
    public static func suma(_ a: Double, _ b: Double) -> Double { add(a, b) }

    /// Subtraction / Resta
    public static func subtract(_ a: Double, _ b: Double) -> Double { a - b }
    public static func resta(_ a: Double, _ b: Double) -> Double { subtract(a, b) }

    /// Multiplication / Multiplicación
    public static func multiply(_ a: Double, _ b: Double) -> Double { a * b }
    public static func multiplicar(_ a: Double, _ b: Double) -> Double { multiply(a, b) }

    /// Division (safe) / División (segura)
    public static func divide(_ a: Double, _ b: Double) -> Double? {
        guard b != 0 else { return nil }
        return a / b
    }
    public static func dividir(_ a: Double, _ b: Double) -> Double? { divide(a, b) }

    /// Power / Potencia
    public static func pow(_ a: Double, _ b: Double) -> Double { Foundation.pow(a, b) }
    public static func potencia(_ a: Double, _ b: Double) -> Double { pow(a, b) }

    /// Square root / Raíz cuadrada
    public static func sqrt(_ a: Double) -> Double { Foundation.sqrt(a) }
    public static func raizCuadrada(_ a: Double) -> Double { sqrt(a) }

    /// N-th root / Raíz n-ésima
    public static func root(_ a: Double, n: Double) -> Double? {
        guard n != 0 else { return nil }
        if a < 0 && Int(n) % 2 == 0 { return nil }
        return Foundation.pow(a, 1.0 / n)
    }
    public static func raiz(_ a: Double, n: Double) -> Double? { root(a, n: n) }
}
