import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_chats_widget.dart';
import 'package:flutter/material.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
        closeAction: false,
        title: 'Chats',
        body: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              'Selecciona y chatea con un profesional del servicio que prefieras.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54)),
          const SizedBox(height: 16),
          const Expanded(child: ListChatsWidget())
        ])));
  }
}
