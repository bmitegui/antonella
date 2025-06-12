import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:dio/dio.dart';

abstract class ServiceRemoteDataSource {
  Future<ListServicesModel> getServices({required ServiceCategory? filter});
  Future<List<ServiceFormModel>> getListServiceForm(
      {required ServiceCategory category});
  Future<List<CommentModel>> getServiceComments({required String serviceId});
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final Dio client;
  ServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<ListServicesModel> getServices(
      {required ServiceCategory? filter}) async {
    try {
      final servicesData = (filter == null || filter == ServiceCategory.all)
          ? allServices
          : filter == ServiceCategory.makeup
              ? makeupServices
              : filter == ServiceCategory.hair
                  ? hairServices
                  : filter == ServiceCategory.nails
                      ? nailsServices
                      : spaServices;
      servicesData['categorySelected'] = filter ?? 'Todos';
      return ListServicesModel.fromJson(servicesData);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<List<ServiceFormModel>> getListServiceForm(
      {required ServiceCategory category}) async {
    try {
      final listServiceFormsData = category == ServiceCategory.makeup
          ? makeupServices
          : category == ServiceCategory.hair
              ? hairServiceForm
              : category == ServiceCategory.nails
                  ? nailsServiceForm
                  : spaServiceForm;

      return listServiceFormsData['ListServiceForms']
          .map<ServiceFormModel>((serviceFormData) {
        return ServiceFormModel.fromJson(serviceFormData);
      }).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
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

final Map<String, dynamic> nailsServiceForm = {
  'ListServiceForms': [
    {'id': '1', 'title': 'Fotos de sus uñas actuales', 'type': 'uploadPhotos'},
    {
      'id': '4',
      'title': '¿Tiene alguna condición en las uñas (hongos, debilidad, etc.)?',
      'type': 'isSelected'
    },
    {
      'id': '5',
      'title': '¿Tiene alergias a productos como geles o esmaltes?',
      'type': 'isSelected'
    },
    {
      'id': '6',
      'title': 'Describa sus preferencias o necesidades especiales',
      'type': 'input'
    },
    {
      'id': '7',
      'title': '¿Cuánto tiempo espera que dure el servicio?',
      'type': 'input'
    },
    {
      'id': '8',
      'title': 'Suba ejemplos o referencias de diseños que le gusten',
      'type': 'uploadPhotos'
    },
  ]
};

final Map<String, dynamic> spaServiceForm = {
  'ListServiceForms': [
    {
      'id': '1',
      'title': 'Fotos de su piel o área a tratar',
      'type': 'uploadPhotos'
    },
    {
      'id': '2',
      'title': 'Seleccione el tipo de tratamiento que desea',
      'type': 'selectPhotos',
      'urlPhotos': {
        'Relajación':
            'https://i.pinimg.com/736x/7f/e3/1c/7fe31c4f3e43d861f65333fd006a9536.jpg',
        'Facial':
            'https://nmbcosmetics.com/wp-content/uploads/2020/09/09-09-20-Beneficios-del-masaje-facial-C-Q10-Crema-de-Masaje-Firming09-09-20-Beneficios-del-masaje-facial-C-Q10-Crema-de-Masaje-Firming.jpg',
        'Reductivo':
            'https://cdn0.uncomo.com/es/posts/6/4/6/como_funciona_el_masaje_reductivo_24646_600_square.jpg'
      }
    },
    {
      'id': '3',
      'title': 'Seleccione el nivel de intensidad que prefiere',
      'type': 'selectPhotos',
      'urlPhotos': {
        'Suave':
            'https://img.freepik.com/fotos-premium/escena-spa-relajante-mujer-recibiendo-masaje-suave-iluminacion-flor-cabello-atmosfera-pacifica_621955-52285.jpg',
        'Moderado':
            'https://images.squarespace-cdn.com/content/v1/642c1d5a227d62555176db53/1680783484484-M899PF6JEHM28VDGZL6H/Masaje+a+4+manos+-+Luna+Healing+Spa+-+Banos+Ecuador.jpeg',
        'Intenso':
            'https://images.squarespace-cdn.com/content/v1/642c1d5a227d62555176db53/1680783472873-V9R5QAZVIEB59IDNDC4N/Masaje+relajante+-+Luna+Healing+Spa+-+Banos+Ecuador.jpeg?format=1000w'
      }
    },
    {
      'id': '4',
      'title': '¿Tiene alguna condición médica que debamos considerar?',
      'type': 'isSelected'
    },
    {
      'id': '5',
      'title': '¿Ha recibido algún tratamiento similar anteriormente?',
      'type': 'isSelected'
    },
    {
      'id': '6',
      'title': '¿Tiene alguna alergia o sensibilidad en la piel?',
      'type': 'input'
    },
    {
      'id': '7',
      'title': 'Observaciones adicionales sobre su estado de salud',
      'type': 'input'
    },
    {
      'id': '8',
      'title': 'Resultados esperados o áreas a priorizar',
      'type': 'uploadPhotos'
    },
  ]
};

final Map<String, dynamic> hairServiceForm = {
  'ListServiceForms': [
    {'id': '1', 'title': 'Fotos de su cabello', 'type': 'uploadPhotos'},
    {
      'id': '2',
      'title': 'Seleccione el tipo de cabello',
      'type': 'selectPhotos',
      'urlPhotos': {
        'Liso':
            'https://img.freepik.com/fotos-premium/mujer-modelo-detras-hermoso-cabello-largo-liso-tenido_769803-2816.jpg',
        'Ondulado':
            'https://st3.depositphotos.com/1750160/18836/i/450/depositphotos_188363186-stock-photo-girl-with-long-curly-hair.jpg',
        'Rizado':
            'https://i.pinimg.com/236x/c6/b2/90/c6b290295d4a730042aa1b4bf43cd3fa.jpg'
      }
    },
    {
      'id': '3',
      'title': 'Seleccione el largo de su cabello',
      'type': 'selectPhotos',
      'urlPhotos': {
        'Corto':
            'https://i.pinimg.com/564x/bf/f3/3d/bff33d718a416539850e186e4d4eaec5.jpg',
        'Mediano':
            'https://st2.depositphotos.com/7990700/48221/i/450/depositphotos_482213548-stock-photo-straight-hair-bleaching-process-look.jpg',
        'Largo':
            'https://img.freepik.com/fotos-premium/mujer-modelo-detras-hermoso-cabello-largo-liso-tenido_769803-2816.jpg'
      }
    },
    {
      'id': '4',
      'title': '¿Sufres de puntas abiertas o cabello reseco?',
      'type': 'isSelected'
    },
    {
      'id': '5',
      'title': '¿Se ha tinturado el cabello antes?',
      'type': 'isSelected'
    },
    {
      'id': '6',
      'title': '¿Tiene algún tipo de tratamiento reciente en su cabello?',
      'type': 'input'
    },
    {'id': '7', 'title': 'Observaciones', 'type': 'input'},
    {'id': '8', 'title': 'Resultados esperados', 'type': 'uploadPhotos'},
  ]
};

final Map<String, dynamic> hours = {
  'Mañana': [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM"
  ],
  'Tarde': [
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM"
  ],
  'Noche': ["06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM", "08:00 PM"]
};

Map<String, dynamic> allServices = {
  'services': [
    {
      'id': '31',
      'name': 'Hidratante',
      'description':
          'Tratamiento diseñado para restaurar la humedad y suavidad natural de la piel, dejándola radiante y saludable.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
        'https://rusinol.com/wp-content/uploads/Precio-de-un-tratamiento-de-hidratacion-facial.jpg',
        'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial-2.png'
      ],
      'minPrice': 50.0,
      'maxPrice': 80.0,
      'duration': '45',
      'rating': 4.3
    },
    {
      'id': '32',
      'name': 'Anti edad',
      'description':
          'Reduce líneas finas y arrugas, proporcionando firmeza y una apariencia rejuvenecida.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://maison-spa.com/wp-content/uploads/2024/05/STOCK-PHOTOS-1-1-9.png'
      ],
      'minPrice': 60.0,
      'maxPrice': 100.0,
      'duration': '50',
      'rating': 4.8
    },
    {
      'id': '33',
      'name': 'Purificante',
      'description':
          'Limpieza profunda que elimina impurezas, ideal para pieles grasas o con tendencia al acné.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://applications-media.feverup.com/image/upload/f_auto,w_550,h_550/fever2/plan/photo/dae35b46-4f7a-11e8-9000-067dfd978c4d.jpg'
      ],
      'minPrice': 55.0,
      'maxPrice': 85.0,
      'duration': '35',
      'rating': 3.8
    },
    {
      'id': '34',
      'name': 'Reafirmante',
      'description':
          'Ayuda a mejorar la elasticidad y firmeza de la piel, dándole un aspecto más tonificado.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://aurumwellbeing.com/wp-content/uploads/2022/05/Masaje-facial-reafirmante-lifting.jpg'
      ],
      'minPrice': 65.0,
      'maxPrice': 90.0,
      'duration': '40',
      'rating': 4.0
    },
    {
      'id': '35',
      'name': 'Aclarante',
      'description':
          'Reduce manchas e iguala el tono de la piel, devolviendo su luminosidad natural.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://lh4.googleusercontent.com/proxy/UgjcLEvPXROO0j8ZZJ_p9tS_8mBbt3Ijjp6A0qpm_OG4-AIL6wVESiZZSmcd2gFQ2FhX-6zjkQSgXmU2SyRnX8KJ4fho_0uGZhsCrjR3MgKpZDEs7Az3M9El-MlnybLa-1nJRv9cVmACqFWn'
      ],
      'minPrice': 70.0,
      'maxPrice': 95.0,
      'duration': '27',
      'rating': 5.0
    },
    {
      'id': '36',
      'name': 'Cuerpo completo',
      'description':
          'Masaje integral para liberar tensión muscular y promover una relajación total.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://alzentro.com/wp-content/uploads/2019/01/As%C3%AD-te-ayudar%C3%A1n-los-masajes-relajantes-de-cuerpo-entero-1080x675.jpg'
      ],
      'minPrice': 100.0,
      'maxPrice': 150.0,
      'duration': '48',
      'rating': 3.6
    },
    {
      'id': '37',
      'name': 'Pies',
      'description':
          'Masaje especializado para aliviar el cansancio y revitalizar los pies.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://www.esteticalink.com/wp-content/uploads/2017/04/masaje-pies.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 50.0,
      'duration': '50',
      'rating': 4.2
    },
    {
      'id': '38',
      'name': 'Espalda y cuello',
      'description':
          'Relaja los músculos tensos del cuello y la espalda, ideal para quienes trabajan muchas horas sentados.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://terapiasderelajacionmedellin.com/wp-content/uploads/2023/02/MASAJE-DE-CUELLO-Y-ESPALDA.jpeg'
      ],
      'minPrice': 40.0,
      'maxPrice': 70.0,
      'duration': '36',
      'rating': 5.0
    },
    {
      'id': '39',
      'name': 'Piedras calientes',
      'description':
          'Utiliza piedras calientes para aliviar tensiones y mejorar la circulación sanguínea.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://36580daefdd0e4c6740b-4fe617358557d0f7b1aac6516479e176.ssl.cf1.rackcdn.com/products/26356.30575.jpg'
      ],
      'minPrice': 80.0,
      'maxPrice': 120.0,
      'duration': '35',
      'rating': 4.8
    },
    {
      'id': '40.0',
      'name': 'Aromaterapia',
      'description':
          'Combina masajes suaves con aceites esenciales para una experiencia sensorial relajante.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://www.mylottush.com/cdn/shop/articles/masaje_2bf887b0-a435-4959-90f2-03ad3e3311d0_1500x.jpg?v=1691023195'
      ],
      'minPrice': 60.0,
      'maxPrice': 90.0,
      'duration': '42',
      'rating': 4.6
    },
    {
      'id': '41',
      'name': 'Exfolación corporal',
      'description':
          'Elimina células muertas para dejar la piel suave, luminosa y renovada.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_F4WdMj8xG9oMC7jyRGzpZELvwp6r4wPVAA&s'
      ],
      'minPrice': 70.0,
      'maxPrice': 110.0,
      'duration': '35',
      'rating': 4.4
    },
    {
      'id': '42',
      'name': 'Envoltura corporal',
      'description':
          'Hidrata profundamente y detoxifica la piel, utilizando ingredientes naturales.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1fjY8d02EmENLC_kp825mI__lGY9PLGdxtA&s'
      ],
      'minPrice': 75.0,
      'maxPrice': 115.0,
      'duration': '20',
      'rating': 4.1
    },
    {
      'id': '43',
      'name': 'Tratamiento anti celulitis',
      'description':
          'Mejora la apariencia de la piel con técnicas para reducir la celulitis.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmscnIoLD-hzdlWHhdqENTpoHN1Qcql0KqLw&s'
      ],
      'minPrice': 85.0,
      'maxPrice': 130.0,
      'duration': '45',
      'rating': 4.3
    },
    {
      'id': '44',
      'name': 'Masaje reductor',
      'description':
          'Ayuda a moldear la figura mediante técnicas de masaje focalizadas.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGZqXHttk3UPvezH7Imd6xm8D_pbswaK9p9w&s'
      ],
      'minPrice': 90.0,
      'maxPrice': 140.0,
      'duration': '40',
      'rating': 4.8
    },
    {
      'id': '15',
      'name': 'Corte de puntas',
      'description':
          'Mantén tu cabello sano eliminando puntas abiertas sin sacrificar el largo.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://imagenes.elpais.com/resizer/v2/CZKQQ4VB7NIEVH7LOHB3N4NRRI.jpg?auth=69135426f9fa4930e1c38426ca5d79b198f3b38d8077dc6efd8502117ad05e22&width=1960&height=1103&smart=true'
      ],
      'minPrice': 10.0,
      'maxPrice': 20.0,
      'duration': '30',
      'rating': 4.8
    },
    {
      'id': '16',
      'name': 'Corte en capas',
      'description':
          'Da volumen y movimiento a tu cabello con un corte dinámico y estilizado.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://prixz.com/salud/wp-content/uploads/2021/05/abello-le-queda-un-corte-en-capas-1.jpg'
      ],
      'minPrice': 15.0,
      'maxPrice': 25.0,
      'duration': '35',
      'rating': 4.8
    },
    {
      'id': '17',
      'name': 'Corte estilo',
      'description':
          'Personaliza tu look con un corte único que se adapte a tu personalidad.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://www.garnier.es/-/media/project/loreal/brand-sites/garnier/emea/es/posts/678-corte-pelo-mariposa.jpg?rev=44bccafb6987483d8a291ff91e1ecf62&h=488&w=678&la=es-ES&hash=6ED6033224C673A0830E85AC30E60D73'
      ],
      'minPrice': 20.0,
      'maxPrice': 30.0,
      'duration': '30',
      'rating': 3.8
    },
    {
      'id': '18',
      'name': 'Corte con máquina',
      'description':
          'Ideal para un acabado rápido y preciso, perfecto para estilos más cortos.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://img.freepik.com/fotos-premium/maquina-corte-pelo-hombres-cabello-hombres-ayuda-tijeras_158388-589.jpg?w=360'
      ],
      'minPrice': 8.0,
      'maxPrice': 15.0,
      'duration': '44',
      'rating': 4.4
    },
    {
      'id': '19',
      'name': 'Corte con flequillo',
      'description':
          'Agrega un toque moderno y juvenil con un flequillo que realza tu rostro.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://i.pinimg.com/1200x/4c/b9/f3/4cb9f393773d2103528ac9dcbd81d340.jpg'
      ],
      'minPrice': 12.0,
      'maxPrice': 18.0,
      'duration': '58',
      'rating': 4.8
    },
    {
      'id': '20.0',
      'name': 'Corte de barba',
      'description':
          'Dale forma y definición a tu barba con un corte profesional y cuidado.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://i.pinimg.com/236x/80/2b/1d/802b1d0ec61e803d9b521816a906f0dc.jpg'
      ],
      'minPrice': 10.0,
      'maxPrice': 20.0,
      'duration': '30',
      'rating': 4.4
    },
    {
      'id': '21',
      'name': 'Tinte completo',
      'description':
          'Cambia el color de tu cabello completamente con tonos vibrantes o naturales.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://tahecosmetics.com/trends/wp-content/uploads/2021/12/tipos-tintes.jpeg'
      ],
      'minPrice': 30.0,
      'maxPrice': 50.0,
      'duration': '32',
      'rating': 4.8
    },
    {
      'id': '22',
      'name': 'Mechas',
      'description':
          'Agrega luminosidad y dimensión a tu cabello con mechas bien definidas.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://www.okchicas.com/wp-content/uploads/2021/04/Formas-llevar-mechas-platinadas-10.jpg'
      ],
      'minPrice': 35.0,
      'maxPrice': 60.0,
      'duration': '34',
      'rating': 4.4
    },
    {
      'id': '23',
      'name': 'Balayage',
      'description':
          'Un degradado natural que ilumina tu cabello de forma sutil y elegante.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://www.wella.com/professional/m/trendshub/Balayage_hair_article/wellaproblogbalayageguideimage6_d.jpg'
      ],
      'minPrice': 50.0,
      'maxPrice': 100.0,
      'duration': '30',
      'rating': 4.3
    },
    {
      'id': '24',
      'name': 'Corrección de color',
      'description':
          'Soluciona problemas de color no deseados para lograr un tono perfecto.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://rogelaineimagen.com/wp-content/uploads/2018/05/Foto-como-vino-la-1-vez.jpg'
      ],
      'minPrice': 40.0,
      'maxPrice': 80.0,
      'duration': '38',
      'rating': 4.8
    },
    {
      'id': '25',
      'name': 'Babylights',
      'description':
          'Luce reflejos suaves y naturales que imitan el efecto del sol en tu cabello.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://content.clara.es/medio/2022/09/06/shadowroot-balayage_d98be8af_1080x1351.jpg'
      ],
      'minPrice': 45.0,
      'maxPrice': 90.0,
      'duration': '36',
      'rating': 4.5
    },
    {
      'id': '26',
      'name': 'Decoloración',
      'description':
          'Aclara tu cabello para lograr el tono deseado o como preparación para tintes.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://st4allthings4p4ci.blob.core.windows.net/allthingshair/allthingshair/wp-content/uploads/sites/13/2023/05/43767/como-decolorar-el-cabello-377x566.jpg'
      ],
      'minPrice': 25.0,
      'maxPrice': 50.0,
      'duration': '32',
      'rating': 4.8
    },
    {
      'id': '27',
      'name': 'Extensiones de cabello',
      'description':
          'Agrega longitud y volumen de manera natural con extensiones personalizadas.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLbnn0DosBqAM92NvqfErLoFwlukywxeDBMw&s'
      ],
      'minPrice': 100.0,
      'maxPrice': 200.0,
      'duration': '30',
      'rating': 4.2
    },
    {
      'id': '28',
      'name': 'Colocación de pelucas',
      'description':
          'Obtén un cambio de look instantáneo con pelucas ajustadas a la perfección.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA2ompfYd_SlUezKf95FoHE-n6THwxerceGA&s'
      ],
      'minPrice': 50.0,
      'maxPrice': 150.0,
      'duration': '35',
      'rating': 4.5
    },
    {
      'id': '29',
      'name': 'Volumen de postizos',
      'description':
          'Mejora la densidad de tu cabello con postizos que se integran naturalmente.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://pelucasypostizosvalencia.com/wp-content/uploads/2019/07/extensiones-clip-baratas-para-el-cabello.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 70.0,
      'duration': '35',
      'rating': 4.2
    },
    {
      'id': '30.0',
      'name': 'Retiro de extensiones',
      'description':
          'Retira tus extensiones de manera segura sin dañar tu cabello natural.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://sevilla.abc.es/estilo/bulevarsur/wp-content/uploads/sites/14/2020/04/como-quitar-extensiones-cabello-casa.jpg'
      ],
      'minPrice': 15.0,
      'maxPrice': 30.0,
      'duration': '30',
      'rating': 4.8
    },
    {
      'id': '1',
      'name': 'Manicure clásico',
      'description':
          'Cuida y embellece tus manos con un tratamiento básico que incluye limado y esmalte.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://semilac.pl/media/webp_image/catalog/product/cache/73595e8c109d812957f8a30f638a0cef/s/t/stylizacja_210_jpg.webp'
      ],
      'minPrice': 10.0,
      'maxPrice': 15.0,
      'duration': '130',
      'rating': 4.9
    },
    {
      'id': '2',
      'name': 'Manicure spa',
      'description':
          'Disfruta de una experiencia relajante con exfoliación, masaje y esmalte de alta calidad.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFfQVCRvyjIkT3988_To9Wg03bNwNYFGMEaw&s'
      ],
      'minPrice': 20.0,
      'maxPrice': 30.0,
      'duration': '30',
      'rating': 4.3
    },
    {
      'id': '3',
      'name': 'Manicure francés',
      'description':
          'Luce elegante y sofisticada con la icónica técnica de diseño francés.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4YHVZcndQdYHZGuKCXcl7s5u0LDYPywXDvg&s'
      ],
      'minPrice': 15.0,
      'maxPrice': 25.0,
      'duration': '30',
      'rating': 4.8
    },
    {
      'id': '4',
      'name': 'Manicure semi permanente',
      'description':
          'Obtén un acabado brillante y duradero con esmalte de larga duración.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://i.pinimg.com/originals/4a/a6/e7/4aa6e7e4738a67c46066fdb7ce25069f.jpg'
      ],
      'minPrice': 18.0,
      'maxPrice': 28.0,
      'duration': '32',
      'rating': 4.2
    },
    {
      'id': '5',
      'name': 'Manicure con decoración',
      'description': 'Personaliza tus uñas con diseños artísticos y creativos.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://i.pinimg.com/736x/06/23/59/06235959496a3d3adddcc24a993ea10e.jpg'
      ],
      'minPrice': 25.0,
      'maxPrice': 40.0,
      'duration': '30',
      'rating': 5.0
    },
    {
      'id': '6',
      'name': 'Manicure con uñas encapsuladas',
      'description':
          'Dale un toque único a tus uñas con decoraciones encapsuladas bajo una capa de gel.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://i.pinimg.com/736x/71/d4/e7/71d4e762a361f50719aaf37e97637d91.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 50.0,
      'duration': '35',
      'rating': 4.9
    },
    {
      'id': '7',
      'name': 'Pedicure clásico',
      'description':
          'Consiente tus pies con un tratamiento básico que incluye limpieza, limado y esmalte.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://www.veronicacanas.com/cdn/shop/products/PEDICURE_95d0e7f4-4fb6-4b25-a44d-5a2652c29a7d.jpg?v=1620620258'
      ],
      'minPrice': 15.0,
      'maxPrice': 20.0,
      'duration': '37',
      'rating': 4.7
    },
    {
      'id': '8',
      'name': 'Pedicure spa',
      'description':
          'Relájate con un tratamiento completo que incluye exfoliación, masaje y cuidado de tus pies.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlMsetiPX3zM5u4qXt0WsYpvsyj22QxnPQmQ&s'
      ],
      'minPrice': 25.0,
      'maxPrice': 35.0,
      'duration': '30',
      'rating': 4.3
    },
    {
      'id': '9',
      'name': 'Pedicure con gel',
      'description':
          'Disfruta de un acabado brillante y duradero con esmalte en gel.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://i.pinimg.com/474x/06/d2/80/06d280620ca4e74055aba916e872b725.jpg'
      ],
      'minPrice': 20.0,
      'maxPrice': 30.0,
      'duration': '32',
      'rating': 4.1
    },
    {
      'id': '10',
      'name': 'Pedicure con acrílico',
      'description':
          'Refuerza y embellece tus uñas de los pies con acrílico duradero.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://i.pinimg.com/736x/6c/ca/3e/6cca3e59dbaead505db5ab9cd3cb43b8.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 45.0,
      'duration': '50',
      'rating': 4.5
    },
    {
      'id': '11',
      'name': 'Pedicure para eventos',
      'description':
          'Luce pies perfectos y listos para cualquier ocasión especial.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://i.pinimg.com/originals/ea/03/c1/ea03c1111bcfeab10bd0b86a02567afc.jpg'
      ],
      'minPrice': 20.0,
      'maxPrice': 35.0,
      'duration': '20',
      'rating': 4.2
    },
    {
      'id': '12',
      'name': 'Uñas acrílicas clásicas',
      'description': 'Obtén uñas fuertes y elegantes con un acabado clásico.',
      'category': 'Uñas',
      'subCategory': 'Uñas acrílicas',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsz7MgYTssp69TqmR8rUEaEPcQlTZayb1ZNQ&s'
      ],
      'minPrice': 40.0,
      'maxPrice': 55.0,
      'duration': '50',
      'rating': 4.2
    },
    {
      'id': '13',
      'name': 'Uñas acrílicas con decoración',
      'description':
          'Personaliza tus uñas acrílicas con diseños únicos y llamativos.',
      'category': 'Uñas',
      'subCategory': 'Uñas acrílicas',
      'urlImages': [
        'https://i.pinimg.com/originals/4c/e2/51/4ce251e7228db7640ad94f78ee0493e5.jpg'
      ],
      'minPrice': 50.0,
      'maxPrice': 70.0,
      'duration': '60',
      'rating': 4.8
    },
    {
      'id': '14',
      'name': 'Uñas acrílicas french',
      'description':
          'Combina elegancia y durabilidad con uñas acrílicas en estilo francés.',
      'category': 'Uñas',
      'subCategory': 'Uñas acrílicas',
      'urlImages': [
        'https://i.pinimg.com/736x/cb/bf/bd/cbbfbdce98a73ef69addd77ba516878e.jpg'
      ],
      'minPrice': 45.0,
      'maxPrice': 60.0,
      'duration': '30',
      'rating': 3.8
    },
  ],
  'subCategories': [
    'Tratamientos faciales',
    'Masajes relajantes',
    'Tratamientos corporales',
    'Corte de cabello',
    'Tinturado',
    'Extensiones y postizos',
    'Manicure',
    'Pedicure',
    'Uñas acrílicas'
  ]
};

