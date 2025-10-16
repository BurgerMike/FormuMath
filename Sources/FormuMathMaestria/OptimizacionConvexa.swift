//
//  OptimizacionConvexa.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum OptConvexa {
    // ---------- Utilidades comunes ----------
    public static func gradiente(_ f: @escaping ([Double])->Double, en x: [Double], h: Double = 1e-6) -> [Double] {
        var g = [Double](repeating: 0, count: x.count)
        for i in 0..<x.count {
            var xp=x, xm=x; xp[i]+=h; xm[i]-=h
            g[i] = (f(xp)-f(xm))/(2*h)
        }
        return g
    }
    public static func hessiano(_ f: @escaping ([Double])->Double, en x: [Double], h: Double = 1e-4) -> [[Double]] {
        let n = x.count
        var H = Array(repeating: Array(repeating: 0.0, count: n), count: n)
        let f0 = f(x)
        for i in 0..<n {
            var xp=x, xm=x; xp[i]+=h; xm[i]-=h
            H[i][i] = (f(xp)-2*f0+f(xm))/(h*h)
            for j in i+1..<n {
                var xpp=x, xpm=x, xmp=x, xmm=x
                xpp[i]+=h; xpp[j]+=h
                xpm[i]+=h; xpm[j]-=h
                xmp[i]-=h; xmp[j]+=h
                xmm[i]-=h; xmm[j]-=h
                let v = (f(xpp) - f(xpm) - f(xmp) + f(xmm))/(4*h*h)
                H[i][j]=v; H[j][i]=v
            }
        }
        return H
    }
    private static func dot(_ a:[Double], _ b:[Double]) -> Double { zip(a,b).reduce(0){$0+$1.0*$1.1} }
    private static func add(_ a:[Double], _ b:[Double], s: Double = 1.0) -> [Double] { zip(a,b).map{$0 + s*$1} }
    private static func scal(_ a:[Double], _ s: Double) -> [Double] { a.map{ $0*s } }

    // ---------- Descenso de gradiente con Armijo ----------
    public static func descensoGradiente(_ f: @escaping ([Double])->Double,
                                         x0: [Double],
                                         maxIter: Int = 500,
                                         tol: Double = 1e-6) -> [Double] {
        var x = x0
        for _ in 0..<maxIter {
            let g = gradiente(f, en: x)
            let ng = sqrt(dot(g,g))
            if ng < tol { break }
            // Armijo backtracking
            let fx = f(x)
            var alpha = 1.0
            let c = 1e-4
            while f(add(x, scal(g, -alpha))) > fx - c*alpha*ng*ng { alpha *= 0.5; if alpha < 1e-12 { break } }
            x = add(x, scal(g, -alpha))
        }
        return x
    }

    // ---------- Newton (no lineal) con backtracking ----------
    public static func newton(_ f: @escaping ([Double])->Double,
                              x0: [Double],
                              maxIter: Int = 100,
                              tol: Double = 1e-8) -> [Double] {
        var x = x0
        for _ in 0..<maxIter {
            let g = gradiente(f, en: x)
            if sqrt(dot(g,g)) < tol { break }
            let H = hessiano(f, en: x)
            guard let p = solve(H, scal(g, -1)) else { break } // H p = -g
            // backtracking
            var alpha = 1.0; let fx = f(x); let c = 1e-4
            while f(add(x, scal(p, alpha))) > fx + c*alpha*dot(g,p) { alpha *= 0.5; if alpha < 1e-12 { break } }
            x = add(x, scal(p, alpha))
        }
        return x
    }

    // ---------- L-BFGS (muy simple, historial m) ----------
    public static func lbfgs(_ f: @escaping ([Double])->Double,
                             x0: [Double], m: Int = 5,
                             maxIter: Int = 300, tol: Double = 1e-6) -> [Double] {
        var x = x0
        var sList: [[Double]] = [], yList: [[Double]] = [], rho: [Double] = []
        func twoLoop(_ g: [Double]) -> [Double] {
            var q = g
            var a = [Double](repeating: 0, count: sList.count)
            for i in stride(from: sList.count-1, through: 0, by: -1) {
                a[i] = rho[i]*dot(sList[i], q)
                q = add(q, scal(yList[i], -a[i]))
            }
            // H0 = (sᵗy / yᵗy) I
            var gamma = 1.0
            if let s = sList.last, let y = yList.last {
                let sy = dot(s,y), yy = dot(y,y)
                if yy > 1e-18 { gamma = sy/yy }
            }
            var z = scal(q, gamma)
            for i in 0..<sList.count {
                let b = rho[i]*dot(yList[i], z)
                z = add(z, scal(sList[i], a[i]-b))
            }
            return scal(z, -1) // dirección descendente
        }
        for _ in 0..<maxIter {
            let g = gradiente(f, en: x)
            if sqrt(dot(g,g)) < tol { break }
            var p = twoLoop(g)
            // Armijo
            let fx = f(x); var alpha = 1.0; let c = 1e-4
            while f(add(x, scal(p, alpha))) > fx + c*alpha*dot(g,p) {
                alpha *= 0.5; if alpha < 1e-12 { break }
            }
            let xNew = add(x, scal(p, alpha))
            let s = add(xNew, x, s: -1), y = add(gradiente(f, en: xNew), g, s: -1)
            let sy = dot(s,y)
            if sy > 1e-18 {
                sList.append(s); yList.append(y); rho.append(1.0/sy)
                if sList.count > m { sList.removeFirst(); yList.removeFirst(); rho.removeFirst() }
            }
            x = xNew
        }
        return x
    }

    // ---------- Condiciones KKT para igualdad Ax=b ----------
    /// Devuelve (x, λ) que resuelven min f(x) s.a. A x = b  por Newton-KKT (lagrangiano L=f+λᵀ(Ax-b))
    public static func newtonIgualdades(_ f: @escaping ([Double])->Double,
                                        A: [[Double]], b: [Double],
                                        x0: [Double], lambda0: [Double],
                                        maxIter: Int = 80, tol: Double = 1e-7) -> (x:[Double], lambda:[Double]) {
        var x = x0, λ = lambda0
        let m = A.count, n = x0.count
        func Ax(_ x:[Double]) -> [Double] { A.map{ row in dot(row, x) } }
        func AT(_ v:[Double]) -> [Double] {
            var r = [Double](repeating: 0, count: n)
            for i in 0..<m { for j in 0..<n { r[j] += A[i][j]*v[i] } }
            return r
        }
        for _ in 0..<maxIter {
            let g = gradiente(f, en: x) // ∇f
            let H = hessiano(f, en: x)  // ∇²f
            // KKT:
            // [ H  Aᵀ ] [dx] = -[ ∇f + Aᵀλ ]
            // [ A   0 ] [dλ]    [  Ax - b  ]
            let k = n + m
            var K = Array(repeating: Array(repeating: 0.0, count: k), count: k)
            // H y Aᵀ
            for i in 0..<n { for j in 0..<n { K[i][j] = H[i][j] } }
            for i in 0..<n { for j in 0..<m { K[i][n+j] = A[j][i] } }
            // A y 0
            for i in 0..<m { for j in 0..<n { K[n+i][j] = A[i][j] } }
            var rhs = [Double](repeating: 0, count: k)
            let r1 = add(g, AT(λ))
            let r2 = add(Ax(x), b, s: -1)
            for i in 0..<n { rhs[i] = -r1[i] }
            for i in 0..<m { rhs[n+i] = -r2[i] }
            guard let sol = solve(K, rhs) else { break }
            let dx = Array(sol[0..<n]), dλ = Array(sol[n..<k])
            if sqrt(dot(dx,dx)) < tol && sqrt(dot(dλ,dλ)) < tol { break }
            // backtracking factible para igualdades (no hay desigualdades aquí)
            var alpha = 1.0; let fx = f(x); let gL = add(g, AT(λ)) // ∇x L
            while f(add(x, scal(dx, alpha))) > fx + 1e-4*alpha*dot(gL, dx) { alpha *= 0.5; if alpha < 1e-12 { break } }
            x = add(x, scal(dx, alpha))
            λ = add(λ, scal(dλ, alpha))
        }
        return (x, λ)
    }

    // ---------- Solver lineal sencillo (Gauss) ----------
    public static func solve(_ A: [[Double]], _ b: [Double], tol: Double = 1e-12) -> [Double]? {
        let n = A.count; var M = A; var rhs = b
        for p in 0..<n {
            var piv = p; var maxv = abs(M[p][p])
            for r in (p+1)..<n { if abs(M[r][p]) > maxv { maxv = abs(M[r][p]); piv = r } }
            if maxv < tol { return nil }
            if piv != p { M.swapAt(p, piv); rhs.swapAt(p, piv) }
            let d = M[p][p]
            for c in p..<n { M[p][c] /= d }; rhs[p] /= d
            if p+1<n {
                for r in (p+1)..<n {
                    let f = M[r][p]; if abs(f) < 1e-18 { continue }
                    for c in p..<n { M[r][c] -= f*M[p][c] }
                    rhs[r] -= f*rhs[p]
                }
            }
        }
        var x = [Double](repeating: 0, count: n)
        for i in stride(from: n-1, through: 0, by: -1) {
            var s = rhs[i]; for j in (i+1)..<n { s -= M[i][j]*x[j] }; x[i] = s
        }
        return x
    }
}
