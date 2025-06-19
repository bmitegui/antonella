import 'package:antonella/core/constant/data_test_constant.dart';
import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/utils/remote_data_source_util.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/question_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:dio/dio.dart';

abstract class ServiceRemoteDataSource {
  Future<ListServicesModel> getServices();
  Future<List<CommentModel>> getServiceComments({required String serviceId});
  Future<void> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required String employeeId,
      required List<ServiceEntity> services});
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
        onSuccess: (data) => ListServicesModel.fromJson(data));
  }

  @override
  Future<List<CommentModel>> getServiceComments(
      {required String serviceId}) async {
    final serviceCommentsList = serviceComments;
    return (serviceCommentsList['ServiceComments'] as List)
        .map<CommentModel>((commentData) {
      return CommentModel.fromJson(commentData);
    }).toList();
  }

  @override
  Future<void> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required String employeeId,
      required List<ServiceEntity> services}) async {
    try {
      final orderId = await createOrder(clientId: clientId);
      for (ServiceEntity service in services) {
        final serviceItemId = await createCita(
            orderId: orderId,
            day: day,
            start: start,
            employeeId: employeeId,
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
        "status": "NO_CONFIRMADO"
      }
    };
    return await handleRequest(
        request: () =>
            client.post(Environment.order, data: data, options: defaultOptions),
        onSuccess: (data) => data['id']);
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
}
