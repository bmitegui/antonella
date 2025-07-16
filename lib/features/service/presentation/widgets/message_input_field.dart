import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  final void Function(String) onSend;

  const MessageInputField({super.key, required this.onSend});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: TextFormField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: _controller,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFFAE2E1),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintText: 'Escribe un mensaje...',
                  hintStyle: TextStyle(
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
    ]);
  }
}
