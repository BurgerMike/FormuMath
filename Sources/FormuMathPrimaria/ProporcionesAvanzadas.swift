//
//  ProporcionesAvanzadas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Proporciones y razones “de la vida real”: escalas, mezclas, MCM para alinear razones.
public enum ProporcionesAvanzadas {

    // MARK: - Utilidades
    @inline(__always)
    private static func mcd(_ a: Int, _ b: Int) -> Int {
        var x = abs(a), y = abs(b)
        while y != 0 { (x, y) = (y, x % y) }
        return x
    }

    @inline(__always)
    private static func mcm(_ a: Int, _ b: Int) -> Int {
        let g = mcd(a, b)
        return (abs(a / g) * abs(b))
    }

    // MARK: - Simplificar razones
    /// Simplifica una razón a:b (enteros) dividiendo por el MCD.
    public static func simplificarRazon(a: Int, b: Int) -> (Int, Int) {
        precondition(b != 0, "b != 0")
        let g = mcd(a, b)
        return (a / g, b / g)
    }

    /// Verifica si a:b = c:d (producto cruzado)
    public static func esProporcion(a: Int, b: Int, c: Int, d: Int) -> Bool {
        precondition(b != 0 && d != 0, "b y d != 0")
        return a * d == b * c
    }

    // MARK: - Escalas (mapas/recetas)
    /// Para una escala R:1 (por ejemplo 1000:1), transforma longitud real -> longitud en mapa.
    public static func realAmapa(longitudReal: Double, escalaR_a_1: Double) -> Double {
        precondition(escalaR_a_1 > 0, "escala>0")
        return longitudReal / escalaR_a_1
    }

    /// Para una escala R:1, transforma longitud de mapa -> longitud real.
    public static func mapaAreal(longitudMapa: Double, escalaR_a_1: Double) -> Double {
        precondition(escalaR_a_1 > 0, "escala>0")
        return longitudMapa * escalaR_a_1
    }

    /// Regla de tres directa general (determinística).
    /// a : b = c : x  →  x = (b*c)/a
    public static func reglaDeTres(a: Double, b: Double, c: Double) -> Double {
        precondition(a != 0, "a != 0")
        return (b * c) / a
    }

    // MARK: - Mezclas/recetas (alinear por MCM)
    /// Dados dos ingredientes con razón A:B y C:D, encuentra la menor mezcla conjunta
    /// que respete ambas razones (multiplicando por factores enteros usando MCM).
    ///
    /// Ejemplo: A:B = 2:3 y C:D = 3:4 → menor múltiplo común para “partes totales” 5 y 7 es 35;
    /// pero queremos respetar cada par por separado. Usamos MCM por componente:
    /// - Para el primer componente (A y C): buscamos k1,k2 tal que 2*k1 == 3*k2 → L = mcm(2,3)=6 → (A*3, C*2) = (6,6)
    /// - Para el segundo (B y D): 3*k1' == 4*k2' → L = mcm(3,4)=12 → (B*4, D*3) = (12,12)
    ///
    /// La mezcla conjunta mínima que respeta ambos pares es:
    /// (A*kA, B*kB) combinado con (C*kC, D*kD) usando los mcm de cada componente.
    public static func mezclaMinimaRespetandoRazones(
        A: Int, B: Int, C: Int, D: Int
    ) -> (mezcla1: (Int, Int), mezcla2: (Int, Int)) {
        precondition(A > 0 && B > 0 && C > 0 && D > 0, "partes > 0")
        // componente 1 (A vs C)
        let L1 = mcm(A, C)
        let kA = L1 / A
        let kC = L1 / C
        // componente 2 (B vs D)
        let L2 = mcm(B, D)
        let kB = L2 / B
        let kD = L2 / D
        // devuelve las “cantidades” escaladas para cada mezcla
        return ((A * kA, B * kB), (C * kC, D * kD))
    }

    /// Escala una razón a:b para obtener un total deseado de “partes”.
    /// Devuelve (x,y) tal que x+y == totalPartes y x:y == a:b (si es posible exactamente).
    /// Si no es exacto, devuelve la aproximación proporcional más cercana por redondeo.
    public static func escalarRazonAlTotal(a: Int, b: Int, totalPartes: Int) -> (Int, Int) {
        precondition(a > 0 && b > 0 && totalPartes > 0)
        let s = a + b
        if totalPartes % s == 0 {
            let f = totalPartes / s
            return (a * f, b * f)
        } else {
            // aproximación proporcional
            let x = Int(round(Double(a) / Double(s) * Double(totalPartes)))
            let y = max(0, totalPartes - x)
            return (x, y)
        }
    }
}

