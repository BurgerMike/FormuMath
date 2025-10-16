//
//  OperacionesSimples.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Operaciones pensadas para Kindergarten: sumas/restas pequeñas y descomposición (number bonds).
public enum OperacionesSimples {
    /// Suma segura limitada a un rango (por defecto 0…20) para ejercicios con dedos/contadores.
    public static func suma(_ a: Int, _ b: Int, limite: ClosedRange<Int> = 0...20) -> Int? {
        let r = a + b
        return limite.contains(r) ? r : nil
    }

    /// Resta segura limitada a un rango (por defecto 0…20). No permite negativos si el rango empieza en 0.
    public static func resta(_ a: Int, _ b: Int, limite: ClosedRange<Int> = 0...20) -> Int? {
        let r = a - b
        return limite.contains(r) ? r : nil
    }

    /// Descomposición de un número n como pares (x, n-x) dentro de [0,n].
    /// Ej: n=5 → [(0,5),(1,4),(2,3),(3,2),(4,1),(5,0)]
    public static func descomposiciones(_ n: Int) -> [(Int,Int)] {
        guard n >= 0 else { return [] }
        return (0...n).map { ($0, n - $0) }
    }

    /// ¿Dos números “hacen” el objetivo? (para tarjetas tipo “10 amigos”)
    public static func hacenObjetivo(_ a: Int, _ b: Int, objetivo: Int) -> Bool {
        a + b == objetivo
    }
}
