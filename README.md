# Bici Coruña 2.0

Aplicación móvil desarrollada en **Flutter** que consume la API pública de **biciCoruña** para mostrar información **estática y dinámica** sobre el estado de las estaciones de bicicletas.

---

## Enfoque del proyecto

El proyecto sigue una arquitectura **MVVM (Model – View – ViewModel)** con el objetivo de separar responsabilidades, mejorar la legibilidad del código y facilitar su mantenimiento.

La aplicación consta de **dos pantallas principales**: una pantalla general y una pantalla de detalle de estación.

---

### Home Screen

<p align="center">
  <img src="image-2.png" width="250">
  <img src="image-3.png" width="250">
</p>

Esta pantalla presenta un **AppBar** con un botón que permite la recarga manual de los datos obtenidos desde la API.

El cuerpo de la pantalla está compuesto por una lista vertical con los siguientes elementos, en orden:

- Una **gráfica de barras** que muestra el *Top 5 de estaciones con mayor número de bicicletas disponibles*.
- Una **gráfica circular** que representa la ocupación de la estación marcada como favorita.
- Un listado del resto de estaciones, donde se muestra:
  - El número de bicicletas disponibles.
  - El porcentaje de ocupación.
  - Un icono de estrella que permite marcar una estación como favorita.

Al pulsar sobre cualquiera de las estaciones, se accede a la pantalla de detalle correspondiente.

---

### Estación Detail Screen

![Detalle_screen](image-4.png)  
![Exportacion_pdf](image-5.png)

Esta pantalla muestra información detallada de la estación seleccionada, incluyendo su estado, ocupación y disponibilidad.

Además, incorpora un elemento visual que, en función de la lógica interna de la aplicación, indica si **compensa o no acudir a la estación en ese momento**.

En la parte inferior de la pantalla se incluye un botón que permite **exportar la información de la estación seleccionada a un documento PDF**.

---

## Gráficas elegidas

### Gráfica de barras – *Top 5 estaciones por número de bicicletas*

![Gráfico de barras](image.png)

- Permite comparar rápidamente las estaciones con mayor disponibilidad de bicicletas.
- Al pulsar sobre una barra se accede al detalle de la estación correspondiente.
- Se ha optado por una representación limpia, sin etiquetas en el eje, para evitar la saturación visual.

---

### Gráfica circular – *Ocupación de una estación*

![Gráfica circular](image-1.png)

- Representa la distribución entre bicicletas disponibles, espacios libres y espacios bloqueados.
- Permite visualizar proporciones de un total de forma intuitiva.
- Se reutiliza tanto en la vista de detalle como en la visualización de la estación favorita.
- Facilita una comprensión rápida del estado de la estación.

---

## Dependencias externas utilizadas

- **http**: consumo de la API REST pública.
- **provider**: gestión del estado de la aplicación siguiendo la arquitectura MVVM.
- **fl_chart**: visualización de datos mediante gráficas.
- **pdf**: generación de documentos PDF.
- **printing**: visualización e impresión de los documentos PDF generados.