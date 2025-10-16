//
//  NumerosBasicos.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Conceptos base de números para Kinder (conteo, paridad, comparar).
public enum NumerosBasicos {
    /// Compara dos enteros: -1 si a<b, 0 si a==b, 1 si a>b
    public static func comparar(_ a: Int, _ b: Int) -> Int {
        if a < b { return -1 }
        if a > b { return 1 }
        return 0
    }

    /// ¿Es un número par?
    public static func esPar(_ n: Int) -> Bool { n % 2 == 0 }

    /// Genera conteo 0, paso, 2*paso, ... hasta `max` (incluyendo si cae exacto).
    public static func contarDe(_ paso: Int, hasta max: Int) -> [Int] {
        guard paso > 0, max >= 0 else { return [] }
        return stride(from: 0, through: max, by: paso).map { $0 }
    }

    /// Secuencia aritmética simple: start, start+step, ...
    public static func secuencia(start: Int, step: Int, count: Int) -> [Int] {
        guard count > 0 else { return [] }
        return (0..<count).map { start + $0 * step }
    }

    /// Números en palabras (0–20), útil para ejercicios de lectura.
    public static func enPalabras(_ n: Int) -> String? {
        let mapa: [Int:String] = [
            0:"cero",1:"uno",2:"dos",3:"tres",4:"cuatro",5:"cinco",
            6:"seis",7:"siete",8:"ocho",9:"nueve",10:"diez",
            11:"once",12:"doce",13:"trece",14:"catorce",15:"quince",
            16:"dieciséis",17:"diecisiete",18:"dieciocho",19:"diecinueve",20:"veinte"
        ]
        return mapa[n]
    }
}
