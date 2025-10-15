//
//  MatematicaStatica.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//

import Foundation

/// Basic statistics / Estadística básica
public enum Statistics {
    public static func mean(_ arr: [Double]) -> Double {
        guard !arr.isEmpty else { return 0 }
        return arr.reduce(0, +) / Double(arr.count)
    }
    public static func media(_ arr: [Double]) -> Double { mean(arr) }

    public static func variance(_ arr: [Double]) -> Double {
        guard !arr.isEmpty else { return 0 }
        let m = mean(arr)
        return arr.reduce(0) { $0 + ( $1 - m )*( $1 - m ) } / Double(arr.count)
    }
    public static func varianza(_ arr: [Double]) -> Double { variance(arr) }

    public static func stddev(_ arr: [Double]) -> Double {
        variance(arr).squareRoot()
    }
    public static func desviacionEstandar(_ arr: [Double]) -> Double { stddev(arr) }
}
