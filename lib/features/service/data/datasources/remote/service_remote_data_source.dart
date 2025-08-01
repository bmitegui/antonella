import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/data/models/promotion_model.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/domain/entities/question_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/user/data/models/user_model.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:dio/dio.dart';

abstract class ServiceRemoteDataSource {
  Future<ListServicesModel> getServices();
  Future<List<NotificationModel>> getNotifications();
  Future<List<CommentModel>> getServiceComments({required String serviceId});
  Future<List<OrderModel>> getOrders({required String id});
  Future<void> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required Map<String, String> employeeIds,
      required List<ServiceEntity> services});
  Future<void> payOrder(
      {required String orderId, required PaymentType paymentType});
  Future<List<QuestionModel>> getFormDone(
      {required String clientId, required String serviceItemId});
  Future<void> startAppointment(
      {required String orderId, required String appointmentId});
  Future<void> endAppointment(
      {required String orderId, required String appointmentId});
  Future<List<PromotionEntity>> getPromotions();
}

class ServiceRemoteDataSourceImpl
    with RemoteRequestHelper
    implements ServiceRemoteDataSource {
  final Dio client;
  ServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<ListServicesModel> getServices() async {
    return await handleRequest(
        request: () =>
            client.get(Environment.storeService, options: defaultOptions),
        onSuccess: (data) => ListServicesModel.fromList(data));
  }

  Future<ServiceModel> getService({required String id}) async {
    final url = '${Environment.storeService}?id=$id';
    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) => ServiceModel.fromJson(data));
  }

  @override
  Future<List<CommentModel>> getServiceComments(
      {required String serviceId}) async {
    final url = '${Environment.comments}?service_id=$serviceId';
    final commentsData = await handleRequest(
      request: () => client.get(url, options: defaultOptions),
      onSuccess: (data) => data,
    );

    if (commentsData.isEmpty) {
      return [];
    }

    final List<CommentModel> comments = [];

    for (dynamic item in commentsData) {
      final userId = item['user_id'];
      final userModel = await getUser(userId: userId);
      final comment = CommentModel.fromJson(item, userModel);
      comments.add(comment);
    }

    return comments;
  }

  @override
  Future<void> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required Map<String, String> employeeIds,
      required List<ServiceEntity> services}) async {
    try {
      final orderId = await createOrder(clientId: clientId);
      for (ServiceEntity service in services) {
        final serviceItemId = await createCita(
            orderId: orderId,
            day: day,
            start: start,
            employeeId: employeeIds[service.id]!,
            serviceId: service.id);
        await Future.wait(service.questions.map((q) => answer(
            clientId: clientId, question: q, serviceItemId: serviceItemId)));
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  Future<String> createOrder({required String clientId}) async {
    final data = {
      "client_id": clientId,
      "status": {
        "payment_status": "PENDIENTE",
        "payment_type": "EFECTIVO",
        "progress_status": "PENDIENTE",
        "status": "NO_CONFIRMADO",
        "client_confirmed": "NO_CONFIRMADO"
      }
    };
    final String a = await handleRequest(
        request: () =>
            client.post(Environment.order, data: data, options: defaultOptions),
        onSuccess: (data) => data['id']);
    return a;
  }

  Future<String> createCita(
      {required String orderId,
      required String day,
      required String start,
      required String employeeId,
      required String serviceId}) async {
    final data = {
      "order_id": orderId,
      "date_info": {"day": day, "start": start},
      "payments": [
        {"employee_id": employeeId}
      ],
      "service_id": serviceId,
      "status": "PENDIENTE"
    };
    return await handleRequest(
        request: () => client.post(Environment.oderServiceItem,
            data: data, options: defaultOptions),
        onSuccess: (data) => data['id']);
  }

  Future<void> answer(
      {required String clientId,
      required QuestionEntity question,
      required String serviceItemId}) async {
    final answerData = question.inputType != InputType.image
        ? {"text": question.answer.toString()}
        : {"images": List<String>.from(question.answer)};
    final data = {
      "client_id": clientId,
      "question_id": question.id,
      "service_item_id": serviceItemId,
      "answer": answerData
    };
    return await handleRequest(
        request: () => client.post(Environment.answer,
            data: data, options: defaultOptions),
        onSuccess: (_) {});
  }

  Future<List<AppointmentModel>> getAppointments({required String id}) async {
    String keyData = 'client_id';
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated && userState.user.rol == Rol.empleado) {
      keyData = 'employee_id';
    }

    final rawAppointments = await handleRequest(
        request: () => client.post(Environment.getAppointments,
            data: {keyData: id}, options: defaultOptions),
        onSuccess: (data) => data['service_items']);
    if (rawAppointments is! List || rawAppointments.isEmpty) {
      return [];
    }

    final List<AppointmentModel> appointments = await Future.wait(
      rawAppointments.map<Future<AppointmentModel>>((appointmentData) async {
        final serviceId = appointmentData['service_id'] as String;
        final serviceModel = await getService(id: serviceId);
        return AppointmentModel.fromJson(appointmentData, serviceModel);
      }),
    );

    return appointments;
  }

  Future<OrderModel> getOrder(
      {required String orderId,
      required List<AppointmentModel> appointments}) async {
    final url = '${Environment.order}?id=$orderId';
    final orderJson = await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) => data);
    final clientId = orderJson['client_id'] as String;
    final userModel = await getUser(userId: clientId);
    return OrderModel.fromJson(orderJson, appointments, userModel);
  }

  Future<UserModel> getUser({required String userId}) async {
    final url = '${Environment.user}?user_id=$userId';
    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) => UserModel.fromJson(data));
  }

  @override
  Future<List<OrderModel>> getOrders({required String id}) async {
    final appointments = await getAppointments(id: id);

    final Map<String, List<AppointmentModel>> groupedByOrder = {};
    for (AppointmentModel appointment in appointments) {
      groupedByOrder.putIfAbsent(appointment.orderId, () => []);
      groupedByOrder[appointment.orderId]!.add(appointment);
    }

    // Crear lista de futuros
    final futures = groupedByOrder.entries.map((entry) async {
      final orderId = entry.key;
      final appointmentList = entry.value;
      return await getOrder(orderId: orderId, appointments: appointmentList);
    }).toList();

    // Esperar todas las órdenes
    final allOrders = await Future.wait(futures);

    // Filtrar las que tienen estado confirmado
    final confirmedOrders = allOrders
        .where((order) => order.orderStatus == OrderStatus.confirmado)
        .toList();
    return confirmedOrders;
  }

  @override
  Future<void> payOrder(
      {required String orderId, required PaymentType paymentType}) async {
    final url = '${Environment.order}?id=$orderId';
    final paymentTypeString = paymentTypeToString(paymentType);
    final data = {
      "id": orderId,
      "payment_type": paymentTypeString,
      "client_confirmed": "CONFIRMADO"
    };
    return await handleRequest(
        request: () => client.put(url, data: data, options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<List<QuestionModel>> getFormDone(
      {required String clientId, required String serviceItemId}) async {
    final url =
        '${Environment.answer}?client_id=$clientId&service_item_id=$serviceItemId';
    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) => (data as List)
            .map<QuestionModel>(
                (questionJson) => QuestionModel.fromJson(questionJson))
            .toList());
  }

  @override
  Future<void> startAppointment(
      {required String orderId, required String appointmentId}) async {
    await handleRequest(
        request: () => client.put(Environment.order,
            data: {"id": orderId, "progress_status": "EN_PROGRESO"},
            options: defaultOptions),
        onSuccess: (_) {});
    await handleRequest(
        request: () => client.put(Environment.oderServiceItem,
            data: {"id": appointmentId, "status": "EN_PROGRESO"},
            options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<void> endAppointment(
      {required String orderId, required String appointmentId}) async {
    await handleRequest(
        request: () => client.put(Environment.oderServiceItem,
            data: {"id": appointmentId, "status": "FINALIZADO"},
            options: defaultOptions),
        onSuccess: (_) {});
  }

  @override
  Future<List<PromotionModel>> getPromotions() async {
    return await handleRequest(
        request: () =>
            client.get(Environment.publicity, options: defaultOptions),
        onSuccess: (data) => (data as List)
            .map<PromotionModel>(
                (dataJson) => PromotionModel.fromJson(dataJson))
            .toList());
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    String userId = '';
    final userState = sl<UserBloc>().state;

    if (userState is UserAuthenticated) {
      userId = userState.user.id;
    }
    final url = '${Environment.notifications}?user_id=$userId';
    return await handleRequest(
        request: () => client.get(url, options: defaultOptions),
        onSuccess: (data) => (data as List)
            .map<NotificationModel>((notificationJson) =>
                NotificationModel.fromJson(notificationJson))
            .toList());
  }
}
