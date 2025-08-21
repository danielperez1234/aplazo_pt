# Prueba Técnica - Aplazo (Flutter)

Este repositorio contiene el código fuente de un proyecto de prueba técnica desarrollado con Flutter. La aplicación está diseñada para ser multiplataforma, funcionando tanto en Android como en iOS desde una única base de código.



## Enfoque

Este proyecto ha sido diseñado y desarrollado siguiendo los principios de Clean Architecture, con el objetivo de establecer una base de código limpia, robusta y escalable.

Desde el inicio, el enfoque principal fue ir más allá de la simple funcionalidad para demostrar cómo un diseño bien pensado puede hacer que un proyecto sea fácil de mantener y reutilizable. Esto se logró priorizando la separación de responsabilidades, lo que asegura que cada componente del sistema tenga un propósito claro.

Aunque se trata de una aplicación de pequeña escala, la arquitectura implementada la convierte en una solución sólida.


### Instalación

Sigue estos pasos para configurar el entorno de desarrollo:

1.  **Clona el repositorio:**
    ```sh
    git clone https://github.com/danielperez1234/aplazo_pt.git
    ```

2.  **Navega al directorio del proyecto:**
    ```sh
    cd aplazo_pt
    ```

3.  **Instala las dependencias:**
    Ejecuta el siguiente comando para descargar todas las dependencias del proyecto definidas en `pubspec.yaml`.
    ```sh
    flutter pub get
    ```

4.  **Ejecuta la aplicación:**
    Conecta un dispositivo o inicia un emulador/simulador y ejecuta el siguiente comando:
    ```sh
    flutter run
    ```


### Unit test

1.  **Construir clases moc**
    ejecuta el siguiente comando:
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs

    ```

---

## Autor

*   **Daniel Perez** 

---