Map<String, dynamic> spaServices = {
  'services': [
    {
      'id': '31',
      'name': 'Hidratante',
      'description':
          'Tratamiento diseñado para restaurar la humedad y suavidad natural de la piel, dejándola radiante y saludable.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
        'https://rusinol.com/wp-content/uploads/Precio-de-un-tratamiento-de-hidratacion-facial.jpg',
        'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial-2.png'
      ],
      'minPrice': 50.0,
      'maxPrice': 80.0,
      'duration': '30',
      'rating': 4.2
    },
    {
      'id': '32',
      'name': 'Anti edad',
      'description':
          'Reduce líneas finas y arrugas, proporcionando firmeza y una apariencia rejuvenecida.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://maison-spa.com/wp-content/uploads/2024/05/STOCK-PHOTOS-1-1-9.png'
      ],
      'minPrice': 60.0,
      'maxPrice': 100.0,
      'duration': '32',
      'rating': 4.8
    },
    {
      'id': '33',
      'name': 'Purificante',
      'description':
          'Limpieza profunda que elimina impurezas, ideal para pieles grasas o con tendencia al acné.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://applications-media.feverup.com/image/upload/f_auto,w_550,h_550/fever2/plan/photo/dae35b46-4f7a-11e8-9000-067dfd978c4d.jpg'
      ],
      'minPrice': 55.0,
      'maxPrice': 85.0,
      'duration': '30',
      'rating': 4.4
    },
    {
      'id': '34',
      'name': 'Reafirmante',
      'description':
          'Ayuda a mejorar la elasticidad y firmeza de la piel, dándole un aspecto más tonificado.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://aurumwellbeing.com/wp-content/uploads/2022/05/Masaje-facial-reafirmante-lifting.jpg'
      ],
      'minPrice': 65.0,
      'maxPrice': 90.0,
      'duration': '90',
      'rating': 4.8
    },
    {
      'id': '35',
      'name': 'Aclarante',
      'description':
          'Reduce manchas e iguala el tono de la piel, devolviendo su luminosidad natural.',
      'category': 'Spa',
      'subCategory': 'Tratamientos faciales',
      'urlImages': [
        'https://lh4.googleusercontent.com/proxy/UgjcLEvPXROO0j8ZZJ_p9tS_8mBbt3Ijjp6A0qpm_OG4-AIL6wVESiZZSmcd2gFQ2FhX-6zjkQSgXmU2SyRnX8KJ4fho_0uGZhsCrjR3MgKpZDEs7Az3M9El-MlnybLa-1nJRv9cVmACqFWn'
      ],
      'minPrice': 70.0,
      'maxPrice': 95.0,
      'duration': '30',
      'rating': 4.7
    },
    {
      'id': '36',
      'name': 'Cuerpo completo',
      'description':
          'Masaje integral para liberar tensión muscular y promover una relajación total.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://alzentro.com/wp-content/uploads/2019/01/As%C3%AD-te-ayudar%C3%A1n-los-masajes-relajantes-de-cuerpo-entero-1080x675.jpg'
      ],
      'minPrice': 100.0,
      'maxPrice': 150.0,
      'duration': '120',
      'rating': 4.2
    },
    {
      'id': '37',
      'name': 'Pies',
      'description':
          'Masaje especializado para aliviar el cansancio y revitalizar los pies.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://www.esteticalink.com/wp-content/uploads/2017/04/masaje-pies.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 50.0,
      'duration': '50',
      'rating': 4.5
    },
    {
      'id': '38',
      'name': 'Espalda y cuello',
      'description':
          'Relaja los músculos tensos del cuello y la espalda, ideal para quienes trabajan muchas horas sentados.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://terapiasderelajacionmedellin.com/wp-content/uploads/2023/02/MASAJE-DE-CUELLO-Y-ESPALDA.jpeg'
      ],
      'minPrice': 40.0,
      'maxPrice': 70.0,
      'duration': '40',
      'rating': 4.9
    },
    {
      'id': '39',
      'name': 'Piedras calientes',
      'description':
          'Utiliza piedras calientes para aliviar tensiones y mejorar la circulación sanguínea.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://36580daefdd0e4c6740b-4fe617358557d0f7b1aac6516479e176.ssl.cf1.rackcdn.com/products/26356.30575.jpg'
      ],
      'minPrice': 80.0,
      'maxPrice': 120.0,
      'duration': '80',
      'rating': 4.7
    },
    {
      'id': '40.0',
      'name': 'Aromaterapia',
      'description':
          'Combina masajes suaves con aceites esenciales para una experiencia sensorial relajante.',
      'category': 'Spa',
      'subCategory': 'Masajes relajantes',
      'urlImages': [
        'https://www.mylottush.com/cdn/shop/articles/masaje_2bf887b0-a435-4959-90f2-03ad3e3311d0_1500x.jpg?v=1691023195'
      ],
      'minPrice': 60.0,
      'maxPrice': 90.0,
      'duration': '60',
      'rating': 4.0
    },
    {
      'id': '41',
      'name': 'Exfolación corporal',
      'description':
          'Elimina células muertas para dejar la piel suave, luminosa y renovada.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_F4WdMj8xG9oMC7jyRGzpZELvwp6r4wPVAA&s'
      ],
      'minPrice': 70.0,
      'maxPrice': 110.0,
      'duration': '70',
      'rating': 3.8
    },
    {
      'id': '42',
      'name': 'Envoltura corporal',
      'description':
          'Hidrata profundamente y detoxifica la piel, utilizando ingredientes naturales.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1fjY8d02EmENLC_kp825mI__lGY9PLGdxtA&s'
      ],
      'minPrice': 75.0,
      'maxPrice': 115.0,
      'duration': '75',
      'rating': 4.9
    },
    {
      'id': '43',
      'name': 'Tratamiento anti celulitis',
      'description':
          'Mejora la apariencia de la piel con técnicas para reducir la celulitis.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmscnIoLD-hzdlWHhdqENTpoHN1Qcql0KqLw&s'
      ],
      'minPrice': 85.0,
      'maxPrice': 130.0,
      'duration': '130',
      'rating': 4.2
    },
    {
      'id': '44',
      'name': 'Masaje reductor',
      'description':
          'Ayuda a moldear la figura mediante técnicas de masaje focalizadas.',
      'category': 'Spa',
      'subCategory': 'Tratamientos corporales',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGZqXHttk3UPvezH7Imd6xm8D_pbswaK9p9w&s'
      ],
      'minPrice': 90.0,
      'maxPrice': 140.0,
      'duration': '30',
      'rating': 4.8
    },
  ],
  'subCategories': [
    'Tratamientos faciales',
    'Masajes relajantes',
    'Tratamientos corporales'
  ]
};

