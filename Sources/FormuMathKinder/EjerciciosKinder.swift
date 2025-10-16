//
//  EjerciciosKiinder.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Generación de ejercicios simples para Kinder (sumas/restas, patrones, amigos del 10).
public enum EjerciciosKinder {
    public struct Ejercicio: Equatable {
        public enum Tipo { case suma, resta, patron, amigosDelDiez }
        public let tipo: Tipo
        public let enunciado: String
        public let respuesta: [Int]   // para suma/resta tendrá 1 valor; para patron o amigos, varios

        public init(tipo: Tipo, enunciado: String, respuesta: [Int]) {
            self.tipo = tipo
            self.enunciado = enunciado
            self.respuesta = respuesta
        }
    }

    /// Suma dentro de un rango (por defecto 0…10). Siempre válida dentro del rango.
    public static func generarSuma(dentro rango: ClosedRange<Int> = 0...10) -> Ejercicio {
        let a = Int.random(in: rango)
        let maxB = rango.upperBound - a
        let b = Int.random(in: 0...max(0, maxB))
        let r = a + b
        return Ejercicio(tipo: .suma, enunciado: "\(a) + \(b) = ?", respuesta: [r])
    }

    /// Resta dentro de un rango (sin negativos si el rango empieza en 0).
    public static func generarResta(dentro rango: ClosedRange<Int> = 0...10) -> Ejercicio {
        let a = Int.random(in: rango)
        let b = Int.random(in: 0...min(a - rango.lowerBound, rango.upperBound))
        let r = a - b
        return Ejercicio(tipo: .resta, enunciado: "\(a) − \(b) = ?", respuesta: [r])
    }

    /// Patrón alternante ABAB… de longitud `count` (devuelve el patrón generado).
    public static func generarPatronAlternante<A: Comparable>(
        a: A, b: A, count: Int
    ) -> Ejercicio where A: LosslessStringConvertible {
        precondition(count >= 2 && a != b, "count>=2 y a!=b")
        var arr: [A] = []
        arr.reserveCapacity(count)
        for i in 0..<count { arr.append(i % 2 == 0 ? a : b) }
        let texto = arr.map { String($0) }.joined(separator: ", ")
        return Ejercicio(tipo: .patron, enunciado: "Completa patrón alternante: \(texto)", respuesta: [])
    }

    /// “Amigos del 10”: da un número x y pide el complemento 10−x.
    public static func generarAmigosDelDiez() -> Ejercicio {
        let x = Int.random(in: 0...10)
        let y = 10 - x
        return Ejercicio(tipo: .amigosDelDiez, enunciado: "¿Con qué número \(x) hace 10?", respuesta: [y])
    }

    /// Verificador simple: para suma/resta compara valor, para amigos compara el complemento.
    public static func verificar(_ ejercicio: Ejercicio, respuesta: [Int]) -> Bool {
        switch ejercicio.tipo {
        case .suma, .resta:
            guard let esperado = ejercicio.respuesta.first, let dado = respuesta.first else { return false }
            return esperado == dado
        case .amigosDelDiez:
            guard let y = ejercicio.respuesta.first, let dado = respuesta.first else { return false }
            return y == dado
        case .patron:
            // Aquí no exigimos respuesta; suele ser actividad de completar con UI
            return true
        }
    }
}
