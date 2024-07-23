# App Ciudadano

La App Ciudadano es una aplicación móvil diseñada para facilitar a los ciudadanos el registro y consulta de sus vehículos, así como la interacción con el sistema de retención vehicular del programa “Parquéate Bien”.

## Características

- **Inicio de Sesión**: Permite a los usuarios registrarse e iniciar sesión utilizando su cédula y contraseña.
- **Registro de Usuario y Vehículo**: Los ciudadanos pueden registrar su información personal y los detalles de sus vehículos.
- **Consulta de Vehículos**: Los usuarios pueden consultar si su vehículo ha sido incautado y ver detalles como la ubicación y fotos del vehículo retenido.
- **Chat de Soporte**: Proporciona una opción de chat para obtener asistencia inmediata.

## Tecnologías Utilizadas

- **Flutter**: Para el desarrollo de la interfaz de usuario.
- **Flutter Bloc**: Para la gestión del estado.
- **HTTP**: Para las solicitudes de red.
- **Shared Preferences**: Para el almacenamiento local de datos del usuario.

## Estructura del Proyecto

Estructura del Proyecto
lib/: Carpeta principal que contiene el código fuente de la aplicación.
APIs/: Módulos para la comunicación con las APIs.
Bloc/: Gestión del estado con Bloc.
Controllers/: Controladores para manejar la lógica de la UI.
Handlers/: Manejadores para mostrar diálogos y otros componentes.
Models/: Modelos de datos utilizados en la aplicación.
Pages/: Páginas de la aplicación.
Widgets/: Widgets reutilizables.
Services/: Servicios para funcionalidades específicas.
Pantallas de la Aplicación

## Descripción de Directorios

Api/: Contiene las clases que manejan las llamadas a las APIs.
Blocs/: Contiene los blocs y eventos/estados relacionados para la gestión del estado de la aplicación.
Controllers/: Contiene las clases controladoras que manejan la lógica de negocio.
Handlers/: Contiene los manejadores de diálogos y respuestas de usuario.
Models/: Contiene las definiciones de los modelos de datos utilizados en la aplicación.
Pages/: Contiene las distintas páginas o pantallas de la aplicación.
Widgets/: Contiene widgets personalizados reutilizables.

## instalación y Configuración
## Clonar el repositorio:
git clone https://github.com/tu-usuario/app-ciudadano.git
cd app-ciudadano
## Instalar dependencias:
flutter pub get
## Ejecutar la aplicación:

## Uso
Inicio de Sesión
 Ingresar la cédula y contraseña.
 Presionar el botón de "Iniciar Sesión".
## Registro de Usuario y Vehículo
Navegar a la página de registro.
Ingresar los datos personales y del vehículo.
Presionar el botón de "Registrar".
# Consulta de Vehículos
Navegar a la página de consulta de vehículos.
Seleccionar el número de placa.
Consultar los detalles del vehículo.

#  Pantallas de la Aplicación
#  1.Splash Screen
Pantalla de carga de la aplicación "Parquéate Bien".

#  2.Login Screen
Pantalla de inicio de sesión de la aplicación.

#  3.Registro de Usuario
Formulario de registro de nuevo usuario.

#  4.Registro de Vehículo
Formulario de registro de vehículo.

#  5.Pantalla Principal
Pantalla principal de bienvenida con opciones.

#  6.Consulta de Placas
Popup de selección de número de placa para consulta.

#  7.Detalles del Vehículo Retenido
Detalles del vehículo retenido.

#  8.Información del Reporte
Información detallada del reporte de retención vehicular.

.Ver carpeta doc, para imagenes y app_agente_doc.pdf

/*
-- =============================================
-- Author: Erick Daves Garcia Perez
-- Create date: 23/07/2024
-- Description:	APP_CIUDADANO_DEMO-ORIONTEK.
-- =============================================
*/