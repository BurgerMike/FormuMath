import Foundation

/// Utilidades de línea numérica para Kinder (sumar/restar como saltos).
public struct LineaNumerica {
    public let min: Int
    public let max: Int

    public init(min: Int = 0, max: Int = 20) {
        precondition(min <= max, "min <= max")
        self.min = min
        self.max = max
    }

    /// Recorta un valor al rango [min, max].
    public func clamp(_ x: Int) -> Int {
        return Swift.max(min, Swift.min(x, max))
    }

    /// Salto a la derecha (suma) desde `pos` con `pasos` (con recorte).
    public func saltarDerecha(desde pos: Int, pasos: Int) -> Int {
        return clamp(pos + Swift.max(0, pasos))
    }

    /// Salto a la izquierda (resta) desde `pos` con `pasos` (con recorte).
    public func saltarIzquierda(desde pos: Int, pasos: Int) -> Int {
        return clamp(pos - Swift.max(0, pasos))
    }

    /// “Suma en la línea”: devuelve camino de posiciones (incluye inicio y fin).
    /// Ej: suma(3, 4) en [0,20] -> [3,4,5,6,7]
    public func sumaCamino(_ a: Int, _ b: Int) -> [Int] {
        let start = clamp(a)
        let pasos = Swift.max(0, b)
        return (0...pasos).map { clamp(start + $0) }
    }

    /// “Resta en la línea”: devuelve camino (incluye inicio y fin).
    /// Ej: resta(7, 2) -> [7,6,5]
    public func restaCamino(_ a: Int, _ b: Int) -> [Int] {
        let start = clamp(a)
        let pasos = Swift.max(0, b)
        return (0...pasos).map { clamp(start - $0) }
    }

    /// Recorrido [a,b] en la línea (ordenado, recortado).
    public func segmento(_ a: Int, _ b: Int) -> [Int] {
        let lo = clamp(Swift.min(a,b))
        let hi = clamp(Swift.max(a,b))
        return Array(lo...hi)
    }
    
    public func amigosDel(_ x: Int, radio: Int = 1, incluirCentro: Bool = false) -> [Int] {
        let xc = clamp(x)
        let r = Swift.max(0, radio)
        var s = Set<Int>()
        if incluirCentro { s.insert(xc) }
        if r == 0 { return Array(s).sorted() }

        for d in 1...r {
            s.insert(clamp(xc - d))
            s.insert(clamp(xc + d))
        }
        return Array(s).sorted()
    }
}

