import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/widgets/message_input_field.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisualizeChatUserScreen extends StatelessWidget {
  const VisualizeChatUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String clientId = '';
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      clientId = userState.user.id;
    }

    return CustomScaffold(
        title: Row(children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/women/44.jpg'),
          ),
          const SizedBox(width: 8),
          const Text('Administrador')
        ]),
        body:
            BlocBuilder<MessagesBloc, MessageState>(builder: (context, state) {
          List<MessageEntity> messages = [];
          if (state is MessagesLoaded) {
            messages = state.listMessages;
          }

          return Padding(
              padding: const EdgeInsets.only(bottom: 100, right: 16, left: 16),
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 16),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[messages.length - 1 - index];
                          final isClient = message.senderId == clientId;
                          return BubbleNormal(
                              seen: true,
                              padding: EdgeInsets.only(bottom: 8),
                              text: message.content,
                              isSender: isClient,
                              color: isClient
                                  ? Color(0xFFE8E8EE)
                                  : Color(0xFF1B97F3),
                              textStyle: TextStyle(
                                  color:
                                      isClient ? Colors.black : Colors.white));
                        })),
                MessageInputField(onSend: (value) {})
              ]));
        }));
  }
}
