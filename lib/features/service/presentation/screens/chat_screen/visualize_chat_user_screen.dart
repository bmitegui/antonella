import 'dart:async';

import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/widgets/admin_header.dart';
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
  List<MessageEntity> messages = [];
  String? _lastMessageId;

  String _floatingDate = '';
  bool _showFloatingDate = false;
  Timer? _floatingDateTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final grouped = groupMessagesByDate(messages);
    final offsets = <int, String>{};
    int index = 0;

    for (var entry in grouped.entries) {
      offsets[index] = entry.key; // Fecha como encabezado
      index += entry.value.length + 1; // +1 por el encabezado
    }

    for (var offset in offsets.entries) {
      final context = _itemKeys[offset.key]?.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.localToGlobal(Offset.zero).dy >= 0) {
          final newDate = offset.value;
          if (_floatingDate != newDate || !_showFloatingDate) {
            setState(() {
              _floatingDate = newDate;
              _showFloatingDate = true;
            });
          }

// Reiniciar el timer siempre que se haga scroll, incluso si la fecha no cambia
          _floatingDateTimer?.cancel();
          _floatingDateTimer = Timer(Duration(seconds: 2), () {
            setState(() {
              _showFloatingDate = false;
            });
          });

          break;
        }
      }
    }
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

  final Map<int, GlobalKey> _itemKeys = {};

  @override
  Widget build(BuildContext context) {
    String clientId = '';
    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      clientId = userState.user.id;
    }

    return CustomScaffold(
      noPaddingTitle: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BlocBuilder<MessagesBloc, MessageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: MessageInputField(onSend: (value, messageType) {
              sl<SendMessageBloc>().add(SendMessagesEvent(
                  userId: clientId, content: value, type: messageType));
            }),
          );
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async => sl<MessagesBloc>().add(GetMessagesEvent()),
        child: Column(
          children: [
            AdminHeader(),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<MessagesBloc, MessageState>(
                  builder: (context, state) {
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

                    final grouped = groupMessagesByDate(messages);
                    final messageWidgets = <Widget>[];
                    int index = 0;
                    _itemKeys.clear();

                    final sortedKeys = grouped.keys.toList()
                      ..sort((a, b) =>
                          DateTime.parse(a).compareTo(DateTime.parse(b)));

                    for (var dateKey in sortedKeys) {
                      final dateFormatted = DateFormat('dd MMM yyyy')
                          .format(DateTime.parse(dateKey));
                      _itemKeys[index] = GlobalKey();
                      messageWidgets.add(Container(
                        key: _itemKeys[index],
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(dateFormatted,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87)),
                        ),
                      ));
                      index++;

                      final messagesForDate = grouped[dateKey]!;
                      for (var message in messagesForDate.reversed) {
                        final isClient = message.senderId == clientId;
                        final isImage =
                            message.messageType == MessageType.image;
                        final formattedTime = DateFormat('hh:mm a')
                            .format(message.dateTime.toLocal());

                        messageWidgets.add(Padding(
                          key: _itemKeys[index] = GlobalKey(),
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: isClient
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              isImage
                                  ? BubbleNormalImage(
                                      id: message.messageId,
                                      seen: true,
                                      padding: EdgeInsets.zero,
                                      isSender: isClient,
                                      color: isClient
                                          ? Color(0xFFFAE2E1)
                                          : Colors.white,
                                      image: CustomCachedNetworkImage(
                                          imageUrl: Environment.apiUrl +
                                              message.content),
                                    )
                                  : BubbleNormal(
                                      seen: true,
                                      padding: EdgeInsets.zero,
                                      text: message.content,
                                      isSender: isClient,
                                      color: isClient
                                          ? Color(0xFFFAE2E1)
                                          : Colors.white,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!,
                                    ),
                              Text(formattedTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Colors.grey, fontSize: 10)),
                            ],
                          ),
                        ));
                        index++;
                      }
                    }

                    return Stack(
                      children: [
                        ListView(
                          controller: _scrollController,
                          padding: const EdgeInsets.only(bottom: 16),
                          children: messageWidgets,
                        ),
                        if (_showFloatingDate)
                          Positioned(
                            top: 20,
                            left: MediaQuery.of(context).size.width / 2 - 50,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                DateFormat('dd MMM yyyy')
                                    .format(DateTime.parse(_floatingDate)),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<MessageEntity>> groupMessagesByDate(
      List<MessageEntity> messages) {
    final grouped = <String, List<MessageEntity>>{};
    for (var message in messages) {
      final dateKey =
          DateFormat('yyyy-MM-dd').format(message.dateTime.toLocal());
      grouped.putIfAbsent(dateKey, () => []).add(message);
    }
    return grouped;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _floatingDateTimer?.cancel();

    super.dispose();
  }
}
