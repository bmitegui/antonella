import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/widgets/message_input_field.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/send_message/send_message_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VisualizeChatUserScreen extends StatefulWidget {
  const VisualizeChatUserScreen({super.key});

  @override
  State<VisualizeChatUserScreen> createState() =>
      _VisualizeChatUserScreenState();
}

class _VisualizeChatUserScreenState extends State<VisualizeChatUserScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  List<MessageEntity> messages = [];
  String? _lastMessageId;

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
          if (state is MessagesLoaded) {
            final newMessages = state.listMessages;

            if (newMessages.isNotEmpty) {
              final latestMessageId = newMessages.last.messageId;

              if (_lastMessageId != latestMessageId) {
                _lastMessageId = latestMessageId;
                _scrollToBottom();
              }
            }

            messages = newMessages;
          }
          return Padding(
              padding: const EdgeInsets.only(bottom: 100, right: 16, left: 16),
              child: Column(children: [
                Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.only(bottom: 16),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[messages.length - 1 - index];
                          final isClient = message.senderId == clientId;
                          final formattedTime = DateFormat('hh:mm a')
                              .format(message.dateTime.toLocal());
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    BubbleNormal(
                                        seen: true,
                                        text: message.content,
                                        isSender: isClient,
                                        color: isClient
                                            ? Color(0xFFE8E8EE)
                                            : Color(0xFFFAE2E1),
                                        textStyle: TextStyle(
                                            color: isClient
                                                ? Colors.black
                                                : Colors.white)),
                                    Text(formattedTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.grey))
                                  ]));
                        })),
                BlocConsumer<MessagesBloc, MessageState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return MessageInputField(onSend: (value) {
                        sl<SendMessageBloc>().add(SendMessagesEvent(
                            userId: clientId,
                            content: value,
                            type: MessageType.text));
                      });
                    })
              ]));
        }));
  }
}
