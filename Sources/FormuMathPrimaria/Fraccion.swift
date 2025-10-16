//
//  Fracciones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public struct Fraccion: Equatable, CustomStringConvertible {
    public var n: Int
    public var d: Int

    public init(_ n: Int, _ d: Int) {
        precondition(d != 0, "El denominador no puede ser 0")
        let s = d < 0 ? -1 : 1
        self.n = n * s
        self.d = abs(d)
        self = Fraccion.normalizada(self)
    }

    // init interno sin normalizar
    private init(_ n: Int, _ d: Int, unsafe: Bool) {
        self.n = n; self.d = d
    }

    public var description: String { "\(n)/\(d)" }

    // MCD/MCM
    public static func mcd(_ a: Int, _ b: Int) -> Int {
        var x = abs(a), y = abs(b)
        while y != 0 { (x, y) = (y, x % y) }
        return x
    }
    public static func mcm(_ a: Int, _ b: Int) -> Int {
        let g = mcd(a, b)
        return (abs(a / g) * abs(b))
    }

    public static func normalizada(_ f: Fraccion) -> Fraccion {
        let g = mcd(f.n, f.d)
        return Fraccion(f.n / g, f.d / g, unsafe: true)
    }

    public func aDecimal() -> Double { Double(n) / Double(d) }

    // Operaciones
    public static func + (lhs: Fraccion, rhs: Fraccion) -> Fraccion {
        Fraccion(lhs.n*rhs.d + rhs.n*lhs.d, lhs.d*rhs.d)
    }
    public static func - (lhs: Fraccion, rhs: Fraccion) -> Fraccion {
        Fraccion(lhs.n*rhs.d - rhs.n*lhs.d, lhs.d*rhs.d)
    }
    public static func * (lhs: Fraccion, rhs: Fraccion) -> Fraccion {
        Fraccion(lhs.n*rhs.n, lhs.d*rhs.d)
    }
    public static func / (lhs: Fraccion, rhs: Fraccion) -> Fraccion {
        precondition(rhs.n != 0, "División entre 0")
        return Fraccion(lhs.n*rhs.d, lhs.d*rhs.n)
    }

    // Comparaciones
    public static func == (l: Fraccion, r: Fraccion) -> Bool {
        let ln = Fraccion.normalizada(l), rn = Fraccion.normalizada(r)
        return ln.n == rn.n && ln.d == rn.d
    }

    // Conversión decimal ↔ fracción (aprox. simple)
    public static func desdeDecimal(_ x: Double, maxDen: Int = 10_000) -> Fraccion {
        // Búsqueda de mejor aproximación por cota de denominador
        var mejor = Fraccion(Int(round(x)), 1)
        var mejorErr = abs(mejor.aDecimal() - x)
        for d in 1...maxDen {
            let n = Int(round(x * Double(d)))
            let f = Fraccion(n, d)
            let err = abs(f.aDecimal() - x)
            if err < mejorErr { mejor = f; mejorErr = err }
            if mejorErr < 1e-12 { break }
        }
        return mejor
    }

    // Mezclas (a b/c) -> fracción impropia y viceversa
    public static func mixtaEntero(_ a: Int, _ b: Int, _ c: Int) -> Fraccion {
        precondition(c > 0, "c>0")
        let s = a >= 0 ? 1 : -1
        let n = a * c + s * b
        return Fraccion(n, c)
    }

    public func aMixta() -> (entero: Int, num: Int, den: Int) {
        let entero = n / d
        let resto = abs(n % d)
        return (entero, resto, d)
    }
}