Map<String, dynamic> hairServices = {
  'services': [
    {
      'id': '15',
      'name': 'Corte de puntas',
      'description':
          'Mantén tu cabello sano eliminando puntas abiertas sin sacrificar el largo.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://imagenes.elpais.com/resizer/v2/CZKQQ4VB7NIEVH7LOHB3N4NRRI.jpg?auth=69135426f9fa4930e1c38426ca5d79b198f3b38d8077dc6efd8502117ad05e22&width=1960&height=1103&smart=true'
      ],
      'minPrice': 10.0,
      'maxPrice': 20.0,
      'duration': '36',
      'rating': 4.6
    },
    {
      'id': '16',
      'name': 'Corte en capas',
      'description':
          'Da volumen y movimiento a tu cabello con un corte dinámico y estilizado.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://prixz.com/salud/wp-content/uploads/2021/05/abello-le-queda-un-corte-en-capas-1.jpg'
      ],
      'minPrice': 15.0,
      'maxPrice': 25.0,
      'duration': '25',
      'rating': 4.5
    },
    {
      'id': '17',
      'name': 'Corte estilo',
      'description':
          'Personaliza tu look con un corte único que se adapte a tu personalidad.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://www.garnier.es/-/media/project/loreal/brand-sites/garnier/emea/es/posts/678-corte-pelo-mariposa.jpg?rev=44bccafb6987483d8a291ff91e1ecf62&h=488&w=678&la=es-ES&hash=6ED6033224C673A0830E85AC30E60D73'
      ],
      'minPrice': 20.0,
      'maxPrice': 30.0,
      'duration': '32',
      'rating': 4.2
    },
    {
      'id': '18',
      'name': 'Corte con máquina',
      'description':
          'Ideal para un acabado rápido y preciso, perfecto para estilos más cortos.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://img.freepik.com/fotos-premium/maquina-corte-pelo-hombres-cabello-hombres-ayuda-tijeras_158388-589.jpg?w=360'
      ],
      'minPrice': 8.0,
      'maxPrice': 15.0,
      'duration': '50',
      'rating': 4.2
    },
    {
      'id': '19',
      'name': 'Corte con flequillo',
      'description':
          'Agrega un toque moderno y juvenil con un flequillo que realza tu rostro.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://i.pinimg.com/1200x/4c/b9/f3/4cb9f393773d2103528ac9dcbd81d340.jpg'
      ],
      'minPrice': 12.0,
      'maxPrice': 18.0,
      'duration': '30',
      'rating': 3.8
    },
    {
      'id': '20.0',
      'name': 'Corte de barba',
      'description':
          'Dale forma y definición a tu barba con un corte profesional y cuidado.',
      'category': 'Cabello',
      'subCategory': 'Corte de cabello',
      'urlImages': [
        'https://i.pinimg.com/236x/80/2b/1d/802b1d0ec61e803d9b521816a906f0dc.jpg'
      ],
      'minPrice': 10.0,
      'maxPrice': 20.0,
      'duration': '34',
      'rating': 4.4
    },
    {
      'id': '21',
      'name': 'Tinte completo',
      'description':
          'Cambia el color de tu cabello completamente con tonos vibrantes o naturales.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://tahecosmetics.com/trends/wp-content/uploads/2021/12/tipos-tintes.jpeg'
      ],
      'minPrice': 30.0,
      'maxPrice': 50.0,
      'duration': '32',
      'rating': 4.9
    },
    {
      'id': '22',
      'name': 'Mechas',
      'description':
          'Agrega luminosidad y dimensión a tu cabello con mechas bien definidas.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://www.okchicas.com/wp-content/uploads/2021/04/Formas-llevar-mechas-platinadas-10.jpg'
      ],
      'minPrice': 35.0,
      'maxPrice': 60.0,
      'duration': '30',
      'rating': 4.4
    },
    {
      'id': '23',
      'name': 'Balayage',
      'description':
          'Un degradado natural que ilumina tu cabello de forma sutil y elegante.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://www.wella.com/professional/m/trendshub/Balayage_hair_article/wellaproblogbalayageguideimage6_d.jpg'
      ],
      'minPrice': 50.0,
      'maxPrice': 100.0,
      'duration': '35',
      'rating': 4.8
    },
    {
      'id': '24',
      'name': 'Corrección de color',
      'description':
          'Soluciona problemas de color no deseados para lograr un tono perfecto.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://rogelaineimagen.com/wp-content/uploads/2018/05/Foto-como-vino-la-1-vez.jpg'
      ],
      'minPrice': 40.0,
      'maxPrice': 80.0,
      'duration': '60',
      'rating': 4.5
    },
    {
      'id': '25',
      'name': 'Babylights',
      'description':
          'Luce reflejos suaves y naturales que imitan el efecto del sol en tu cabello.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://content.clara.es/medio/2022/09/06/shadowroot-balayage_d98be8af_1080x1351.jpg'
      ],
      'minPrice': 45.0,
      'maxPrice': 90.0,
      'duration': '30',
      'rating': 4.2
    },
    {
      'id': '26',
      'name': 'Decoloración',
      'description':
          'Aclara tu cabello para lograr el tono deseado o como preparación para tintes.',
      'category': 'Cabello',
      'subCategory': 'Tinturado',
      'urlImages': [
        'https://st4allthings4p4ci.blob.core.windows.net/allthingshair/allthingshair/wp-content/uploads/sites/13/2023/05/43767/como-decolorar-el-cabello-377x566.jpg'
      ],
      'minPrice': 25.0,
      'maxPrice': 50.0,
      'duration': '50',
      'rating': 4.8
    },
    {
      'id': '27',
      'name': 'Extensiones de cabello',
      'description':
          'Agrega longitud y volumen de manera natural con extensiones personalizadas.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLbnn0DosBqAM92NvqfErLoFwlukywxeDBMw&s'
      ],
      'minPrice': 100.0,
      'maxPrice': 200.0,
      'duration': '30',
      'rating': 5.0
    },
    {
      'id': '28',
      'name': 'Colocación de pelucas',
      'description':
          'Obtén un cambio de look instantáneo con pelucas ajustadas a la perfección.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA2ompfYd_SlUezKf95FoHE-n6THwxerceGA&s'
      ],
      'minPrice': 50.0,
      'maxPrice': 150.0,
      'duration': '30',
      'rating': 3.8
    },
    {
      'id': '29',
      'name': 'Volumen de postizos',
      'description':
          'Mejora la densidad de tu cabello con postizos que se integran naturalmente.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://pelucasypostizosvalencia.com/wp-content/uploads/2019/07/extensiones-clip-baratas-para-el-cabello.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 70.0,
      'duration': '38',
      'rating': 4.8
    },
    {
      'id': '30.0',
      'name': 'Retiro de extensiones',
      'description':
          'Retira tus extensiones de manera segura sin dañar tu cabello natural.',
      'category': 'Cabello',
      'subCategory': 'Extensiones y postizos',
      'urlImages': [
        'https://sevilla.abc.es/estilo/bulevarsur/wp-content/uploads/sites/14/2020/04/como-quitar-extensiones-cabello-casa.jpg'
      ],
      'minPrice': 15.0,
      'maxPrice': 30.0,
      'duration': '32',
      'rating': 4.1
    }
  ]
};

