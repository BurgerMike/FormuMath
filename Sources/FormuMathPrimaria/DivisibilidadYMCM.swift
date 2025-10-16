//
//  DivisibilidadYMCM.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum DivisibilidadYMCM {
    public static func esDivisible(_ a: Int, por b: Int) -> Bool {
        guard b != 0 else { return false }
        return a % b == 0
    }

    public static func mcd(_ a0: Int, _ b0: Int) -> Int {
        var a = abs(a0), b = abs(b0)
        while b != 0 { (a, b) = (b, a % b) }
        return a
    }

    public static func mcm(_ a: Int, _ b: Int) -> Int {
        let g = mcd(a, b)
        return g == 0 ? 0 : abs(a / g * b)
    }

    /// Reglas simples (10, 5, 4, 3, 2, 9, 11 parcial)
    public static func posibleDivisor(_ n: Int, por d: Int) -> Bool {
        let s = String(abs(n))
        switch d {
        case 2:  return s.last.map({"02468".contains($0)}) ?? false
        case 3:  return sumaDigitos(n) % 3 == 0
        case 4:  return Int(s.suffix(2))! % 4 == 0
        case 5:  return s.last.map({$0 == "0" || $0 == "5"}) ?? false
        case 9:  return sumaDigitos(n) % 9 == 0
        case 10: return s.last == "0"
        case 11:
            var par = 0, impar = 0, i = 0
            for ch in s.reversed() {
                let v = Int(String(ch))!
                if i % 2 == 0 { par += v } else { impar += v }
                i += 1
            }
            return abs(par - impar) % 11 == 0
        default:
            return esDivisible(n, por: d)
        }
    }

    private static func sumaDigitos(_ n: Int) -> Int {
        String(abs(n)).compactMap { Int(String($0)) }.reduce(0,+)
    }
}
