//
//  Physics.swift
//  LibrodeMatematicas
//
//  Created by Miguel Carlos Elizondo Martinez on 03/10/25.
//


import Foundation

/// Basic physics / Física básica
public enum Physics {
    // Kinematics / Cinemática

    /// Velocity = distance / time / Velocidad = distancia / tiempo
    public static func velocity(distance: Double, time: Double) -> Double? {
        guard time != 0 else { return nil }
        return distance / time
    }
    public static func velocidad(distancia: Double, tiempo: Double) -> Double? {
        velocity(distance: distancia, time: tiempo)
    }

    /// Acceleration in Δt / Aceleración en Δt
    public static func acceleration(initialV: Double, finalV: Double, time: Double) -> Double? {
        guard time != 0 else { return nil }
        return (finalV - initialV) / time
    }
    public static func aceleracion(vInicial: Double, vFinal: Double, tiempo: Double) -> Double? {
        acceleration(initialV: vInicial, finalV: vFinal, time: tiempo)
    }

    /// Force = m * a / Fuerza = m * a
    public static func force(mass: Double, acceleration: Double) -> Double {
        mass * acceleration
    }
    public static func fuerza(masa: Double, aceleracion: Double) -> Double {
        force(mass: masa, acceleration: aceleracion)
    }

    // Energy / Energía

    /// Kinetic energy = 0.5 m v² / Energía cinética
    public static func kineticEnergy(mass: Double, velocity: Double) -> Double {
        0.5 * mass * velocity * velocity
    }
    public static func energiaCinetica(masa: Double, velocidad: Double) -> Double {
        kineticEnergy(mass: masa, velocity: velocidad)
    }

    /// Potential energy (near Earth) / Energía potencial (cercana a la Tierra)
    public static func potentialEnergy(mass: Double, gravity: Double = 9.80665, height: Double) -> Double {
        mass * gravity * height
    }
    public static func energiaPotencial(masa: Double, gravedad: Double = 9.80665, altura: Double) -> Double {
        potentialEnergy(mass: masa, gravity: gravedad, height: altura)
    }

    /// Standard barometric pressure (simple) / Presión barométrica estándar (simple)
    public static func pressureAtAltitude(altitudeMeters alt: Double) -> Double {
        let T0 = 288.15, g = 9.80665, L = 0.0065, R = 287.058, p0 = 101_325.0
        if alt < 11_000 {
            return p0 * pow(1 - (L * alt) / T0, (g / (R * L)))
        } else {
            return 0.0 // fuera de rango del modelo simplificado
        }
    }
    public static func presionPorAltitud(altitudMetros alt: Double) -> Double {
        pressureAtAltitude(altitudeMeters: alt)
    }
}
