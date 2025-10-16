//
//  EstadisticaBasicaPrimaria.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum EstadisticaBasicaPrimaria {
    public static func media(_ xs: [Double]) -> Double {
        guard !xs.isEmpty else { return .nan }
        return xs.reduce(0,+) / Double(xs.count)
    }
    public static func mediana(_ xs: [Double]) -> Double {
        guard !xs.isEmpty else { return .nan }
        let s = xs.sorted()
        let n = s.count
        if n % 2 == 1 { return s[n/2] }
        return 0.5*(s[n/2 - 1] + s[n/2])
    }
    public static func moda(_ xs: [Double]) -> [Double] {
        guard !xs.isEmpty else { return [] }
        var f: [Double:Int] = [:]
        xs.forEach { f[$0, default: 0] += 1 }
        let m = f.values.max()!
        return f.filter { $0.value == m }.map { $0.key }.sorted()
    }
    public static func rango(_ xs: [Double]) -> Double {
        guard let mn = xs.min(), let mx = xs.max() else { return .nan }
        return mx - mn
    }
}
