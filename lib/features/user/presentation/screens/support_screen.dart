// ignore_for_file: deprecated_member_use

import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import "package:antonella/core/l10n/app_localizations.dart";


class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        text: texts.technical_support,
        leading: ArrowBack(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          Text(
              texts.select_technical_support,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black54)),
          const SizedBox(height: 16),

          // Correo
          SupportItem(
              onTap: () {},
              icon: Icons.mail_outline,
              color: Colors.yellow.shade700,
              title: texts.email,
              subtitle: email),

          const SizedBox(height: 16),

          // WhatsApp
          SupportItem(
              onTap: () async => await launchWhatsApp(
                  phoneNumber: phoneNumber,
                  message: texts.good_moorning),
              icon: Icons.phone_android,
              color: Colors.green,
              title: texts.whatsapp,
              subtitle: phoneNumber),

          const SizedBox(height: 16),

          // Teléfono
          SupportItem(
              onTap: () async => await makePhoneCall(phoneNumber: phoneNumber),
              icon: Icons.phone,
              color: Colors.blue,
              title: texts.phone_number,
              subtitle: phoneNumber),

          const SizedBox(height: 16),

          // Sitio web
          SupportItem(
              onTap: () async => await utilLaunchUrl(url: instagram),
              icon: Icons.web,
              color: Colors.pinkAccent,
              title: texts.instagram,
              subtitle: 'antonellacbe')
        ]));
  }
}

// Widget reutilizable para cada ítem de contacto
class SupportItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final void Function() onTap;

  const SupportItem(
      {super.key,
      required this.icon,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color)),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.black54))
                  ]))
            ])));
  }
}
