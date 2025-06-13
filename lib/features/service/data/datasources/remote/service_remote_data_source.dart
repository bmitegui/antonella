import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/error/error.dart';
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
      required ServiceEntity service});
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final Dio client;
  ServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<ListServicesModel> getServices() async {
    try {
      final result = await client.get(Environment.storeService,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        return ListServicesModel.fromJson(result.data);
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<List<CommentModel>> getServiceComments(
      {required String serviceId}) async {
    try {
      final serviceCommentsList = serviceComments;

      return serviceCommentsList['ServiceComments']
          .map<CommentModel>((commentData) {
        return CommentModel.fromJson(commentData);
      }).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> sendRequest(
      {required String clientId,
      required String day,
      required String start,
      required String employeeId,
      required ServiceEntity service}) async {
    try {
      final orderId = await createOrder(clientId: clientId);
      final serviceItemId = await createCita(
          orderId: orderId,
          day: day,
          start: start,
          employeeId: employeeId,
          serviceId: service.id);
      service.questions
          .map((question) async => await answer(
              clientId: clientId,
              question: question,
              serviceItemId: serviceItemId))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  Future<String> createOrder({required String clientId}) async {
    try {
      final data = {
        "client_id": clientId,
        "status": {
          "payment_status": "PENDIENTE",
          "payment_type": "EFECTIVO",
          "progress_status": "PENDIENTE",
          "status": "NO_CONFIRMADO"
        }
      };
      final result = await client.post(Environment.order,
          data: data,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        final data = result.data['data'];
        return data['id'];
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  Future<String> createCita(
      {required String orderId,
      required String day,
      required String start,
      required String employeeId,
      required String serviceId}) async {
    try {
      final data = {
        "order_id": orderId,
        "date_info": {"day": day, "start": start},
        "payments": [
          {"employee_id": employeeId}
        ],
        "service_id": serviceId,
        "status": "PENDIENTE"
      };
      final result = await client.post(Environment.oderServiceItem,
          data: data,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        final data = result.data['data'];
        return data['id'];
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  Future<void> answer(
      {required String clientId,
      required QuestionEntity question,
      required String serviceItemId}) async {
    try {
      final answer = question.inputType != InputType.image
          ? {"text": question.answer.toString()}
          : {"images": List<String>.from(question.answer)};
      final data = {
        "client_id": clientId,
        "question_id": question.id,
        "service_item_id": serviceItemId,
        "answer": answer
      };
      final result = await client.post(Environment.answer,
          data: data,
          options: Options(
              contentType: Headers.jsonContentType,
              validateStatus: (status) => status != null && status < 500));
      final status = result.data['status'];
      if (status == 'success') {
        return;
      } else {
        throw ServerException(message: result.data['message']);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }
}

final Map<String, dynamic> serviceComments = {
  'ServiceComments': [
    {
      'id': '1',
      'name': 'Raquel Miranda',
      'rating': 4.3,
      'dateTime': '2025-05-23',
      'urlImage':
          'https://i.pinimg.com/736x/50/8a/59/508a59707e76feb398bb22b2b62d288a.jpg',
      'comment':
          'La atención fue excelente desde que llegué. Me hicieron sentir bienvenida y cómoda en todo momento.'
    },
    {
      'id': '2',
      'name': 'Erick Ponce',
      'rating': 5.0,
      'dateTime': '2025-03-28',
      'urlImage':
          'https://media.istockphoto.com/id/1484631693/es/foto/retrato-de-un-joven-cauc%C3%A1sico-adolescente-de-18-o-19-a%C3%B1os-al-aire-libre.jpg?s=612x612&w=0&k=20&c=AH7f1geIm-toSuCSrU60UJdFh4L0VZf2zhUC5xPbb1o=',
      'comment':
          'Excelente servicio. Por supuesto que volvería a hacer este tratamiento, súper relajante.'
    },
    {
      'id': '3',
      'name': 'Brian Mite',
      'rating': 3.0,
      'dateTime': '2025-11-15',
      'urlImage':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4RlI1NcwS6Cc2dIjnwHEyaHLWV4kM5V2Pxw&s',
      'comment':
          'El personal fue muy amable y profesional. Respondieron todas mis preguntas con paciencia.'
    },
    {
      'id': '4',
      'name': 'Julia Barros',
      'rating': 2.2,
      'dateTime': '2025-12-12',
      'urlImage':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHrHeiz3WOP797ZDfz93xazEazycvre8RBWw&s',
      'comment':
          'Me encantó el trato que recibí. Se nota que les importa que el cliente salga satisfecho.'
    },
    {
      'id': '5',
      'name': 'Ana Perez',
      'rating': 0.0,
      'dateTime': '2025-05-23',
      'urlImage':
          'https://img.freepik.com/foto-gratis/mujer-hermosa-joven-mirando-camara-chica-moda-verano-casual-camiseta-blanca-pantalones-cortos-hembra-positiva-muestra-emociones-faciales-modelo-divertido-aislado-amarillo_158538-15796.jpg',
      'comment':
          'La atención al cliente fue rápida y eficiente. No tuve que esperar mucho para ser atendida.'
    }
  ]
};
