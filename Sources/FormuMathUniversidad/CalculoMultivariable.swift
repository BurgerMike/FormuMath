//
//  CalculoMultivariable.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum MultiCalc {
    /// Gradiente numérico (diferencias centradas)
    public static func gradiente(_ f: @escaping ([Double])->Double, en x: [Double], h: Double = 1e-5) -> [Double] {
        var g = [Double](repeating: 0, count: x.count)
        for i in 0..<x.count {
            var xp = x, xm = x
            xp[i] += h; xm[i] -= h
            g[i] = (f(xp) - f(xm)) / (2*h)
        }
        return g
    }

    /// Jacobiano numérico para f: R^n -> R^m
    public static func jacobiano(_ f: @escaping ([Double])->[Double], en x: [Double], h: Double = 1e-5) -> [[Double]] {
        let m = f(x).count, n = x.count
        var J = Array(repeating: Array(repeating: 0.0, count: n), count: m)
        for i in 0..<n {
            var xp = x, xm = x
            xp[i] += h; xm[i] -= h
            let fp = f(xp), fm = f(xm)
            for r in 0..<m { J[r][i] = (fp[r] - fm[r]) / (2*h) }
        }
        return J
    }

    /// Hessiano numérico (matriz de segundas derivadas) de f: R^n->R
    public static func hessiano(_ f: @escaping ([Double])->Double, en x: [Double], h: Double = 1e-4) -> [[Double]] {
        let n = x.count
        var H = Array(repeating: Array(repeating: 0.0, count: n), count: n)
        // diagonal
        for i in 0..<n {
            var xp = x, xm = x
            xp[i] += h; xm[i] -= h
            let fpp = f(xp), fmm = f(xm), f0 = f(x)
            H[i][i] = (fpp - 2*f0 + fmm) / (h*h)
        }
        // fuera de diagonal por fórmula mixta
        for i in 0..<n {
            for j in i+1..<n {
                var xpp = x, xpm = x, xmp = x, xmm = x
                xpp[i]+=h; xpp[j]+=h
                xpm[i]+=h; xpm[j]-=h
                xmp[i]-=h; xmp[j]+=h
                xmm[i]-=h; xmm[j]-=h
                let val = (f(xpp) - f(xpm) - f(xmp) + f(xmm)) / (4*h*h)
                H[i][j] = val; H[j][i] = val
            }
        }
        return H
    }
}
