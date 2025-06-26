import 'package:antonella/core/error/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState>{
  MessageBloc(super.initialState);

}