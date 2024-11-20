import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:dio/dio.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServices();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final Dio client;
  ServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      // final result = await client.post(Environment.signUp,
      //     data: {
      //       'account': account,
      //       'name': name,
      //       'password': password,
      //       'birthdate': birthdate
      //     },
      //     options: Options(
      //         contentType: Headers.jsonContentType,
      //         validateStatus: (status) => status != null && status < 500));
      // final status = result.data['status'];
      // if (status == 'success') {
      //   return UserModel.fromJson(result.data['data']);
      // } else {
      //   throw ServerException(message: result.data['message']);
      // }

      return data.map<ServiceModel>((serviceData) {
        return ServiceModel.fromJson(serviceData);
      }).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }
}

// required super.id,
//       required super.name,
//       required super.category,
//       required super.proffesionals

List<Map<String, dynamic>> data = [
  {
    'id': '1',
    'name': 'Todos',
    'selected': true,
    'asset': 'assets/icon/logo.png',
    'subServices': null
  },
  {
    'id': '1',
    'name': 'Cabello',
    'selected': false,
    'asset': 'assets/img/cabello.png',
    'subServices': [
      {
        'id': '1',
        'name': 'Corte de puntas',
        'category': 'Corte de cabello',
        'urlImage':
            'https://saloniunpelodetonta.cl/wp-content/uploads/2020/10/03-interior-01.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Corte en capas',
        'category': 'Corte de cabello',
        'urlImage':
            'https://supersalon.com/wp-content/uploads/2023/10/corte-de-pelo-a-capas-largas-melena-xxl_d4161aad_1000x1500.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Corte estilo',
        'category': 'Corte de cabello',
        'urlImage':
            'https://i.pinimg.com/236x/9d/bb/35/9dbb357d0eb2e6f6fd5033b919d13419.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Corte con máquina',
        'category': 'Corte de cabello',
        'urlImage':
            'https://i.pinimg.com/736x/ae/da/4f/aeda4fe344b223d3f52efadcc743a1ae.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Corte con flequillo',
        'category': 'Corte de cabello',
        'urlImage':
            'https://i.pinimg.com/1200x/4c/b9/f3/4cb9f393773d2103528ac9dcbd81d340.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Corte de barba',
        'category': 'Corte de cabello',
        'urlImage':
            'https://i.pinimg.com/550x/f4/71/20/f471206f46adfd87bcc795c6acb8b81e.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Tinte completo',
        'category': 'Tinturado',
        'urlImage': '',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Mechas',
        'category': 'Tinturado',
        'urlImage':
            'https://i.pinimg.com/736x/65/a1/90/65a190aaf63023136a24ae8171c19566.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Balayage',
        'category': 'Tinturado',
        'urlImage':
            'https://i.pinimg.com/736x/38/61/d5/3861d5e7a603936beb05f43a7b3eff7a.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Corrección de color',
        'category': 'Tinturado',
        'urlImage':
            'https://www.thyms.co/images/Noticias_2021//repolarizacion-para-tu-cabello.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Babylights',
        'category': 'Tinturado',
        'urlImage':
            'https://i.pinimg.com/564x/a5/80/69/a58069290a010e8351f9714e6874ca31.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Decoloración',
        'category': 'Tinturado',
        'urlImage':
            'https://images.ctfassets.net/4ck2s8k0bkzh/1vqaEd2SKzygyELscERokM/c36a95f15f063ca4091b5ba845daba59/Mesa_de_trabajo_21.png',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Extensiones de cabello',
        'category': 'Extensiones y postizos',
        'urlImage':
            'https://i.pinimg.com/736x/77/0b/bf/770bbfe14182ec8e271fa5a090175680.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Colocación de pelucas',
        'category': 'Extensiones y postizos',
        'urlImage':
            'https://m.media-amazon.com/images/I/71Bi5r+32JL._AC_UF1000,1000_QL80_.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Volumen de postizos',
        'category': 'Extensiones y postizos',
        'urlImage': 'https://m.media-amazon.com/images/I/51yr+mFg4zL._AC_.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      },
      {
        'id': '1',
        'name': 'Retiro de extensiones',
        'category': 'Extensiones y postizos',
        'urlImage':
            'https://sevilla.abc.es/estilo/bulevarsur/wp-content/uploads/sites/14/2020/04/como-quitar-extensiones-cabello-casa.jpg',
        'proffesionals': [
          {'id': '1', 'name': 'Ana'},
          {'id': '1', 'name': 'Raquel'},
        ]
      }
    ]
  },
  {
    'id': '1',
    'name': 'Maquillaje',
    'selected': false,
    'asset': 'assets/img/maquillaje.png',
    'subServices': null
  },
  {
    'id': '1',
    'name': 'Uñas',
    'selected': false,
    'asset': 'assets/img/uñas.png',
    'subServices': null
  },
  {
    'id': '1',
    'name': 'Spa',
    'selected': false,
    'asset': 'assets/img/spa.png',
    'subServices': null
  },
];
