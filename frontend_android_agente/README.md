# Proyecto Parqueate Bien

Este proyecto es una aplicación móvil para la gestión y consulta de reportes de vehículos mal estacionados, desarrollada utilizando Flutter.

## Funcionalidades

- **Inicio de Sesión:** Los usuarios pueden iniciar sesión con su nombre de usuario y contraseña.
- **Reporte de Vehículos:** Permite a los usuarios crear reportes de vehículos mal estacionados incluyendo fotos y ubicación.
- **Consulta de Placas:** Usuarios pueden consultar el estado y ubicación de un vehículo incautado ingresando su número de placa.
- **Mapa Integrado:** Utiliza Google Maps para mostrar la ubicación actual del vehículo reportado.

## Tecnologías Utilizadas

- **Flutter:** Framework principal para el desarrollo de la aplicación.
- **Google Maps:** Para la integración de mapas y geolocalización.
- **HTTP:** Para la comunicación con el backend de la API.
- **Bloc:** Para la gestión del estado de la aplicación.
- **Logger:** Para el registro y seguimiento de eventos en la aplicación.
- **Shared Preferences:** Para el almacenamiento local de datos como el token de autenticación.
- **ScreenUtil:** Para la adaptación de la interfaz de usuario a diferentes tamaños de pantalla.
- **Image Picker:** Para la captura de imágenes desde la cámara del dispositivo.
- **Geolocator:** Para la obtención de la ubicación del dispositivo.

## Instalación
    git clone https://github.com/tu-usuario/parqueate-bien.git
    cd parqueate-bien
#  Instalar dependencias:
   flutter pub get
#  Ejecutar la aplicación:
   flutter run

# Estructura del Proyecto

lib/: Carpeta principal que contiene el código fuente de la aplicación.
APIs/: Módulos para la comunicación con las APIs.
Bloc/: Gestión del estado con Bloc.
Controllers/: Controladores para manejar la lógica de la UI.
Handlers/: Manejadores para mostrar diálogos y otros componentes.
Models/: Modelos de datos utilizados en la aplicación.
Pages/: Páginas de la aplicación.
Widgets/: Widgets reutilizables.
Services/: Servicios para funcionalidades específicas como la geolocalización.

### Ver carpeta doc, para imagenes y app_agente_doc.pdf