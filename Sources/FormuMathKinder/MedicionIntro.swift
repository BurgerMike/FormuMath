//
//  MedicionIntro.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// “Medición” comparativa sin unidades: más largo/corto, más pesado/ligero, etc.
/// Se modela con números enteros como magnitud abstracta (p.ej., 7 bloques > 5 bloques).
public enum MedicionIntro {
    public enum Comparacion: String { case menor, igual, mayor }

    /// Compara dos magnitudes (no negativas).
    public static func compararMagnitudes(_ a: Int, _ b: Int) -> Comparacion {
        if a < b { return .menor }
        if a > b { return .mayor }
        return .igual
    }

    /// Ordena magnitudes de menor a mayor.
    public static func ordenar(_ xs: [Int]) -> [Int] { xs.sorted() }

    /// ¿Cabe un objeto de largo L en un contenedor de capacidad C? (L ≤ C)
    public static func cabe(_ largo: Int, en capacidad: Int) -> Bool {
        largo <= capacidad
    }
}

