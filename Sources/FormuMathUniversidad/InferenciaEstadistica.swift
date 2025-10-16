//
//  InferenciaEstadistica.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Inferencia {
    // Estadísticos básicos
    public static func media(_ xs: [Double]) -> Double {
        guard !xs.isEmpty else { return .nan }
        return xs.reduce(0,+)/Double(xs.count)
    }
    public static func varianzaMuestral(_ xs: [Double]) -> Double {
        let n = xs.count
        guard n >= 2 else { return .nan }
        let m = media(xs)
        let s2 = xs.reduce(0) { $0 + ( $1 - m )*( $1 - m ) } / Double(n-1)
        return s2
    }
    public static func desviacionMuestral(_ xs: [Double]) -> Double {
        sqrt(varianzaMuestral(xs))
    }

    // Intervalo de confianza para la media con σ conocida (z)
    public static func IC_media_sigmaConocida(mediaMuestral: Double, sigma: Double, n: Int, zCritico: Double)
        -> (li: Double, ls: Double) {
        precondition(sigma > 0 && n > 0 && zCritico > 0)
        let e = zCritico * sigma / sqrt(Double(n))
        return (mediaMuestral - e, mediaMuestral + e)
    }

    // Intervalo de confianza para la media con σ desconocida (t ~ aprox. usando zCritico si no hay t)
    public static func IC_media_sigmaDesconocida(xs: [Double], zCriticoAprox: Double) -> (li: Double, ls: Double) {
        let n = xs.count
        precondition(n >= 2 && zCriticoAprox > 0)
        let m = media(xs)
        let s = desviacionMuestral(xs)
        let e = zCriticoAprox * s / sqrt(Double(n))
        return (m - e, m + e)
    }

    // Prueba z unamuestral para la media (σ conocida). H0: μ = μ0 → Z = (x̄ - μ0) / (σ/√n)
    public static func zTestUnaMuestra(mediaMuestral: Double, mu0: Double, sigma: Double, n: Int) -> Double {
        (mediaMuestral - mu0) / (sigma / sqrt(Double(n)))
    }

    // Prueba t unamuestral (σ desconocida): T = (x̄ - μ0) / (s/√n)
    public static func tTestUnaMuestra(xs: [Double], mu0: Double) -> Double {
        let n = xs.count
        let m = media(xs)
        let s = desviacionMuestral(xs)
        return (m - mu0) / (s / sqrt(Double(n)))
    }
}
