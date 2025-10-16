//
//  CombinatoriaYProbabilidad.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum CombiProb {
    public enum Error: Swift.Error { case argumentosInvalidos }

    /// Factorial hasta 20 con UInt64 (más allá puede desbordar).
    public static func factorial(_ n: Int) throws -> UInt64 {
        guard n >= 0 && n <= 20 else { throw Error.argumentosInvalidos }
        if n <= 1 { return 1 }
        return (2...n).reduce(1) { UInt64($0) * UInt64($1) }
    }

    /// Permutaciones nPr = n! / (n-r)!
    public static func nPr(_ n: Int, _ r: Int) throws -> UInt64 {
        guard 0 <= r && r <= n && n <= 20 else { throw Error.argumentosInvalidos }
        if r == 0 { return 1 }
        var acc: UInt64 = 1
        for k in (n-r+1)...n { acc = acc &* UInt64(k) }
        return acc
    }

    /// Combinaciones nCr evitando overflow (producto/razón).
    public static func nCr(_ n: Int, _ r: Int) throws -> UInt64 {
        guard 0 <= r && r <= n && n <= 66 else { throw Error.argumentosInvalidos }
        // Para n<=66 el valor cabe en UInt64 (C(66,33) ~ 7.2e19 < 2^64)
        let r2 = min(r, n - r)
        if r2 == 0 { return 1 }
        var num: UInt64 = 1
        var den: UInt64 = 1
        for k in 1...r2 {
            num = num &* UInt64(n - r2 + k)
            den = den &* UInt64(k)
            let g = gcd(num, den)
            num /= g; den /= g
        }
        return num / den
    }

    /// Regla de la suma para eventos excluyentes.
    public static func suma(_ pA: Double, _ pB: Double) -> Double { clamp01(pA + pB) }

    /// Regla del producto para independencia.
    public static func productoInd(_ pA: Double, _ pB: Double) -> Double { clamp01(pA * pB) }

    /// Complemento P(Ā) = 1 - P(A)
    public static func complemento(_ pA: Double) -> Double { clamp01(1 - pA) }

    /// Probabilidad binomial: P(X=k) para n ensayos con éxito p.
    public static func binomialPMF(n: Int, k: Int, p: Double) throws -> Double {
        guard 0 <= k && k <= n && p >= 0 && p <= 1 else { throw Error.argumentosInvalidos }
        let c = try Double(nCr(n, k))
        return c * pow(p, Double(k)) * pow(1 - p, Double(n - k))
    }

    // MARK: - helpers
    private static func gcd(_ a: UInt64, _ b: UInt64) -> UInt64 {
        var x=a, y=b
        while y != 0 { (x, y) = (y, x % y) }
        return x
    }
    private static func clamp01(_ x: Double) -> Double { max(0.0, min(1.0, x)) }
}
