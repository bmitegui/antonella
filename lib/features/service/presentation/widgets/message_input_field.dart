import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/features/service/presentation/widgets/upload_image_chat_widget.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/send_message/send_message_bloc.dart';
import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  final void Function(String, MessageType type) onSend;

  const MessageInputField({super.key, required this.onSend});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();
  double bottom = 86;

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text, MessageType.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Row(children: [
          Expanded(
              child: TextFormField(
                  onTap: () => setState(() => bottom = 0),
                  controller: _controller,
                  onTapOutside: (_) {
                    setState(() {
                      bottom = 100;
                    });
                    FocusScope.of(context).unfocus();
                  },
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.add, color: Color(0xFFF44565)),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return UploadImageChatWidget(
                                  onImagePicked: (base64) {
                                    widget.onSend(base64, MessageType.image);
                                  }
                                );
                              });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFFAE2E1),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      hintText: texts.write_message,
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onEditingComplete: () {
                    _handleSend();
                    FocusScope.of(context).unfocus();
                  })),
          const SizedBox(width: 8),
          IconButton(
              onPressed: _handleSend,
              icon: const Icon(Icons.send, color: Color(0xFFF44565)))
        ]));
  }
}
