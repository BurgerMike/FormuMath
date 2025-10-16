//
//  UnidadesYConversiones.swift
//  FormuMath
//
//  Created by Miguel Carlos Elizondo Mrtinez on 16/10/25.
//

import Foundation

public enum Unidades {
    // MARK: - Longitud
    public enum Longitud: String { case mm, cm, m, km }

    /// Convierte longitud `valor` desde `origen` a `destino`.
    public static func convertirLongitud(_ valor: Double, de origen: Longitud, a destino: Longitud) -> Double {
        // Pasar a metros
        let enMetros: Double = {
            switch origen {
            case .mm: return valor / 1000.0
            case .cm: return valor / 100.0
            case .m:  return valor
            case .km: return valor * 1000.0
            }
        }()
        // Metros -> destino
        switch destino {
        case .mm: return enMetros * 1000.0
        case .cm: return enMetros * 100.0
        case .m:  return enMetros
        case .km: return enMetros / 1000.0
        }
    }

    // MARK: - Masa
    public enum Masa: String { case g, kg }

    public static func convertirMasa(_ valor: Double, de origen: Masa, a destino: Masa) -> Double {
        let enKg: Double = (origen == .g) ? valor / 1000.0 : valor
        return (destino == .g) ? enKg * 1000.0 : enKg
    }

    // MARK: - Tiempo
    public enum Tiempo: String { case s, min, h, d } // segundos, minutos, horas, días

    public static func convertirTiempo(_ valor: Double, de origen: Tiempo, a destino: Tiempo) -> Double {
        // a segundos
        let enSeg: Double = {
            switch origen {
            case .s:   return valor
            case .min: return valor * 60.0
            case .h:   return valor * 3600.0
            case .d:   return valor * 86400.0
            }
        }()
        // a destino
        switch destino {
        case .s:   return enSeg
        case .min: return enSeg / 60.0
        case .h:   return enSeg / 3600.0
        case .d:   return enSeg / 86400.0
        }
    }

    // MARK: - Volumen
    public enum Volumen: String { case mL, L }

    public static func convertirVolumen(_ valor: Double, de origen: Volumen, a destino: Volumen) -> Double {
        let enL: Double = (origen == .mL) ? valor / 1000.0 : valor
        return (destino == .mL) ? enL * 1000.0 : enL
    }

    // MARK: - Temperatura
    public enum Temperatura: String { case C, F, K }

    /// Conversión de temperatura (C↔F↔K). Notas: K = C + 273.15
    public static func convertirTemperatura(_ valor: Double, de origen: Temperatura, a destino: Temperatura) -> Double {
        if origen == destino { return valor }
        // a Celsius
        let c: Double = {
            switch origen {
            case .C: return valor
            case .F: return (valor - 32.0) * 5.0/9.0
            case .K: return valor - 273.15
            }
        }()
        // de Celsius a destino
        switch destino {
        case .C: return c
        case .F: return c * 9.0/5.0 + 32.0
        case .K: return c + 273.15
        }
    }

    // MARK: - Utilidades de formato
    public static func formatear(_ x: Double, decimales: Int = 2) -> String {
        String(format: "%.\(decimales)f", x)
    }
}
