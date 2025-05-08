# 🎬 MovieApp

App iOS desarrollada en Swift 5 utilizando SwiftUI y arquitectura VIPER, que consume la API pública de [TheMovieDB.org](https://www.themoviedb.org/).

## Arquitectura

Se implementa el patrón **VIPER** (View, Interactor, Presenter, Entity, Router), adaptado para trabajar con **SwiftUI** de manera modular.

## Tecnologías

- Swift 5
- SwiftUI
- VIPER
- URLSession (100% nativo)
- Config.plist para configuración segura de claves API

## Funcionalidades

- Listado de películas populares
- Detalle de película
- Consumo de API TheMovieDB.org
- Estructura escalable y mantenible

## Configuración

1. Crea un archivo `Config.plist` en el directorio `Resources/`.
2. Agrega la clave de la API

## Pantallas
<img src="https://github.com/user-attachments/assets/a71822a4-8727-48da-ac5f-b10cdfbb2ba5" width="200">
<img src="https://github.com/user-attachments/assets/a52c1acf-e10d-448c-ac81-c3977205c89f" width="200">
<img src="https://github.com/user-attachments/assets/aeb9e491-884c-4b16-b664-7f65edf907bf" width="200">
<img src="https://github.com/user-attachments/assets/6ed0dd41-ea50-45d6-95cc-b655292af145" width="200">

## Próximas mejoras
- Búsqueda por título
- Favoritos locales
- Tests unitarios
- Modo oscuro

