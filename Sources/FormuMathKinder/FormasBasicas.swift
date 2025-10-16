//
//  FormasBasicas.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Reconocimiento conceptual de formas 2D comunes (sin fórmulas todavía).
public enum FormaBasica: String, CaseIterable {
    case circulo, triangulo, cuadrado, rectangulo

    /// Número de lados/curvas cerradas (círculo se considera 1 curva cerrada).
    public var lados: Int {
        switch self {
        case .circulo: return 1
        case .triangulo: return 3
        case .cuadrado: return 4
        case .rectangulo: return 4
        }
    }

    /// Número de vértices (0 para círculo).
    public var vertices: Int {
        switch self {
        case .circulo: return 0
        case .triangulo: return 3
        case .cuadrado: return 4
        case .rectangulo: return 4
        }
    }

    /// ¿Tiene todos los lados iguales? (a nivel conceptual)
    public var ladosIguales: Bool {
        switch self {
        case .circulo: return true      // simetría
        case .triangulo: return false   // en general
        case .cuadrado: return true
        case .rectangulo: return false
        }
    }
}
