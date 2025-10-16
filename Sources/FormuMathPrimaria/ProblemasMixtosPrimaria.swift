//
//  ProblemasMixtosPrimaria.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Problemas “mixtos” que combinan fracciones/porcentajes/unidades/dinero.
/// Son determinísticos a partir de parámetros para testear sin aleatoriedad.
public enum ProblemasMixtosPrimaria {

    public struct Problema: Equatable {
        public let enunciado: String
        public let respuesta: [Double]
        public let tolerancia: Double

        public init(_ enunciado: String, _ respuesta: [Double], tolerancia: Double = 1e-6) {
            self.enunciado = enunciado
            self.respuesta = respuesta
            self.tolerancia = tolerancia
        }
    }

    // MARK: - 1) Descuento + IVA
    /// Precio base P, descuento d% y luego IVA i% → precio final.
    public static func descuentoMasIVA(precio: Double, descuento: Double, iva: Double) -> Problema {
        // P -> P*(1 - d/100) -> * (1 + iva/100)
        let final = precio * (1.0 - descuento/100.0) * (1.0 + iva/100.0)
        let enun = "Un artículo cuesta \(fmt(precio)). Tiene \(fmt(descuento))% de descuento y luego IVA de \(fmt(iva))%. ¿Precio final?"
        return Problema(enun, [final], tolerancia: 1e-6)
    }

    // MARK: - 2) Fracción de tiempo + conversión a minutos
    /// T horas; se usa a/b del tiempo; ¿cuántos minutos se usan?
    public static func fraccionDeTiempoEnMinutos(horasT: Double, a: Int, b: Int) -> Problema {
        precondition(b != 0)
        let horasUsadas = (Double(a) / Double(b)) * horasT
        let minutos = Unidades.convertirTiempo(horasUsadas, de: .h, a: .min)
        let enun = "De \(fmt(horasT)) h se usa \(a)/\(b) del tiempo. ¿Cuántos minutos se usan?"
        return Problema(enun, [minutos], tolerancia: 1e-9)
    }

    // MARK: - 3) Receta a escala + costo por kg
    /// Receta: r personas usan gramosX de harina. Para s personas, ¿cuánto cuesta si el kg vale precioKg?
    public static func recetaEscaladaCosto(para r: Int, usa gramosX: Double, para s: Int, precioKg: Dinero) -> (problema: Problema, costo: Dinero) {
        precondition(r > 0 && gramosX >= 0 && s > 0)
        let gramos = gramosX * Double(s) / Double(r)
        // Convertimos a kg
        let kg = gramos / 1000.0
        let costoDouble = (Double(precioKg.centavos)/100.0) * kg
        let costoDinero = Dinero(desdeDouble: costoDouble, simbolo: precioKg.simbolo)
        let enun = "Una receta para \(r) personas usa \(fmt(gramosX)) g de harina. Para \(s) personas, ¿cuánto cuesta si el kg vale \(precioKg)?"
        return (Problema(enun, [costoDouble], tolerancia: 1e-4), costoDinero)
    }

    // MARK: - 4) Viaje: velocidad + tiempo + peaje (dinero)
    /// Se viaja a v km/h durante t horas; un peaje cuesta 'peaje' (Dinero) por auto.
    /// ¿Distancia total (km) y costo total para n autos?
    public static func viajeDistanciaYCosto(velocidadKmH v: Double, tiempoHoras t: Double, peaje: Dinero, autos n: Int) -> (problema: Problema, costo: Dinero) {
        let d = v * t
        let costo = peaje * n
        let enun = "Se viaja a \(fmt(v)) km/h durante \(fmt(t)) h. Un peaje cuesta \(peaje) por auto. Para \(n) autos: ¿distancia (km) y costo total?"
        return (Problema(enun, [d, Double(costo.centavos)/100.0], tolerancia: 1e-9), costo)
    }

    // MARK: - Verificador
    public static func verificar(_ p: Problema, respuesta: [Double]) -> Bool {
        guard respuesta.count == p.respuesta.count else { return false }
        for (u, e) in zip(respuesta, p.respuesta) {
            if abs(u - e) > p.tolerancia { return false }
        }
        return true
    }

    // MARK: - Helpers
    private static func fmt(_ x: Double) -> String {
        if abs(x.rounded(.toNearestOrAwayFromZero) - x) < 1e-12 {
            return String(format: "%.0f", x)
        } else {
            return String(format: "%.2f", x)
        }
    }
}
