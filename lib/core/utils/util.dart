import 'dart:convert';
import 'dart:io';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/notification_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

double generarDoubleEntre35y50() {
  final random = Random();
  final value = 3.5 + random.nextDouble() * (5.0 - 3.5);
  return double.parse(value.toStringAsFixed(2));
}

String formatDateToString(DateTime date) {
  return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

String formatDurationToHours(String timeString) {
  final parts = timeString.split(':');
  if (parts.length != 3) return timeString; // En caso de formato incorrecto

  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);

  return '$hours:${minutes.toString().padLeft(2, '0')} hrs';
}

DateTime parseStringToDate(String dateString) {
  return DateTime.parse(dateString);
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu correo o teléfono';
  }
  final emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Por favor ingresa un correo válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu contraseña';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu nombre';
  }
  return null;
}

String? validateBirthdate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fecha faltante';
  }
  return null;
}

Future<File?> pickImage(ImageSource imageSource) async {
  final pickedImage =
      await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
  if (pickedImage == null) {
    return null;
  }
  return File(pickedImage.path);
}

String formatDateTime(DateTime? dateTime) =>
    dateTime == null ? 'yyyy-MM-dd' : DateFormat('yyyy-MM-dd').format(dateTime);

String formatHour(DateTime? dateTime) =>
    dateTime == null ? 'HH:mm' : DateFormat('HH:mm').format(dateTime);

String capitalize(String text) {
  if (text.trim().isEmpty) return text;

  final buffer = StringBuffer();
  bool capitalizeNext = true;

  for (int i = 0; i < text.length; i++) {
    final char = text[i];

    if (capitalizeNext && RegExp(r'[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]').hasMatch(char)) {
      buffer.write(char.toUpperCase());
      capitalizeNext = false;
    } else {
      buffer.write(char);
      if (char == '.' || char == '!' || char == '?' || char == '\n') {
        capitalizeNext = true;
      }
    }
  }

  return buffer.toString();
}

String getCategoryText(
    {required BuildContext context, required ServiceType serviceCategory}) {
  final texts = AppLocalizations.of(context)!;
  return (serviceCategory == ServiceType.hair)
      ? texts.hair
      : (serviceCategory == ServiceType.nails)
          ? texts.nails
          : (serviceCategory == ServiceType.spa)
              ? texts.spa
              : (serviceCategory == ServiceType.makeup)
                  ? texts.makeup
                  : texts.all;
}

String getCategoryTextList({
  required BuildContext context,
  required List<ServiceType> serviceCategories,
}) {
  final texts = AppLocalizations.of(context)!;
  final uniqueCategories = serviceCategories.toSet();
  final categoryTexts = uniqueCategories.map((category) {
    switch (category) {
      case ServiceType.hair:
        return texts.hair;
      case ServiceType.nails:
        return texts.nails;
      case ServiceType.spa:
        return texts.spa;
      case ServiceType.makeup:
        return texts.makeup;
      case ServiceType.all:
        return texts.all;
    }
  }).toList();

  return categoryTexts.join(', ');
}

double getTotalBasePrice(List<AppointmentEntity> appointments) {
  return appointments.fold(0.0, (sum, appointment) {
    return sum + (appointment.basePrice ?? 0.0);
  });
}

Future<DateTime?> selectDate(BuildContext context) async {
  final colorScheme = Theme.of(context).colorScheme;
  final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: colorScheme.brightness == Brightness.light
                    ? ColorScheme.light(
                        primary: colorScheme.primary,
                        onPrimary: colorScheme.onPrimary,
                        surface: colorScheme.surface,
                        onSurface: colorScheme.onSurface)
                    : ColorScheme.dark(
                        primary: colorScheme.primary,
                        onPrimary: colorScheme.onPrimary,
                        surface: colorScheme.surface,
                        onSurface: colorScheme.onSurface),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: colorScheme.primary))),
            child: child!);
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
  return picked;
}

void navigateWithSlideTransition(BuildContext context, Widget page) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          }));
}

Map<String, double> calculateTotals(List<ProductEntity> products) {
  final subtotal = products.fold<double>(0.0, (sum, item) => sum + item.price);
  final iva = subtotal * 0.15;
  final total = subtotal + iva;

  return {
    'subtotal': double.parse(subtotal.toStringAsFixed(2)),
    'iva': double.parse(iva.toStringAsFixed(2)),
    'total': double.parse(total.toStringAsFixed(2)),
  };
}

