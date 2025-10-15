import XCTest
@testable import FormuMath  // <- cambia al nombre de tu target si es distinto

final class LibrodeMatematicasXCTests: XCTestCase {

    // MARK: - Basics
    func testBasics() {
        XCTAssertEqual(Basics.add(2, 3), 5)
        XCTAssertEqual(Basics.suma(2, 3), 5)
        XCTAssertEqual(Basics.resta(5, 2), 3)
        XCTAssertEqual(Basics.multiplicar(3, 4), 12)
        XCTAssertEqual(Basics.dividir(4, 2), 2)
        XCTAssertNil(Basics.dividir(1, 0))
    }

    // MARK: - Algebra
    func testAlgebra() {
        XCTAssertEqual(Algebra.solveLinear(a: 2, b: -4), 2)
        let roots = Algebra.solveQuadratic(a: 1, b: -3, c: 2)
        XCTAssertEqual(roots.0, 2)
        XCTAssertEqual(roots.1, 1)
        XCTAssertEqual(Algebra.mcd(84, 30), 6)
        XCTAssertEqual(Algebra.mcm(21, 6), 42)
    }

    // MARK: - Geometry
    func testGeometry() {
        XCTAssertEqual(Geometry.areaCuadrado(lado: 4), 16)
        XCTAssertEqual(Geometry.areaOfCircle(radius: 1), .pi, accuracy: 1e-12)
        XCTAssertEqual(Geometry.distancia2D(x1: 0, y1: 0, x2: 3, y2: 4), 5)
        XCTAssertEqual(
            Geometry.distancia3D(x1: 0, y1: 0, z1: 0, x2: 1, y2: 2, z2: 2),
            3, accuracy: 1e-12
        )
    }

    // MARK: - Calculus
    func testCalculus() {
        let f: (Double) -> Double = { x in x*x } // f(x) = x^2
        XCTAssertEqual(Calculus.derivative(f, at: 3), 6, accuracy: 1e-3) // f'(x)=2x
        XCTAssertEqual(Calculus.integral(sin, a: 0, b: .pi, n: 100_000), 2, accuracy: 1e-3)

        // newton root devuelve opcional -> comprueba existencia y valor
        let r = Calculus.newtonRoot({ $0*$0 - 2 }, initialGuess: 1.0)
        XCTAssertNotNil(r)
        XCTAssertEqual(r!, sqrt(2), accuracy: 1e-8)
    }

    // MARK: - Physics
    func testPhysics() {
        XCTAssertEqual(Physics.fuerza(masa: 10, aceleracion: 2), 20)
        XCTAssertEqual(Physics.energiaCinetica(masa: 2, velocidad: 3), 9)
        XCTAssertEqual(Physics.velocidad(distancia: 100, tiempo: 10), 10)
    }

    // MARK: - Statistics
    func testStatistics() {
        let xs = [1.0, 2.0, 3.0, 4.0]
        XCTAssertEqual(Statistics.media(xs), 2.5)
        XCTAssertEqual(
            Statistics.desviacionEstandar(xs),
            Statistics.varianza(xs).squareRoot(),
            accuracy: 1e-12
        )
    }
}

