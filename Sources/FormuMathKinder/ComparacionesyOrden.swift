//
//  Untitled.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Comparaciones de cantidades (como “¿quién tiene más fichas?”) y ordenaciones sencillas.
public enum ComparacionesYOrden {
    /// Compara la cantidad de elementos de dos colecciones.
    /// - Returns: -1 si a<b, 0 si a==b, 1 si a>b
    public static func compararCantidad<T, U>(_ a: T, _ b: U) -> Int
    where T: Collection, U: Collection {
        let ca = a.count, cb = b.count
        if ca < cb { return -1 }
        if ca > cb { return 1 }
        return 0
    }

    /// Ordena números de menor a mayor.
    public static func ordenarAsc(_ xs: [Int]) -> [Int] {
        xs.sorted()
    }

    /// Devuelve (min, max) si el arreglo no está vacío.
    public static func minimoMaximo(_ xs: [Int]) -> (Int, Int)? {
        guard var minv = xs.first else { return nil }
        var maxv = minv
        for x in xs.dropFirst() {
            if x < minv { minv = x }
            if x > maxv { maxv = x }
        }
        return (minv, maxv)
    }
}
