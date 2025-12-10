Construir una app Flutter que permita:

1. Consultar rápidamente la información de una o varias estaciones.

2. Visualizar estadísticas con dos tipos de gráficos distintos y con sentido práctico.

3. Exportar a PDF un informe completo de una estación “en un momento”.

Fuente de datos (obligatoria):

https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl/station_information

https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl/station_status


Requisitos funcionales

1) Pantalla principal: acceso rápido debe mostrar:

    • Estadísticas con gráficos de la estación favorita.

    • Una opción para ver detalles de otra estación o marcarla como favorita.


2) Detalle de estación debe mostrar:

    • Datos de la estación

    • Datos actualizados a: Hora de los últimos datos actualizados de la API

    • Datos de bicis disponibles, eléctricas disponibles, anclajes disponibles representados mediante gráficas tal y como se indica en el punto 3.

    • Un bloque de “¿Me compensa bajar ahora?” con una lógica simple y explicada (a elección del desarrollador) ejemplo:

        • “Sí” si hay ≥ 1 e-bike disponible.

        • “Quizá” si hay bicis mecánicas pero 0 e-bikes.

        • “No” si no hay bicis disponibles.


3) Gráficas (2 tipos distintos, con sentido) Ambos deben estar conectados a datos reales de los endpoints.

Ejemplo de propuestas válidas:

    Gráfico A (comparativo global):

        • Barras con el top N estaciones por:

        • e-bikes disponibles, o

        • bicis totales disponibles, o

        • porcentaje de ocupación.

    
    Gráfico B (estado de estación concreta):

        • Anillo/Pie mostrando distribución en esa estación:

        • e-bikes vs mecánicas,

        • anclajes libres a la redonda.


Regla clave:

    El gráfico debe aportar una decisión o lectura clara, no ser decorativo.


4) Exportación PDF. 

Desde la pantalla de detalle debes permitir:

    • Generar un PDF con toda la información de la estación en el momento actual:

    • Datos estáticos.

    • Estado actual.

    • Fecha/hora de generación.

    • Fecha/hora de actualización de los datos.


Requisitos técnicos obligatorios.

    • MVVM

    • Trabajo avanzando en el tiempo contra un repositorio de Github, en caso de que este requisito no se cumpla (por ejemplo, todo el código en 1 commit, todo el código en dos días, código claramente generado con IA generativa sin interacción del desarrollador, la práctica se considerará nula con una puntuación de 0)

    • Uso de fl_chart


Entregables

1. Repositorio con el proyecto que incluya un README breve con:

    • explicación del enfoque,

    • capturas,

    • justificación de las dos gráficas elegidas,

    • dependencias usadas (por ejemplo fl_chart, syncfusion_flutter_charts, pdf, printing, etc.).

2. Un PDF de ejemplo generado por la app.