# 🎬 MovieApp

App iOS desarrollada en Swift 5 utilizando SwiftUI y arquitectura VIPER, que consume la API pública de [TheMovieDB.org](https://www.themoviedb.org/).

## Arquitectura

Se implementa el patrón **VIPER** (View, Interactor, Presenter, Entity, Router), adaptado para trabajar con **SwiftUI** de manera modular.

## Tecnologías

- Swift 5
- SwiftUI
- VIPER
- URLSession (100% nativo)
- Plist para almacenamiento seguro de claves API

## Funcionalidades

- Listado de películas populares
- Detalle de película
- Consumo de API TheMovieDB.org
- Estructura escalable y mantenible

## Configuración

1. Crea un archivo `Config.plist` en el directorio `Resources/`.
2. Agrega la clave de la API:
