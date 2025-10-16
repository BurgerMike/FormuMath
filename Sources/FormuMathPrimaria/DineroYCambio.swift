//
//  DineroYCambio.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Operaciones con dinero usando centavos para evitar errores de punto flotante.
/// Por defecto asume MXN, pero el símbolo es configurable.
public struct Dinero: Equatable, Comparable, CustomStringConvertible {
    public let centavos: Int
    public let simbolo: String

    public init(pesos: Int, centavos: Int = 0, simbolo: String = "$") {
        precondition(centavos >= 0 && centavos < 100, "0<=centavos<100")
        let signo = (pesos < 0 || centavos < 0) ? -1 : 1
        self.centavos = signo * (abs(pesos) * 100 + abs(centavos))
        self.simbolo = simbolo
    }

    public init(desdeDouble valor: Double, simbolo: String = "$") {
        // redondeo a 2 decimales
        let c = Int((valor * 100.0).rounded())
        self.centavos = c
        self.simbolo = simbolo
    }

    public var pesosEnteros: Int { centavos / 100 }
    public var restoCentavos: Int { abs(centavos % 100) }

    public var description: String {
        let sign = centavos < 0 ? "-" : ""
        return "\(sign)\(simbolo)\(abs(pesosEnteros))." + String(format: "%02d", restoCentavos)
    }

    // MARK: - Aritmética
    public static func + (l: Dinero, r: Dinero) -> Dinero {
        precondition(l.simbolo == r.simbolo, "mismo símbolo")
        return Dinero(desdeDouble: Double(l.centavos + r.centavos)/100.0, simbolo: l.simbolo)
    }
    public static func - (l: Dinero, r: Dinero) -> Dinero {
        precondition(l.simbolo == r.simbolo, "mismo símbolo")
        return Dinero(desdeDouble: Double(l.centavos - r.centavos)/100.0, simbolo: l.simbolo)
    }
    public static func * (l: Dinero, r: Int) -> Dinero {
        Dinero(desdeDouble: Double(l.centavos * r)/100.0, simbolo: l.simbolo)
    }
    public static func < (l: Dinero, r: Dinero) -> Bool {
        precondition(l.simbolo == r.simbolo, "mismo símbolo")
        return l.centavos < r.centavos
    }

    // MARK: - IVA / descuentos / propinas
    /// Aplica un porcentaje (positivo o negativo). Ej: 16% IVA -> +16; descuento 20% -> -20
    public func aplicar(porcentaje p: Double) -> Dinero {
        let factor = 1.0 + p/100.0
        let nuevo = Double(centavos) * factor / 100.0
        return Dinero(desdeDouble: nuevo.rounded(toCents: 2), simbolo: simbolo)
    }

    // MARK: - Desglose de cambio en billetes/monedas (MXN por defecto)
    /// Devuelve desglose mínimo por voracidad (greedy) con denominaciones comunes de MXN.
    public func desgloseCambioMXN() -> [(denominacion: Dinero, cantidad: Int)] {
        var resto = abs(centavos)
        let sim = simbolo
        // Billetes y monedas de uso común (puedes ajustar el set si quieres otro país)
        let denoms = [
            10000, 5000, 2000, 1000, 500, 200, // 100, 50, 20, 10, 5, 2 pesos
            100, 50, 20, // monedas grandes
            10, 5, 2, 1  // centavos
        ]
        var out: [(Dinero, Int)] = []
        for c in denoms {
            let q = resto / c
            if q > 0 {
                out.append((Dinero(desdeDouble: Double(c)/100.0, simbolo: sim), q))
                resto -= q * c
            }
            if resto == 0 { break }
        }
        if out.isEmpty { out.append((Dinero(desdeDouble: 0.0, simbolo: sim), 0)) }
        return out
    }
}

// MARK: - Helpers
fileprivate extension Double {
    /// Redondea a n decimales y devuelve Double (útil para porcentajes antes de convertir a centavos).
    func rounded(toCents n: Int) -> Double {
        let f = pow(10.0, Double(n))
        return (self * f).rounded()/f
    }
}
