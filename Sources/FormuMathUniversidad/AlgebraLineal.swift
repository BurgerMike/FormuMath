//
//  Untitled.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Matrices densas pequeñas con utilidades de Universidad: Gauss, LU y potencia.
public struct Matrix {
    public let rows: Int
    public let cols: Int
    public var a: [Double]    // row-major

    public init(_ rows: Int, _ cols: Int, _ a: [Double]) {
        precondition(rows > 0 && cols > 0 && a.count == rows*cols)
        self.rows = rows; self.cols = cols; self.a = a
    }

    @inlinable public subscript(_ r: Int, _ c: Int) -> Double {
        get { a[r*cols + c] }
        set { a[r*cols + c] = newValue }
    }

    public static func identidad(_ n: Int) -> Matrix {
        var m = Matrix(n, n, Array(repeating: 0, count: n*n))
        for i in 0..<n { m[i,i] = 1 }
        return m
    }

    public func fila(_ r: Int) -> [Double] {
        Array(a[(r*cols)..<(r*cols+cols)])
    }

    public func columna(_ c: Int) -> [Double] {
        var v = [Double](repeating: 0, count: rows)
        for r in 0..<rows { v[r] = self[r,c] }
        return v
    }

    // MARK: - Producto
    public static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.cols == rhs.rows)
        var out = Matrix(lhs.rows, rhs.cols, Array(repeating: 0, count: lhs.rows*rhs.cols))
        for i in 0..<lhs.rows {
            for k in 0..<lhs.cols {
                let v = lhs[i,k]
                if v == 0 { continue }
                for j in 0..<rhs.cols { out[i,j] += v * rhs[k,j] }
            }
        }
        return out
    }

    public static func *(lhs: Matrix, rhs: [Double]) -> [Double] {
        precondition(lhs.cols == rhs.count)
        var y = [Double](repeating: 0, count: lhs.rows)
        for i in 0..<lhs.rows {
            var s = 0.0
            for j in 0..<lhs.cols { s += lhs[i,j]*rhs[j] }
            y[i] = s
        }
        return y
    }

    // MARK: - Eliminación Gaussiana con pivoteo parcial (resuelve Ax=b)
    public static func resolver(A: Matrix, b: [Double], tol: Double = 1e-12) -> [Double]? {
        precondition(A.rows == A.cols && b.count == A.rows)
        var M = A
        var rhs = b
        let n = A.rows

        for p in 0..<n {
            // buscar pivote en columna p
            var piv = p
            var maxv = abs(M[p,p])
            for r in (p+1)..<n {
                let v = abs(M[r,p])
                if v > maxv { maxv = v; piv = r }
            }
            if maxv < tol { return nil }

            // intercambiar filas p <-> piv (seguro para exclusividad)
            if piv != p {
                for c in 0..<n {
                    let i1 = p   * M.cols + c
                    let i2 = piv * M.cols + c
                    M.a.swapAt(i1, i2)
                }
                rhs.swapAt(p, piv)
            }

            // normalizar fila p
            let diag = M[p,p]
            for c in p..<n { M[p,c] /= diag }
            rhs[p] /= diag

            // eliminar por debajo
            if p + 1 < n {
                for r in (p+1)..<n {
                    let f = M[r,p]
                    if abs(f) < 1e-18 { continue }
                    for c in p..<n { M[r,c] -= f * M[p,c] }
                    rhs[r] -= f * rhs[p]
                }
            }
        }

        // sustitución hacia atrás
        var x = [Double](repeating: 0, count: n)
        for i in stride(from: n-1, through: 0, by: -1) {
            var s = rhs[i]
            for j in (i+1)..<n { s -= M[i,j] * x[j] }
            x[i] = s
        }
        return x
    }


    // MARK: - Descomposición LU (Doolittle, sin pivoteo)
    public static func LU(_ A: Matrix) -> (L: Matrix, U: Matrix)? {
        precondition(A.rows == A.cols)
        let n = A.rows
        var L = Matrix.identidad(n)
        var U = Matrix(n, n, Array(repeating: 0, count: n*n))
        for i in 0..<n {
            // U
            for k in i..<n {
                var s = 0.0
                for j in 0..<i { s += L[i,j]*U[j,k] }
                U[i,k] = A[i,k] - s
            }
            // L
            for k in i+1..<n {
                var s = 0.0
                for j in 0..<i { s += L[k,j]*U[j,i] }
                let piv = U[i,i]
                if abs(piv) < 1e-12 { return nil }
                L[k,i] = (A[k,i] - s)/piv
            }
        }
        return (L,U)
    }

    // MARK: - Autovalor dominante por iteración de potencia
    public static func autovalorDominante(_ A: Matrix, iters: Int = 100, tol: Double = 1e-10) -> (valor: Double, vector: [Double])? {
        precondition(A.rows == A.cols)
        let n = A.rows
        var x = (0..<n).map { _ in 1.0 } // inicial
        var λprev = 0.0
        for _ in 0..<iters {
            let y = A * x
            let norm = sqrt(y.reduce(0.0, { $0 + $1*$1 }))
            if norm < tol { return nil }
            let xnew = y.map { $0 / norm }
            // Rayleigh quotient
            let λ = dot(xnew, A * xnew) / dot(xnew, xnew)
            if abs(λ - λprev) < tol { return (λ, xnew) }
            x = xnew; λprev = λ
        }
        return (λprev, x)
    }

    @inline(__always) private static func dot(_ u: [Double], _ v: [Double]) -> Double {
        var s = 0.0
        for i in 0..<u.count { s += u[i]*v[i] }
        return s
    }
}
