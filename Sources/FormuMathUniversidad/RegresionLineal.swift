//
//  RegresionLineal.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Regresión lineal simple y múltiple pequeña (OLS).
public enum RegresionLineal {
    /// Simple: y ~ β0 + β1 x
    public static func simple(x: [Double], y: [Double]) -> (beta0: Double, beta1: Double, r2: Double) {
        precondition(x.count == y.count && x.count >= 2)
        let n = Double(x.count)
        let sx = x.reduce(0,+), sy = y.reduce(0,+)
        let sxx = zip(x,x).reduce(0) { $0 + $1.0*$1.1 }
        let sxy = zip(x,y).reduce(0) { $0 + $1.0*$1.1 }
        let xbar = sx/n, ybar = sy/n
        let ssxx = sxx - n*xbar*xbar
        let ssxy = sxy - n*xbar*ybar
        let beta1 = ssxy / ssxx
        let beta0 = ybar - beta1*xbar
        // R^2
        let yhat = x.map { beta0 + beta1*$0 }
        let sst = y.reduce(0) { $0 + ($1 - ybar)*($1 - ybar) }
        let sse = zip(y,yhat).reduce(0) { $0 + ($1.0 - $1.1)*($1.0 - $1.1) }
        let r2 = 1.0 - sse/sst
        return (beta0, beta1, r2)
    }

    /// Múltiple pequeña: y ~ Xβ  con X tamaño (n×p) e incluye columna de 1s si quieres intercepto.
    /// Resuelve por ecuaciones normales: β = (XᵀX)^{-1} Xᵀ y (usa Gauss)
    public static func multiple(X: Matrix, y: [Double]) -> [Double]? {
        precondition(X.rows == y.count)
        // Construye XtX y XtY
        let Xt = traspuesta(X)
        let XtX = Xt * X
        let XtY = Xt * y
        return Matrix.resolver(A: XtX, b: XtY)
    }

    public static func traspuesta(_ A: Matrix) -> Matrix {
        var T = Matrix(A.cols, A.rows, Array(repeating: 0, count: A.rows*A.cols))
        for i in 0..<A.rows { for j in 0..<A.cols { T[j,i] = A[i,j] } }
        return T
    }
}
