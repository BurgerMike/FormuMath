//
//  ProblemasDeTextoPrimaria.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

/// Plantillas de problemas de texto típicos de primaria.
/// Las funciones son determinísticas a partir de parámetros, para que puedas testear sin aleatoriedad.
public enum ProblemasDeTextoPrimaria {
    public enum Tipo {
        case porcentajeDescuento          // “Un precio P con D% de descuento…”
        case porcentajeAumento            // “Un precio P con aumento D%…”
        case fraccionDeCantidad           // “¿Cuánto es a/b de N?”
        case reglaDeTresDirecta           // “a : b = c : x”
        case proporcionRecetaEscala       // “Para R personas se usan X g; ¿para S personas?”
        case distanciaVelocidadTiempo     // “Si vas a v km/h por t h, ¿cuánta distancia?”
        case conversionUnidades           // “Convierte X en unidadA a unidadB”
    }

    public struct Problema: Equatable {
        public let tipo: Tipo
        public let enunciado: String
        /// Respuesta esperada en Double (o arreglo 1-long). Para enteros, vendrá como .0
        public let respuesta: [Double]
        /// Margen para verificación numérica
        public let tolerancia: Double

        public init(tipo: Tipo, enunciado: String, respuesta: [Double], tolerancia: Double = 1e-9) {
            self.tipo = tipo
            self.enunciado = enunciado
            self.respuesta = respuesta
            self.tolerancia = tolerancia
        }
    }

    // MARK: - Constructores

    public static func porcentajeDescuento(precio: Double, descuento: Double) -> Problema {
        // precio final = P * (1 - d/100)
        let final = precio * (1.0 - descuento / 100.0)
        let enun = "Un artículo cuesta \(fmt(precio)). Tiene \(fmt(descuento))% de descuento. ¿Precio final?"
        return Problema(tipo: .porcentajeDescuento, enunciado: enun, respuesta: [final], tolerancia: 1e-6)
    }

    public static func porcentajeAumento(precio: Double, aumento: Double) -> Problema {
        let final = precio * (1.0 + aumento / 100.0)
        let enun = "Un artículo cuesta \(fmt(precio)). Sube \(fmt(aumento))%. ¿Precio final?"
        return Problema(tipo: .porcentajeAumento, enunciado: enun, respuesta: [final], tolerancia: 1e-6)
    }

    public static func fraccionDeCantidad(numerador: Int, denominador: Int, de cantidad: Double) -> Problema {
        precondition(denominador != 0)
        let valor = (Double(numerador) / Double(denominador)) * cantidad
        let enun = "¿Cuánto es \(numerador)/\(denominador) de \(fmt(cantidad))?"
        return Problema(tipo: .fraccionDeCantidad, enunciado: enun, respuesta: [valor], tolerancia: 1e-9)
    }

    public static func reglaDeTresDirecta(a: Double, b: Double, c: Double) -> Problema {
        precondition(a != 0)
        let x = (b * c) / a
        let enun = "Si \(fmt(a)) se relaciona con \(fmt(b)) como \(fmt(c)) con x, ¿cuánto vale x?"
        return Problema(tipo: .reglaDeTresDirecta, enunciado: enun, respuesta: [x], tolerancia: 1e-9)
    }

    public static func proporcionRecetaEscala(para r: Int, usa gramosX: Double, para s: Int) -> Problema {
        precondition(r > 0)
        let x = gramosX * Double(s) / Double(r)
        let enun = "Una receta para \(r) personas usa \(fmt(gramosX)) g de harina. ¿Cuántos gramos para \(s) personas?"
        return Problema(tipo: .proporcionRecetaEscala, enunciado: enun, respuesta: [x], tolerancia: 1e-9)
    }

    public static func distanciaVelocidadTiempo(velocidadKmH v: Double, tiempoHoras t: Double) -> Problema {
        let d = v * t
        let enun = "Si viajas a \(fmt(v)) km/h durante \(fmt(t)) h, ¿qué distancia recorres (en km)?"
        return Problema(tipo: .distanciaVelocidadTiempo, enunciado: enun, respuesta: [d], tolerancia: 1e-9)
    }

    public enum Magnitud { case longitud(Unidades.Longitud, Unidades.Longitud)
                           case masa(Unidades.Masa, Unidades.Masa)
                           case tiempo(Unidades.Tiempo, Unidades.Tiempo)
                           case volumen(Unidades.Volumen, Unidades.Volumen)
                           case temperatura(Unidades.Temperatura, Unidades.Temperatura) }

    public static func conversionUnidades(valor: Double, magnitud: Magnitud) -> Problema {
        let (texto, res): (String, Double) = {
            switch magnitud {
            case let .longitud(or, de):
                let r = Unidades.convertirLongitud(valor, de: or, a: de)
                return ("Convierte \(fmt(valor)) \(or.rawValue) a \(de.rawValue).", r)
            case let .masa(or, de):
                let r = Unidades.convertirMasa(valor, de: or, a: de)
                return ("Convierte \(fmt(valor)) \(or.rawValue) a \(de.rawValue).", r)
            case let .tiempo(or, de):
                let r = Unidades.convertirTiempo(valor, de: or, a: de)
                return ("Convierte \(fmt(valor)) \(or.rawValue) a \(de.rawValue).", r)
            case let .volumen(or, de):
                let r = Unidades.convertirVolumen(valor, de: or, a: de)
                return ("Convierte \(fmt(valor)) \(or.rawValue) a \(de.rawValue).", r)
            case let .temperatura(or, de):
                let r = Unidades.convertirTemperatura(valor, de: or, a: de)
                return ("Convierte \(fmt(valor))°\(or.rawValue) a \(de.rawValue).", r)
            }
        }()
        return Problema(tipo: .conversionUnidades, enunciado: texto, respuesta: [res], tolerancia: 1e-9)
    }

    // MARK: - Verificador
    /// Verifica con tolerancia absoluta (para primaria es suficiente).
    public static func verificar(_ problema: Problema, respuesta usuario: [Double]) -> Bool {
        guard usuario.count == problema.respuesta.count else { return false }
        for (u, e) in zip(usuario, problema.respuesta) {
            if abs(u - e) > problema.tolerancia { return false }
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