// Map<String, double> calculateTotals({
//   required List<ProductEntity> products,
//   required List<OrderEntity> orders,
//   required List<PromotionEntity> promotions,
// }) {
//   double subtotal = 0.0;

//   // Productos
//   subtotal += products.fold<double>(0.0, (sum, item) => sum + item.price);

//   // Servicios (órdenes)
//   for (final order in orders) {
//     subtotal += getTotalBasePrice(order.appointments); // Ya tienes esta función
//   }

//   // Promociones
//   for (final promo in promotions) {
//     for (final serviceItem in promo.serviceItems) {
//       final originalPrice = getServicePriceById(serviceItem.id); // Debes implementar esta función
//       final discountedPrice = originalPrice * (1 - serviceItem.discount);
//       subtotal += discountedPrice;
//     }
//   }

//   final iva = subtotal * 0.15;
//   final total = subtotal + iva;

//   return {
//     'subtotal': double.parse(subtotal.toStringAsFixed(2)),
//     'iva': double.parse(iva.toStringAsFixed(2)),
//     'total': double.parse(total.toStringAsFixed(2)),
//   };
// }

// double getServicePriceById(String serviceId) {
//   // Ejemplo estático (reemplaza con tu lógica real)
//   final allOrders = ...; // debes tener acceso a todas las órdenes o servicios
//   final service = allOrders
//       .expand((order) => order.appointments)
//       .firstWhere((a) => a.serviceEntity.id == serviceId, orElse: () => null);

//   if (service != null) {
//     return service.serviceEntity.price;
//   } else {
//     return 0.0;
//   }
// }

List<ProductEntity> getUniqueProducts(List<ProductEntity> products) {
  final uniqueMap = <String, ProductEntity>{};

  for (var product in products) {
    uniqueMap[product.id] = product;
  }

  return uniqueMap.values.toList();
}

int countProductsById({
  required List<ProductEntity> products,
  required String productId,
}) {
  return products.where((product) => product.id == productId).length;
}

Future<String?> convertFileToBase64(File? file) async {
  if (file == null) {
    return null;
  }

  final img.Image? originalImage = img.decodeImage(await file.readAsBytes());

  if (originalImage == null) return "";

  bool isPortrait = originalImage.height > originalImage.width;
  final Directory tempDir = await getTemporaryDirectory();
  final String targetPath = path.join(tempDir.path, "temp.jpg");

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 85,
    minWidth: isPortrait ? 768 : 1024,
    minHeight: isPortrait ? 1024 : 768,
  );
  if (result == null) return "";

  List<int> imageBytes = await result.readAsBytes();
  String imagenBase64 = base64Encode(imageBytes);
  var extFoto = result.path.split("/").last.split(".").last;
  imagenBase64 = "data:image/$extFoto;base64,$imagenBase64";
  return imagenBase64;
}

ServiceType stringToType(String type) {
  return type == 'SPA'
      ? ServiceType.spa
      : type == 'UÑAS'
          ? ServiceType.nails
          : type == 'CABELLO'
              ? ServiceType.hair
              : ServiceType.makeup;
}

MessageType stringToMessageType(String type) {
  return type == 'TEXT' ? MessageType.text : MessageType.image;
}

String messageTypeToString(MessageType type) {
  return type == MessageType.text ? 'TEXT' : 'IMAGE';
}

OrderStatus stringToOrderStatus(String status) {
  return status == 'CONFIRMADO'
      ? OrderStatus.confirmado
      : OrderStatus.noConfirmado;
}

ClientStatus stringToClientStatus(String status) {
  return status == 'CONFIRMADO'
      ? ClientStatus.confirmado
      : ClientStatus.noConfirmado;
}

PaymentType stringToPaymentType(String type) {
  return type == 'EFECTIVO' ? PaymentType.efectivo : PaymentType.tarjeta;
}

ServiceItemType stringToServiceItemType(String type) {
  return type == 'descuento'
      ? ServiceItemType.descuento
      : ServiceItemType.descuento;
}

NotificationType stringToNotificationType(String type) {
  return type == 'INSTANTANEA'
      ? NotificationType.instantanea
      : NotificationType.otro;
}

String paymentTypeToString(PaymentType type) {
  switch (type) {
    case PaymentType.efectivo:
      return 'EFECTIVO';
    case PaymentType.tarjeta:
      return 'TARJETA';
  }
}

PaymentStatus stringToPaymentStatus(String status) {
  return status == 'PENDIENTE' ? PaymentStatus.pendiente : PaymentStatus.pagado;
}

