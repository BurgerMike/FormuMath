//
//  EstadisticasDescriptivaSecundaria.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum EstadisticaDescriptivaSecundaria {
    public static func media(_ xs: [Double]) -> Double {
        xs.isEmpty ? .nan : xs.reduce(0,+)/Double(xs.count)
    }
    public static func varianza(_ xs: [Double]) -> Double {
        let n = xs.count; if n < 2 { return .nan }
        let m = media(xs)
        return xs.reduce(0){$0 + ( $1 - m )*( $1 - m )}/Double(n-1)
    }
    public static func desviacion(_ xs: [Double]) -> Double { sqrt(varianza(xs)) }

    public static func histograma(_ xs: [Double], bins: Int) -> [(rango: ClosedRange<Double>, conteo: Int)] {
        guard let mn = xs.min(), let mx = xs.max(), bins > 0 else { return [] }
        let w = (mx - mn) / Double(bins)
        if w == 0 { return [(mn...mx, xs.count)] }
        var res: [(ClosedRange<Double>, Int)] = []
        for i in 0..<bins {
            let a = mn + Double(i)*w
            let b = (i == bins-1) ? mx : (a + w)
            let c = xs.filter { $0 >= a && (i == bins-1 ? $0 <= b : $0 < b) }.count
            res.append((a...b, c))
        }
        return res
    }
}
