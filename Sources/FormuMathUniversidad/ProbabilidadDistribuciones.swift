//
//  ProbabilidadDistribuciones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Distrib {
    // Normal --------------------------------------------------
    public static func normalPDF(x: Double, mu: Double = 0, sigma: Double = 1) -> Double {
        precondition(sigma > 0)
        let z = (x - mu)/sigma
        return exp(-0.5*z*z) / (sigma * sqrt(2*Double.pi))
    }

    /// CDF Normal estándar por aproximación de erf (Abramowitz-Stegun 7.1.26)
    public static func normalCDF(x: Double, mu: Double = 0, sigma: Double = 1) -> Double {
        precondition(sigma > 0)
        let z = (x - mu)/(sigma*sqrt(2.0))
        // erf aprox
        let t = 1.0/(1.0 + 0.3275911*abs(z))
        let a1 = 0.254829592, a2 = -0.284496736, a3 = 1.421413741, a4 = -1.453152027, a5 = 1.061405429
        let poly = (((a5*t + a4)*t + a3)*t + a2)*t + a1
        let erf = 1.0 - poly*exp(-z*z)
        let sign = z >= 0 ? 1.0 : -1.0
        let Φ = 0.5*(1.0 + sign*erf)
        return Φ
    }

    // Exponencial --------------------------------------------
    public static func exponencialPDF(x: Double, lambda: Double) -> Double {
        precondition(lambda > 0)
        return x < 0 ? 0 : lambda * exp(-lambda*x)
    }
    public static func exponencialCDF(x: Double, lambda: Double) -> Double {
        precondition(lambda > 0)
        return x < 0 ? 0 : 1 - exp(-lambda*x)
    }

    // Poisson -------------------------------------------------
    public static func poissonPMF(k: Int, lambda: Double) -> Double {
        precondition(k >= 0 && lambda >= 0)
        if lambda == 0 { return k == 0 ? 1 : 0 }
        // e^{-λ} λ^k / k!
        var term = exp(-lambda)
        term *= pow(lambda, Double(k))
        term /= tgamma(Double(k+1)) // Γ(k+1)=k!
        return term
    }

    // Binomial -----------------------------------------------
    public static func binomialPMF(n: Int, k: Int, p: Double) -> Double {
        precondition(n >= 0 && k >= 0 && k <= n && p >= 0 && p <= 1)
        // nCk p^k (1-p)^(n-k)
        let c = comb(n, k)
        return c * pow(p, Double(k)) * pow(1-p, Double(n-k))
    }

    // helpers
    private static func comb(_ n: Int, _ r: Int) -> Double {
        if r < 0 || r > n { return 0 }
        let r2 = min(r, n-r)
        if r2 == 0 { return 1 }
        var num = 1.0, den = 1.0
        for k in 1...r2 {
            num *= Double(n - r2 + k)
            den *= Double(k)
        }
        return num / den
    }
}
