//
//  DecimalesYRedondeo.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum DecimalesYRedondeo {
    public enum Modo { case cercano, arriba, abajo, truncar }

    /// Redondea x a 'decimales' usando el 'modo' indicado.
    public static func redondear(_ x: Double, decimales: Int, modo: Modo = .cercano) -> Double {
        precondition(decimales >= 0)
        let f = pow(10.0, Double(decimales))
        let xf = x * f
        let y: Double
        switch modo {
        case .cercano: y = xf.rounded()
        case .arriba:  y = ceil(xf)
        case .abajo:   y = floor(xf)
        case .truncar: y = xf >= 0 ? floor(xf) : ceil(xf)
        }
        return y / f
    }

    /// Representa con separadores y número fijo de decimales (p. ej. para dinero).
    public static func formatear(_ x: Double, decimales: Int = 2, separadorMiles: String = ",", separadorDecimal: String = ".") -> String {
        let valor = redondear(x, decimales: decimales, modo: .cercano)
        let partes = String(format: "%.\(decimales)f", valor).split(separator: ".").map(String.init)
        var ent = partes[0], dec = partes.count > 1 ? partes[1] : ""
        // miles
        var conMiles = ""
        var cuenta = 0
        for ch in ent.reversed() {
            if cuenta == 3 { conMiles.append(contentsOf: separadorMiles); cuenta = 0 }
            conMiles.append(ch); cuenta += 1
        }
        ent = String(conMiles.reversed())
        return decimales > 0 ? "\(ent)\(separadorDecimal)\(dec)" : ent
    }
}
