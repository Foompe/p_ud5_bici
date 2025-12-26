# 📱 Bici Coruña 2.0

Aplicación móvil desarrollada en **Flutter** que consume la API pública del sistema de bicicletas de A Coruña para mostrar información actualizada sobre las estaciones, su ocupación y disponibilidad de bicicletas.

---

## 🧭 Enfoque del proyecto

El proyecto sigue una arquitectura **MVVM (Model – View – ViewModel)** para separar responsabilidades y mejorar la legibilidad del código.

- **Model**  
  Representa los datos obtenidos directamente de la API (`EstacionInfo`, `EstacionStatus`).

- **Repository**  
  Se encarga de la comunicación con la API y de transformar los datos en bruto en modelos de dominio.

- **ViewModel**  
  Contiene la lógica de negocio y prepara los datos para la interfaz (`EstacionUiData`), evitando que la vista tenga lógica compleja.

- **View (UI)**  
  Muestra los datos y gestiona la interacción del usuario (navegación, selección de estación favorita y refresco de información).

Este enfoque facilita el mantenimiento, mejora la organización del código y reduce el acoplamiento entre la lógica y la interfaz.

---

## 📊 Justificación de las gráficas elegidas

### Gráfica de barras – *Top 5 estaciones por número de bicicletas*

- Permite comparar rápidamente las estaciones con mayor disponibilidad.
- Es adecuada para representar rankings.
- Se limita al **Top 5** para evitar saturación visual y mejorar la claridad.

### Gráfica circular – *Ocupación de una estación*

- Representa la distribución de bicicletas y espacios disponibles.
- Permite visualizar proporciones de un total de forma intuitiva.
- Se reutiliza tanto en la vista de detalle como en la estación favorita.

Las dos gráficas se complementan:
- **Barras → comparación**
- **Circular → distribución**

---

## 📦 Tecnologías y dependencias utilizadas

- **Flutter**  
  Framework principal para el desarrollo de la aplicación móvil.

- **http**  
  Consumo de la API REST pública del sistema de bicicletas.

- **provider**  
  Gestión del estado de la aplicación siguiendo la arquitectura MVVM.

- **fl_chart**  
  Creación de gráficas de barras y circulares.

- **pdf**  
  Generación de informes en formato PDF con el detalle de una estación.

- **printing**  
  Visualización, impresión y exportación del PDF generado.

---

## ✅ Conclusión

La aplicación presenta información compleja de forma clara e intuitiva, aplicando buenas prácticas de arquitectura, visualización de datos y reutilización de componentes, además de ofrecer funcionalidades prácticas como la exportación de informes en PDF.
