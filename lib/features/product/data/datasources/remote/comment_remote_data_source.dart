import 'package:antonella/features/product/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:dio/dio.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getCommentsService({required ServiceCategory? filter});
}

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final Dio client;
  CommentRemoteDataSourceImpl({required this.client});
  
  
  
  }