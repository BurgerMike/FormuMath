//
//  Untitled.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum VolumenesYAreasSuperficiales {
    // Prismas y pirámides (base * altura / 3 para pirámides)
    public static func volumenPrisma(areaBase: Double, altura: Double) -> Double { areaBase * altura }
    public static func volumenPiramide(areaBase: Double, altura: Double) -> Double { areaBase * altura / 3.0 }

    // Cuerpo de revolución básicos
    public static func volumenCilindro(r: Double, h: Double) -> Double { Double.pi*r*r*h }
    public static func areaCilindro(r: Double, h: Double) -> Double { 2*Double.pi*r*(r + h) }

    public static func volumenCono(r: Double, h: Double) -> Double { Double.pi*r*r*h/3.0 }
    public static func areaCono(r: Double, g: Double) -> Double { Double.pi*r*(r + g) } // g= generatriz

    public static func volumenEsfera(r: Double) -> Double { 4.0/3.0 * Double.pi * r*r*r }
    public static func areaEsfera(r: Double) -> Double { 4*Double.pi*r*r }
}
