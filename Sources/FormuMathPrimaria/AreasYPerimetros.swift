//
//  AreasYPerimetros.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum AreasYPerimetros {
    public static func perimetroRectangulo(base: Double, altura: Double) -> Double { 2*(base+altura) }
    public static func areaRectangulo(base: Double, altura: Double) -> Double { base*altura }

    public static func perimetroCuadrado(lado: Double) -> Double { 4*lado }
    public static func areaCuadrado(lado: Double) -> Double { lado*lado }

    public static func perimetroTriangulo(a: Double, b: Double, c: Double) -> Double { a+b+c }
    public static func areaTriangulo(base: Double, altura: Double) -> Double { 0.5*base*altura }

    public static func circunferencia(radio: Double) -> Double { 2*Double.pi*radio }
    public static func areaCirculo(radio: Double) -> Double { Double.pi*radio*radio }
}
