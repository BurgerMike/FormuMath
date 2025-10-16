//
//  Polinomios.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Polinomios {
    /// Evalúa p(x) por Horner. p está en coeficientes [a0, a1, ..., an] con a0 término constante.
    public static func horner(_ coef: [Double], _ x: Double) -> Double {
        guard var acc = coef.last else { return 0 }
        for c in coef.dropLast().reversed() { acc = acc * x + c }
        return acc
    }

    /// Derivada de un polinomio: d/dx( a0 + a1 x + ... + an x^n ) = a1 + 2 a2 x + ... + n an x^(n-1)
    public static func derivada(_ coef: [Double]) -> [Double] {
        guard coef.count >= 2 else { return [0] }
        return (1..<coef.count).map { Double($0) * coef[$0] }
    }

    /// Suma de polinomios (alineando grados).
    public static func suma(_ p: [Double], _ q: [Double]) -> [Double] {
        let n = max(p.count, q.count)
        var r = Array(repeating: 0.0, count: n)
        for i in 0..<n {
            let a = i < p.count ? p[i] : 0
            let b = i < q.count ? q[i] : 0
            r[i] = a + b
        }
        return normalizar(r)
    }

    /// Multiplicación naive O(nm)
    public static func multiplicar(_ p: [Double], _ q: [Double]) -> [Double] {
        var r = Array(repeating: 0.0, count: p.count + q.count - 1)
        for i in 0..<p.count {
            for j in 0..<q.count {
                r[i+j] += p[i] * q[j]
            }
        }
        return normalizar(r)
    }

    /// Raíces racionales candidatas usando el teorema de la raíz racional (coef enteros).
    public static func raicesRacionalesCandidatas(_ coefEnteros: [Int]) -> [Double] {
        guard let a0 = coefEnteros.first, let an = coefEnteros.last, an != 0 else { return [] }
        func divisores(_ x: Int) -> Set<Int> {
            let ax = abs(x)
            var s = Set<Int>()
            for d in 1...Int(Double(ax).squareRoot()) where ax % d == 0 {
                s.insert(d); s.insert(ax/d)
            }
            return s
        }
        let P = divisores(a0)
        let Q = divisores(an)
        var candidatos = Set<Double>()
        for p in P {
            for q in Q where q != 0 {
                candidatos.insert(Double(p)/Double(q))
                candidatos.insert(-Double(p)/Double(q))
            }
        }
        return Array(candidatos).sorted()
    }

    /// Intento de factorizar por raíces racionales simples (devuelve factores lineales encontrados).
    public static func factorizarLinealPorRaicesRacionales(_ coefEnteros: [Int]) -> (raices: [Double], resto: [Double]) {
        var p = coefEnteros.map(Double.init)
        var raices: [Double] = []
        for r in raicesRacionalesCandidatas(coefEnteros) {
            // división sintética
            while dividirPorLineal(&p, r) {
                raices.append(r)
            }
        }
        return (raices, normalizar(p))
    }

    // MARK: - helpers
    private static func dividirPorLineal(_ p: inout [Double], _ r: Double) -> Bool {
        // intenta dividir p(x) entre (x - r). Si el residuo ~ 0, reduce grado.
        let n = p.count - 1
        if n <= 0 { return false }
        var b = Array(repeating: 0.0, count: n)
        b[n-1] = p[n]
        for i in stride(from: n-2, through: 0, by: -1) {
            b[i] = p[i+1] + r * b[i+1]
        }
        let residuo = p[0] + r * b[0]
        if abs(residuo) < 1e-10 {
            p = b
            return true
        }
        return false
    }

    private static func normalizar(_ c: [Double]) -> [Double] {
        var r = c
        while r.count > 1 && abs(r.last!) < 1e-12 { r.removeLast() }
        return r
    }
}
