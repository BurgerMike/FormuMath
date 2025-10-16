# FormuMath 📘
_A complete math toolkit & “book as code”, from Kinder to Master’s, in Swift 6._

- **Swift**: 6.0  
- **Xcode**: 16+  
- **Platforms**: iOS 17+, macOS 13+ (pure Foundation)

FormuMath is a modular collection of small, well-tested Swift utilities grouped by **education level**. Each topic lives in its own file and comes with straightforward APIs and unit tests using **Swift Testing** (`import Testing`).

---

## Table of Contents
- [Installation](#installation)
- [Directory Layout](#directory-layout)
- [Quickstart](#quickstart)
- [API Overview by Level](#api-overview-by-level)
  - [Kinder](#kinder)
  - [Primaria](#primaria)
  - [Secundaria](#secundaria)
  - [Preparatoria](#preparatoria)
  - [Universidad](#universidad)
  - [Maestría](#maestría)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## Installation

### Swift Package Manager (local)
No external dependencies are required. Use the repo locally or as a package:

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FormuMath",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        .library(name: "FormuMath", targets: ["FormuMath"])
    ],
    targets: [
        .target(name: "FormuMath"),
        .testTarget(name: "FormuMathTests", dependencies: ["FormuMath"])
    ]
)
```

Then:
```bash
swift build
swift test
```

> If your Xcode project shows files in red, delete the broken references and re-add the files from their real path; ensure **Target Membership** includes your library and tests.

---

## Directory Layout

```
FormuMath/
├─ Package.swift
├─ Sources/
│  └─ FormuMath/
│     ├─ Kinder/
│     ├─ Primaria/
│     ├─ PrimariaExtra/
│     ├─ Secundaria/
│     ├─ SecundariaExtra/
│     ├─ Prepa/
│     ├─ PrepaExtra/
│     ├─ Universidad/
│     ├─ UniversidadExtra/
│     └─ Maestria/
└─ Tests/
   └─ FormuMathTests/
```

---

## Quickstart

```swift
import FormuMath

// Kinder – línea numérica
let ln = LineaNumerica(min: 0, max: 20)
let caminoSuma = ln.sumaCamino(3, 4)        // [3,4,5,6,7]
let parejas10  = ln.amigosDel(10)            // [(0,10),(1,9),...,(10,0)]

// Secundaria – combinatoria
// let ways = try CombiProb.nCr(10, 3)      // 120 (UInt64)

// Prepa – cónicas
let elipse = Conicas.elipseEjes(h: 0, k: 0, a: 5, b: 3)
// -> (c, focos, excentricidad)

// Universidad – resolver sistema
let A = Matrix(3,3,[3,1,0, 1,2,1, 0,1,3])
let b = [5.0,6.0,7.0]
let x = Matrix.resolver(A: A, b: b)          // [x1,x2,x3]

// Maestría – optimización (L-BFGS)
let f: ([Double])->Double = { v in
  let x=v[0], y=v[1]
  return (x-1)*(x-1) + 2*(y+2)*(y+2)
}
let xmin = OptConvexa.lbfgs(f, x0: [5,5])    // ≈ [1, -2]
```

---

## API Overview by Level

Below is the **index of topics/files** you’ll find in `Sources/FormuMath/…`.  
Use this as your “book” table of contents.

### Kinder
- `NumerosBasicos.swift` — conteo, pares/impares, comparar.
- `OperacionesSimples.swift` — suma/resta concretas.
- `PatronesYSecuencias.swift` — secuencias simples, completar.
- `ComparacionesYOrden.swift` — mayor/menor/igual; ordenar listas.
- `FormasBasicas.swift` — formas 2D, reconocimiento.
- `MedicionIntro.swift` — longitudes/tiempo en contexto.
- `LineaNumerica.swift` — **(incluye `amigosDel(_:)` y fix `Swift.min/max`)**
- `EjerciciosKinder.swift` — generadores de ejercicios básicos.

### Primaria
**Core**
- `Fracciones.swift`, `PorcentajesYProporciones.swift`
- `DecimalesYRedondeo.swift`
- `UnidadesYConversiones.swift`
- `ProblemasDeTextoPrimaria.swift`
- `ProporcionesAvanzadas.swift`
- `DineroYCambio.swift`
- `ProblemasMixtosPrimaria.swift`

**Extras**
- `PrimariaExtra/DivisibilidadYMCM.swift` — divisibilidad, **MCD/MCM**.
- `PrimariaExtra/EstadisticaBasicaPrimaria.swift` — media/mediana/moda/rango.
- `PrimariaExtra/AreasYPerimetros.swift` — rectángulo, triángulo, círculo.

### Secundaria
**Core**
- `LogaritmosYExponenciales.swift`
- `CombinatoriaYProbabilidad.swift`
- `Polinomios.swift`
- `Progresiones.swift`
- `TrigIdentidades.swift`
- `GeometriaAnalitica.swift`
- `Vectores2D.swift` — **`Sendable` fix para Swift 6**

**Extras**
- `SecundariaExtra/EcuacionesEInecuaciones.swift` — lineales, cuadráticas, inecuaciones.
- `SecundariaExtra/SistemasLinealesSecundaria.swift` — 2×2 por sustitución/igualación.
- `SecundariaExtra/EstadisticaDescriptivaSecundaria.swift` — tablas, histograma, var/desv.
- `SecundariaExtra/VolumenesYAreasSuperficiales.swift` — prismas, cilindros, conos, esfera.

### Preparatoria
**Core**
- `Prepa/FuncionesClasicas.swift` — lineal, cuadrática, racional, exp/log.
- `Prepa/TransformacionesDeFunciones.swift` — `g(x)=a f(b(x−h))+k`, inversa numérica.
- `Prepa/TrigonometriaAvanzada.swift` — doble/mitad, leyes seno/coseno.
- `Prepa/Vectores3D.swift`
- `Prepa/MatricesIntro.swift` — 2×2/3×3, inversa 2×2, Cramer 3×3.
- `Prepa/Conicas.swift` — parábola/elipse/hipérbola (canónicas).

**Extras**
- `PrepaExtra/LimitesYContinuidad.swift` — límites notables, chequeo numérico de continuidad.
- `PrepaExtra/ComplejosIntro.swift` — suma/prod/div, módulo/argumento, potencias.
- `PrepaExtra/NewtonRaphson.swift` — raíces 1D (derivada numérica opcional).

### Universidad
**Core**
- `Universidad/AlgebraLineal.swift` — matriz densa pequeña; **Gauss con fix de exclusividad**, LU, potencia.
- `Universidad/CalculoMultivariable.swift` — gradiente, jacobiano, hessiano (numéricos).
- `Universidad/IntegralesMultiplesYVectorial.swift` — ∇, ∇·, ∇×; integral doble (Simpson 2D).
- `Universidad/EDOIntro.swift` — Euler y RK4 (escalar y sistemas).
- `Universidad/ProbabilidadDistribuciones.swift` — Normal/Exponencial/Poisson/Binomial.
- `Universidad/InferenciaEstadistica.swift` — IC y pruebas z/t.
- `Universidad/RegresionLineal.swift` — OLS simple y múltiple.

**Extras**
- `UniversidadExtra/IntegralesLineaYSuperficie.swift` — ∮F·dr y flujo ∬F·n dS (Simpson 1D/2D).
- `UniversidadExtra/EDOAnaliticas.swift` — 1º orden (integrating factor), 2º orden ctes.
- `UniversidadExtra/EDPBasicas.swift` — Laplace/“heat” 1D por separación.

### Maestría
- `Maestria/OptimizacionConvexa.swift` — descenso con Armijo, Newton, **L-BFGS**, KKT (igualdades).
- `Maestria/IntegracionAdaptativa.swift` — Simpson adaptativo, Boole compuesta.
- `Maestria/RK4Adaptativo.swift` — **versión “parser-safe”** (error control).
- `Maestria/NewtonMultivariable.swift` — Newton con Jacobiano numérico y línea de búsqueda.
- `Maestria/EDPClasicas.swift` — series para calor/onda y esquema explícito (FTCS) estable.
- `Maestria/AnalisisComplejoResiduos.swift` — residuo en polo simple.

---

## Testing

We use **Swift Testing** (Xcode 16 / Swift 6). Run:

```bash
swift test
```

If you vendored Apple’s `swift-testing` package separately, add it to `Package.swift` and to the test target’s dependencies. On recent Xcode versions, `import Testing` works out of the box.

---

## Troubleshooting

- **“Build input files cannot be found …/Sources/…”**  
  The file was moved/renamed on disk. In Xcode, delete the red reference, re-add the file with _Add Files to…_, and verify **Target Membership**.

- **`Use of 'min'/'max' refers to instance method rather than global function`**  
  You created properties named `min`/`max` in a type. Use `Swift.min/Swift.max` explicitly (see `LineaNumerica.swift`), or rename your properties.

- **Unicode minus (–) or symbols like `λ` cause parse errors**  
  Replace Unicode punctuation with ASCII (`-`), and write `Double.pi` instead of `.pi` when adjacent to operators.

- **Swift 6 concurrency warnings on static lets**  
  Mark trivial structs as `Sendable` (e.g., `struct Vec2: Sendable, … { static let cero = … }`).

- **Overlapping accesses / exclusivity**  
  Avoid `swap(&M[p,c], &M[piv,c])` on the same buffer; use buffer-index `swapAt` on the backing array (fixed in `AlgebraLineal.swift`).

---

## Contributing

- Keep files **small and focused** (one topic per file).
- Add **tests** in `Tests/FormuMathTests/…` mirroring the folder/topic structure.
- Prefer **explicit ASCII** operators and `Double.pi`.
- Follow the existing **assertions & tolerances** style (`1e-12`/`1e-6` depending on numeric method).

---

## License

Choose what fits your project (MIT/Apache-2.0/etc.). Add a `LICENSE` file at the repository root.
