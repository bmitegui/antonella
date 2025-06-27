import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class SendMessagesUseCase implements UseCase<void, SendMessageParams> {
  final UserRepository userRepository;
  SendMessagesUseCase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(
      SendMessageParams sendMessageParams) async {
    return await userRepository.sendMessage(
        userId: sendMessageParams.userId,
        content: sendMessageParams.content,
        type: sendMessageParams.type);
  }
}

class SendMessageParams {
  final String userId;
  final String content;
  final MessageType type;
  SendMessageParams(
      {required this.userId, required this.content, required this.type});
}
