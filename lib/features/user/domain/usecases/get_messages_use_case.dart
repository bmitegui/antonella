import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUseCase
    implements UseCase<List<MessageEntity>, NoParams> {
  final UserRepository userRepository;
  GetMessagesUseCase({required this.userRepository});
  
  @override
  Future<Either<Failure, List<MessageEntity>>> call(NoParams params) async{
    return await userRepository.getMessages();
  }

 
}

