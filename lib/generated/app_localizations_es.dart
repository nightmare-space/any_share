// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get common => 'Común';

  @override
  String get setting => 'Ajustes';

  @override
  String get downlaodPath => 'Ruta de descarga';

  @override
  String get autoDownload => 'Descarga automática';

  @override
  String get clipboardshare => 'Compartir portapapeles';

  @override
  String get messageNote => 'Vibrar al recibir un mensaje';

  @override
  String get aboutSpeedShare => 'Acerca de Speed Share';

  @override
  String get currenVersion => 'Versión actual';

  @override
  String get otherVersion => 'Descargar otra versión';

  @override
  String get downloadTip =>
      'SpeedShare también es compatible con Windows, macOS y Linux';

  @override
  String get lang => 'Idioma';

  @override
  String get chatWindow => 'Ventana de chat';

  @override
  String get developer => 'Desarrollador';

  @override
  String get openSource => 'Código abierto';

  @override
  String get inputConnect => 'Ingresar conexión';

  @override
  String get scan => 'Escanear código QR';

  @override
  String get log => 'Registro';

  @override
  String get theTermsOfService => 'Términos de servicio';

  @override
  String get privacyAgreement => 'Acuerdo de privacidad';

  @override
  String get qrTips => 'Deslice hacia un lado para cambiar de IP';

  @override
  String get ui => 'Diseñador de interfaz';

  @override
  String get recentFile => 'Archivos recientes';

  @override
  String get recentImg => 'Imágenes recientes';

  @override
  String get currentRoom => 'Sala de chat';

  @override
  String get remoteAccessFile => 'Archivo local de acceso remoto';

  @override
  String get remoteAccessDes =>
      'Puede administrar los archivos locales abriendo esta IP en el navegador.';

  @override
  String get directory => 'Directorio';

  @override
  String get unknownFile => 'Archivo desconocido';

  @override
  String get zip => 'Zip';

  @override
  String get doc => 'Documento';

  @override
  String get music => 'Música';

  @override
  String get video => 'Vídeo';

  @override
  String get image => 'Imagen';

  @override
  String get apk => 'Apk';

  @override
  String get appName => 'Speed Share';

  @override
  String headerNotice(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: 'have $number connected',
      zero: 'No devices connect',
    );
    return '$_temp0';
  }

  @override
  String get recentConnect => 'Conexión reciente';

  @override
  String get empty => 'Vacío';

  @override
  String get projectBoard => 'Panel de proyecto de la serie Nightmare';

  @override
  String get joinQQGroup =>
      'Unirse al grupo de retroalimentación de comunicación';

  @override
  String get changeLog => 'Registro de cambios';

  @override
  String get about => 'About Speed Share';

  @override
  String get chatWindowNotice =>
      'Actualmente no hay mensajes, haga clic para ver la lista de mensajes';

  @override
  String get enableFileClassification => 'Habilitar clasificación de archivos';

  @override
  String get classifyTips =>
      'Nota, después de que se active la clasificación de archivos, todos los archivos en la ruta de descarga se organizarán automáticamente';

  @override
  String get clearCache => 'Limpiar caché';

  @override
  String get clearSuccess => 'Éxito al limpiar';

  @override
  String cacheSize(num number) {
    String _temp0 = intl.Intl.pluralLogic(
      number,
      locale: localeName,
      other: 'Tamaño de caché actual ${number}MB',
    );
    return '$_temp0';
  }

  @override
  String get curCacheSize => 'Tamaño de caché actual';

  @override
  String get nightmare => 'Nightmare';

  @override
  String get enableWebServer => 'Habilitar servidor web';

  @override
  String get enableWebServerTips =>
      'Después de habilitar, puede acceder al archivo en la ruta de descarga a través del navegador';

  @override
  String get fileType => 'Correlación de archivos';

  @override
  String get select => 'Seleccionar';

  @override
  String get vipTips => 'Esta función requiere una membresía para usar';

  @override
  String get fileIsDownloading => 'El archivo se está descargando';

  @override
  String get fileDownloadSuccess => 'La descarga del archivo se ha completado';

  @override
  String get open => 'Abrir';

  @override
  String get close => 'Cerrar';

  @override
  String get sendFile => 'Enviar archivo';

  @override
  String get camera => 'Cámara';

  @override
  String get device => 'Dispositivos';

  @override
  String get uploadFile => 'Subir archivo';

  @override
  String get allDevices => 'Todos los dispositivos';

  @override
  String get systemManager => 'Desde el sistema';

  @override
  String get systemManagerTips =>
      'Utiliza el administrador de archivos del sistema';

  @override
  String get inlineManager =>
      'Desde el administrador de archivos de la aplicación';

  @override
  String get inlineManagerTips =>
      'Utiliza el administrador de archivos de la aplicación';

  @override
  String get new_line => 'Nueva línea';

  @override
  String get home => 'Inicio';

  @override
  String get join => 'Unirse';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get androidSAFTips =>
      'La arquitectura SAF de Android hará que seleccionar archivos desde la carpeta del sistema siempre copie uno, si usa el administrador de archivos incorporado de Speed Share, no aumentará el tamaño de la caché';

  @override
  String get fileManagerLocal => 'Administrador de archivos (local)';

  @override
  String get fileManager => 'Administrador de archivos';

  @override
  String get shareFileFailed => 'Error al compartir el archivo';

  @override
  String get dropFileTip =>
      'Suelta para compartir el archivo en la ventana compartida';

  @override
  String get inputAddressTip => 'Ingrese la dirección IP del dispositivo';

  @override
  String get copyed => 'Enlace copiado';

  @override
  String get cacheCleaned => 'Caché limpiada';

  @override
  String get exceptionOrcur => 'Ocurrió una excepción';

  @override
  String get clipboardCopy => 'Copiar al portapapeles';

  @override
  String get noIPFound => 'No se encontró ninguna IP';

  @override
  String get backAgainTip => 'Vuelve a salir de la aplicación';

  @override
  String tapToViewFile(Object deviceName) {
    return 'Toca para ver todos los archivos de $deviceName';
  }

  @override
  String get notifyBroswerTip =>
      'Se ha notificado al navegador que cargue el archivo';

  @override
  String get clipboard => 'Portapapeles';

  @override
  String get fileQRCode => 'Código QR del archivo';

  @override
  String get export => 'Exportar';

  @override
  String get openQQFail => 'Error al abrir QQ, compruebe si está instalado';

  @override
  String get needWSTip =>
      'Por favor, primero active el servidor web en la aplicación Speed Share';
}
