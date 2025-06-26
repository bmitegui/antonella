import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

class GetMessagesUseCase
    implements UseCase<MessageEntity, NoParams> {
  final UserRepository userRepository;
  GetMessagesUseCase({required this.userRepository});
  
  @override
  Future<Either<Failure, MessageEntity>> call(NoParams params) async{
    return await userRepository.getMessages();
  }

 
}

