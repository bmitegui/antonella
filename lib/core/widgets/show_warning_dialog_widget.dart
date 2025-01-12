import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showWarningDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required Function() onAccept,
    String textOnAccept = 'Aceptar'}) async {
  await AwesomeDialog(
    dialogBackgroundColor: Colors.white,
          btnCancel: FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          btnOk: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onAccept();
              },
              child:  Text(textOnAccept)),
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          title: title,
          desc: message,
          btnOkText: 'Aceptar',
          btnCancelText: 'Cancelar')
      .show();
}
