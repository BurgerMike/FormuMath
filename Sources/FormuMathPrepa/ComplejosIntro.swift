//
//  ComplejosIntro.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public struct Cplx: Sendable, Equatable, CustomStringConvertible {
    public var re: Double
    public var im: Double
    public init(_ re: Double, _ im: Double) { self.re = re; self.im = im }
    public var description: String { "(\(re) + \(im)i)" }

    public var modulo: Double { (re*re + im*im).squareRoot() }
    public var argumento: Double { atan2(im, re) }

    public static func + (a: Cplx, b: Cplx) -> Cplx { Cplx(a.re+b.re, a.im+b.im) }
    public static func - (a: Cplx, b: Cplx) -> Cplx { Cplx(a.re-b.re, a.im-b.im) }
    public static func * (a: Cplx, b: Cplx) -> Cplx { Cplx(a.re*b.re - a.im*b.im, a.re*b.im + a.im*b.re) }
    public static func / (a: Cplx, b: Cplx) -> Cplx {
        let d = b.re*b.re + b.im*b.im
        return Cplx((a.re*b.re + a.im*b.im)/d, (a.im*b.re - a.re*b.im)/d)
    }

    public func potencia(_ n: Int) -> Cplx {
        if n == 0 { return Cplx(1,0) }
        var r = self
        for _ in 1..<abs(n) { r = r * self }
        return n > 0 ? r : Cplx(1,0) / r
    }
}
