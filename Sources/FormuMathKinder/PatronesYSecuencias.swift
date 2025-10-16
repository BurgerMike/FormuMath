//
//  PatronesYSecuencias.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Patrones simples y secuencias muy básicas.
public enum PatronesYSecuencias {
    /// Dado un patrón repetido (por ejemplo [1,2]) genera una secuencia de longitud `count`.
    public static func repetirPatron<T>(_ patron: [T], count: Int) -> [T] {
        guard !patron.isEmpty, count > 0 else { return [] }
        var out: [T] = []; out.reserveCapacity(count)
        for i in 0..<count { out.append(patron[i % patron.count]) }
        return out
    }

    /// Siguiente elemento de series aritméticas muy simples: [a, a+d, a+2d,...]
    /// Devuelve nil si no se puede inferir (menos de 2 elementos).
    public static func siguienteAritmetica(_ serie: [Int]) -> Int? {
        guard serie.count >= 2 else { return nil }
        let d = serie[1] - serie[0]
        for i in 2..<serie.count where serie[i] - serie[i-1] != d { return nil }
        return serie.last! + d
    }

    /// Verifica si un arreglo cumple alternancia “ABAB…” (patrón de 2 símbolos).
    public static func esAlternante<T: Equatable>(_ xs: [T]) -> Bool {
        guard xs.count >= 2 else { return false }
        let a = xs[0], b = xs[1]; if a == b { return false }
        for i in 0..<xs.count { if xs[i] != (i % 2 == 0 ? a : b) { return false } }
        return true
    }
}
