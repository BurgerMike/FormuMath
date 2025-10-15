//
//  Geometria.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//

import Foundation

/// Geometry formulas / Fórmulas de geometría
public enum Geometry {
    // Areas / Áreas
    public static func areaOfSquare(side: Double) -> Double { side * side }
    public static func areaCuadrado(lado: Double) -> Double { areaOfSquare(side: lado) }

    public static func areaOfRectangle(width: Double, height: Double) -> Double { width * height }
    public static func areaRectangulo(ancho: Double, alto: Double) -> Double { areaOfRectangle(width: ancho, height: alto) }

    public static func areaOfCircle(radius: Double) -> Double { .pi * radius * radius }
    public static func areaCirculo(radio: Double) -> Double { areaOfCircle(radius: radio) }

    public static func areaOfTriangle(base: Double, height: Double) -> Double { 0.5 * base * height }
    public static func areaTriangulo(base: Double, altura: Double) -> Double { areaOfTriangle(base: base, height: altura) }

    // Perimeters / Perímetros
    public static func perimeterOfRectangle(width: Double, height: Double) -> Double { 2 * (width + height) }
    public static func perimetroRectangulo(ancho: Double, alto: Double) -> Double { perimeterOfRectangle(width: ancho, height: alto) }

    // Volumes / Volúmenes
    public static func volumeOfCube(side: Double) -> Double { side * side * side }
    public static func volumenCubo(lado: Double) -> Double { volumeOfCube(side: lado) }

    // Distances / Distancias
    public static func distance2D(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        hypot(x2 - x1, y2 - y1)
    }
    public static func distancia2D(x1: Double, y1: Double, x2: Double, y2: Double) -> Double {
        distance2D(x1: x1, y1: y1, x2: x2, y2: y2)
    }

    public static func distance3D(x1: Double, y1: Double, z1: Double,
                                  x2: Double, y2: Double, z2: Double) -> Double {
        sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2) + pow(z2 - z1, 2))
    }
    public static func distancia3D(x1: Double, y1: Double, z1: Double,
                                   x2: Double, y2: Double, z2: Double) -> Double {
        distance3D(x1: x1, y1: y1, z1: z1, x2: x2, y2: y2, z2: z2)
    }
}
