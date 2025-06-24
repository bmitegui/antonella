import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soporte técnico'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seleccione uno de los medios a continuación para recibir soporte técnico:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Correo
            SupportItem(
              icon: Icons.mail_outline,
              color: Colors.yellow.shade700,
              title: 'Correo',
              subtitle: 'contacto@antonella.com',
            ),

            const SizedBox(height: 12),

            // WhatsApp
            SupportItem(
              icon: Icons.phone_android,
              color: Colors.green,
              title: 'Whatsapp',
              subtitle: '+593 981108164',
            ),

            const SizedBox(height: 12),

            // Teléfono
            SupportItem(
              icon: Icons.phone,
              color: Colors.blue,
              title: 'Teléfono',
              subtitle: '+593 981108164',
            ),

            const SizedBox(height: 12),

            // Sitio web
            SupportItem(
              icon: Icons.web,
              color: Colors.pinkAccent,
              title: 'Sitio web',
              subtitle: 'https://antonella.com',
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reutilizable para cada ítem de contacto
class SupportItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const SupportItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