ProgressStatus stringToProgressStatus(String status) {
  return (status == 'PENDIENTE' || status == 'Pendientes')
      ? ProgressStatus.pendiente
      : (status == 'EN_PROGRESO' || status == 'En curso')
          ? ProgressStatus.enProgreso
          : ProgressStatus.finalizado;
}

ProductType stringToProductType(String type) {
  return type == 'SHAMPOO' ? ProductType.shampoo : ProductType.crema;
}

Map<String, String> obtenerRangoFechas(String tipo) {
  final ahora = DateTime.now();
  late DateTime startDate;
  late DateTime endDate;

  switch (tipo.toUpperCase()) {
    case 'SEMANAL':
      // Lunes es weekday = 1, Domingo = 7
      startDate = ahora.subtract(Duration(days: ahora.weekday - 1));
      endDate = ahora;
      break;

    case 'MENSUAL':
      startDate = DateTime(ahora.year, ahora.month, 1);
      endDate = ahora;
      break;

    case 'ANUAL':
      startDate = DateTime(ahora.year, 1, 1);
      endDate = ahora;
      break;

    default:
      // Lunes es weekday = 1, Domingo = 7
      startDate = ahora.subtract(Duration(days: ahora.weekday - 1));
      endDate = ahora;
      break;
  }

  final formatter = DateFormat('yyyy-MM-dd');
  return {
    'startDate': formatter.format(startDate),
    'endDate': formatter.format(endDate),
  };
}

String monthNameInSpanish(int month) {
  const months = [
    'ENERO',
    'FEBRERO',
    'MARZO',
    'ABRIL',
    'MAYO',
    'JUNIO',
    'JULIO',
    'AGOSTO',
    'SEPTIEMBRE',
    'OCTUBRE',
    'NOVIEMBRE',
    'DICIEMBRE'
  ];
  return months[month - 1];
}

Future<void> launchCustomUri(Uri uri,
    {LaunchMode mode = LaunchMode.externalApplication}) async {
  await launchUrl(uri, mode: mode);
}

Future<void> utilLaunchUrl({required String url}) async {
  final uri = Uri.parse(url);
  await launchCustomUri(uri);
}

Future<void> emailLaunch({required String emailAddress}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: emailAddress,
  );
  await launchCustomUri(uri);
}

Future<void> makePhoneCall({required String phoneNumber}) async {
  final uri = Uri(scheme: 'tel', path: phoneNumber);
  await launchCustomUri(uri);
}

Future<void> launchWhatsApp(
    {required String phoneNumber, required String message}) async {
  final uri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
  await launchCustomUri(uri);
}

List<Map<String, dynamic>> groupProducts(
    List<ProductEntity> products, String orderId) {
  final Map<String, Map<String, dynamic>> grouped = {};

  for (final product in products) {
    if (grouped.containsKey(product.id)) {
      grouped[product.id]!['quantity'] += 1;
    } else {
      grouped[product.id] = {
        'order_id': orderId,
        'product_id': product.id,
        'quantity': 1,
        'base_price': product.price,
      };
    }
  }

  return grouped.values.toList();
}

Future<bool> isNotificationPermissionGranted() async {
  final status = await Permission.notification.status;
  return status.isGranted;
}

Future<void> requestNotificationPermission(BuildContext context) async {
  final status = await Permission.notification.status;

  if (status.isDenied || status.isRestricted) {
    final result = await Permission.notification.request();

    if (result.isPermanentlyDenied) {
      // Llevar al usuario a configuración de la app
      openAppSettings();
    }
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

TextStyle bodyBlack54Style(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: colorScheme.onSecondaryContainer, fontWeight: FontWeight.bold);
}

TextStyle titleBlack54Style(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return Theme.of(context).textTheme.titleMedium!.copyWith(
      color: colorScheme.onSurfaceVariant, fontWeight: FontWeight.bold);
}

bool showIconCart() {
  final stateProduct = sl<ProductsSelectedBloc>().state;
  final productsEmpty = stateProduct is ProductsSelectedLoaded &&
      stateProduct.products.isNotEmpty;

  final stateOrder = sl<OrdersBloc>().state;

  final ordersToConfirmEmpty = stateOrder is OrdersLoaded &&
      stateOrder.orders
          .where((order) => order.clientStatus == ClientStatus.noConfirmado)
          .toList()
          .isNotEmpty;

  return productsEmpty || ordersToConfirmEmpty;
}
