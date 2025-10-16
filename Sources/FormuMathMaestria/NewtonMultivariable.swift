//
//  NewtonMultivariable.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum NewtonMultivariable {
    /// Resuelve F(x)=0 (x∈R^n) con Newton + línea de búsqueda (Armijo). Jacobiano numérico si no se provee.
    public static func resolver(F: @escaping ([Double])->[Double],
                                x0: [Double],
                                J: (([Double])->[[Double]])? = nil,
                                maxIter: Int = 50,
                                tol: Double = 1e-8) -> [Double]? {
        var x = x0
        func jac(_ x:[Double]) -> [[Double]] {
            if let JJ = J { return JJ(x) }
            let n = x.count, m = F(x).count
            var JN = Array(repeating: Array(repeating: 0.0, count: n), count: m)
            let h = 1e-6
            for i in 0..<n {
                var xp=x, xm=x; xp[i]+=h; xm[i]-=h
                let fp = F(xp), fm = F(xm)
                for r in 0..<m { JN[r][i] = (fp[r]-fm[r])/(2*h) }
            }
            return JN
        }
        for _ in 0..<maxIter {
            let Fx = F(x)
            let norm = sqrt(Fx.reduce(0){$0+$1*$1})
            if norm < tol { return x }
            let Jx = jac(x)
            guard let p = solve(Jx, Fx.map{ -$0 }) else { return nil }
            // Armijo en φ(α)=||F(x+αp)||^2
            var alpha = 1.0
            let φ0 = norm*norm
            while true {
                let xTrial = zip(x,p).map{ $0 + alpha*$1 }
                let φt = F(xTrial).reduce(0){$0+$1*$1}
                if φt <= (1 - 1e-4*alpha)*φ0 || alpha < 1e-12 { x = xTrial; break }
                alpha *= 0.5
            }
        }
        return nil
    }

    // Gauss simple
    public static func solve(_ A: [[Double]], _ b: [Double], tol: Double = 1e-12) -> [Double]? {
        let n = A.count; var M = A; var rhs = b
        for p in 0..<n {
            var piv = p; var maxv = abs(M[p][p])
            for r in (p+1)..<n { if abs(M[r][p]) > maxv { maxv = abs(M[r][p]); piv = r } }
            if maxv < tol { return nil }
            if piv != p { M.swapAt(p,piv); rhs.swapAt(p,piv) }
            let d = M[p][p]; for c in p..<n { M[p][c] /= d }; rhs[p] /= d
            if p+1<n {
                for r in (p+1)..<n {
                    let f = M[r][p]; if abs(f) < 1e-18 { continue }
                    for c in p..<n { M[r][c] -= f*M[p][c] }
                    rhs[r] -= f*rhs[p]
                }
            }
        }
        var x=[Double](repeating:0,count:n)
        for i in stride(from:n-1, through:0, by:-1){
            var s = rhs[i]; for j in (i+1)..<n { s -= M[i][j]*x[j] }; x[i]=s
        }
        return x
    }
}
