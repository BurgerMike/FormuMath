//
//  Log.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum LogExp {
    public enum Error: Swift.Error { case baseInvalida, argumentoNoPositivo }

    /// log_b(x) usando cambio de base.
    public static func log(base b: Double, de x: Double) throws -> Double {
        guard b > 0 && b != 1 else { throw Error.baseInvalida }
        guard x > 0 else { throw Error.argumentoNoPositivo }
        return Foundation.log(x) / Foundation.log(b)
    }

    /// Propiedades útiles: log_b(xy) = log_b x + log_b y
    public static func logProducto(base b: Double, x: Double, y: Double) throws -> Double {
        try log(base: b, de: x) + log(base: b, de: y)
    }

    /// log_b(x^k) = k * log_b x
    public static func logPotencia(base b: Double, x: Double, k: Double) throws -> Double {
        try k * log(base: b, de: x)
    }

    /// Resuelve a^x = y → x = log_a(y)
    public static func resolverExponencial(a: Double, y: Double) throws -> Double {
        try log(base: a, de: y)
    }

    /// Interés compuesto: A = P(1 + r)^n
    public static func interesCompuesto(P: Double, r: Double, n: Double) -> Double {
        P * pow(1 + r, n)
    }

    /// Crecimiento/decaimiento continuo: A = A0 * e^(k t)
    public static func crecimientoContinuo(A0: Double, k: Double, t: Double) -> Double {
        A0 * exp(k * t)
    }

    /// Doble del tiempo (regla del 70 aproximada): t ≈ 70 / (100 r%) = 0.7 / r
    public static func tiempoDuplicacionAprox(r: Double) -> Double {
        // r en fracción (e.g., 0.05)
        0.7 / r
    }
}