Map<String, dynamic> nailsServices = {
  'services': [
    {
      'id': '1',
      'name': 'Manicure clásico',
      'description':
          'Cuida y embellece tus manos con un tratamiento básico que incluye limado y esmalte.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://semilac.pl/media/webp_image/catalog/product/cache/73595e8c109d812957f8a30f638a0cef/s/t/stylizacja_210_jpg.webp'
      ],
      'minPrice': 10.0,
      'maxPrice': 15.0,
      'duration': '35',
      'rating': 4.5
    },
    {
      'id': '2',
      'name': 'Manicure spa',
      'description':
          'Disfruta de una experiencia relajante con exfoliación, masaje y esmalte de alta calidad.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFfQVCRvyjIkT3988_To9Wg03bNwNYFGMEaw&s'
      ],
      'minPrice': 20.0,
      'maxPrice': 30.0,
      'duration': '32',
      'rating': 4.2
    },
    {
      'id': '3',
      'name': 'Manicure francés',
      'description':
          'Luce elegante y sofisticada con la icónica técnica de diseño francés.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4YHVZcndQdYHZGuKCXcl7s5u0LDYPywXDvg&s'
      ],
      'minPrice': 15.0,
      'maxPrice': 25.0,
      'duration': '30',
      'rating': 4.4
    },
    {
      'id': '4',
      'name': 'Manicure semi permanente',
      'description':
          'Obtén un acabado brillante y duradero con esmalte de larga duración.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://i.pinimg.com/originals/4a/a6/e7/4aa6e7e4738a67c46066fdb7ce25069f.jpg'
      ],
      'minPrice': 18.0,
      'maxPrice': 28.0,
      'duration': '30',
      'rating': 4.8
    },
    {
      'id': '5',
      'name': 'Manicure con decoración',
      'description': 'Personaliza tus uñas con diseños artísticos y creativos.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://i.pinimg.com/736x/06/23/59/06235959496a3d3adddcc24a993ea10e.jpg'
      ],
      'minPrice': 25.0,
      'maxPrice': 40.0,
      'duration': '25',
      'rating': 4.0
    },
    {
      'id': '6',
      'name': 'Manicure con uñas encapsuladas',
      'description':
          'Dale un toque único a tus uñas con decoraciones encapsuladas bajo una capa de gel.',
      'category': 'Uñas',
      'subCategory': 'Manicure',
      'urlImages': [
        'https://i.pinimg.com/736x/71/d4/e7/71d4e762a361f50719aaf37e97637d91.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 50.0,
      'duration': '30',
      'rating': 5.0
    },
    {
      'id': '7',
      'name': 'Pedicure clásico',
      'description':
          'Consiente tus pies con un tratamiento básico que incluye limpieza, limado y esmalte.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://www.veronicacanas.com/cdn/shop/products/PEDICURE_95d0e7f4-4fb6-4b25-a44d-5a2652c29a7d.jpg?v=1620620258'
      ],
      'minPrice': 15.0,
      'maxPrice': 20.0,
      'duration': '30',
      'rating': 4.8
    },
    {
      'id': '8',
      'name': 'Pedicure spa',
      'description':
          'Relájate con un tratamiento completo que incluye exfoliación, masaje y cuidado de tus pies.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlMsetiPX3zM5u4qXt0WsYpvsyj22QxnPQmQ&s'
      ],
      'minPrice': 25.0,
      'maxPrice': 35.0,
      'duration': '50',
      'rating': 3.9
    },
    {
      'id': '9',
      'name': 'Pedicure con gel',
      'description':
          'Disfruta de un acabado brillante y duradero con esmalte en gel.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://i.pinimg.com/474x/06/d2/80/06d280620ca4e74055aba916e872b725.jpg'
      ],
      'minPrice': 20.0,
      'maxPrice': 30.0,
      'duration': '30',
      'rating': 4.8
    },
    {
      'id': '10',
      'name': 'Pedicure con acrílico',
      'description':
          'Refuerza y embellece tus uñas de los pies con acrílico duradero.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://i.pinimg.com/736x/6c/ca/3e/6cca3e59dbaead505db5ab9cd3cb43b8.jpg'
      ],
      'minPrice': 30.0,
      'maxPrice': 45.0,
      'duration': '20',
      'rating': 4.2
    },
    {
      'id': '11',
      'name': 'Pedicure para eventos',
      'description':
          'Luce pies perfectos y listos para cualquier ocasión especial.',
      'category': 'Uñas',
      'subCategory': 'Pedicure',
      'urlImages': [
        'https://i.pinimg.com/originals/ea/03/c1/ea03c1111bcfeab10bd0b86a02567afc.jpg'
      ],
      'minPrice': 20.0,
      'maxPrice': 35.0,
      'duration': '35',
      'rating': 4.5
    },
    {
      'id': '12',
      'name': 'Uñas acrílicas clásicas',
      'description': 'Obtén uñas fuertes y elegantes con un acabado clásico.',
      'category': 'Uñas',
      'subCategory': 'Uñas acrílicas',
      'urlImages': [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsz7MgYTssp69TqmR8rUEaEPcQlTZayb1ZNQ&s'
      ],
      'minPrice': 40.0,
      'maxPrice': 55.0,
      'duration': '30',
      'rating': 4.2
    },
    {
      'id': '13',
      'name': 'Uñas acrílicas con decoración',
      'description':
          'Personaliza tus uñas acrílicas con diseños únicos y llamativos.',
      'category': 'Uñas',
      'subCategory': 'Uñas acrílicas',
      'urlImages': [
        'https://i.pinimg.com/originals/4c/e2/51/4ce251e7228db7640ad94f78ee0493e5.jpg'
      ],
      'minPrice': 50.0,
      'maxPrice': 70.0,
      'duration': '50',
      'rating': 5.0
    },
    {
      'id': '14',
      'name': 'Uñas acrílicas french',
      'description':
          'Combina elegancia y durabilidad con uñas acrílicas en estilo francés.',
      'category': 'Uñas',
      'subCategory': 'Uñas acrílicas',
      'urlImages': [
        'https://i.pinimg.com/736x/cb/bf/bd/cbbfbdce98a73ef69addd77ba516878e.jpg'
      ],
      'minPrice': 45.0,
      'maxPrice': 60.0,
      'duration': '60',
      'rating': 4.8
    },
  ],
  'subCategories': ['Manicure', 'Pedicure', 'Uñas acrílicas']
};

Map<String, dynamic> makeupServices = {'services': null, 'categories': null};
