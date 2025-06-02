import 'package:antonella/core/widgets/activity_state_widget.dart';
import 'package:antonella/features/service/presentation/widgets/label_detail_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F0F0),
        body: SingleChildScrollView(
          child: Column(children: [
              ImagesScrollview(imageLinks: [
                'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
                'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
                'https://www.esteticalink.com/wp-content/uploads/2017/04/masaje-pies.jpg'
              ]),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Hidratante'),
                    SizedBox(height: 16),
                    Text('Tratamiento Facial'),
                    SizedBox(height: 16),
                    LabelDetailServiceWidget(),
                    SizedBox(height: 16),
                    Text('Tratamiento diseñado para restaurar la humedad y suavidad natural de la piel'),
                    const Divider(color: Colors.grey),
                    Text('Calificaciones y Opiniones'),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/juliana.jpg'),
                      ),
                      title: Text('Juliana Andrea Daza'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Icon(Icons.star_border, size: 16),
                              SizedBox(width: 8),
                              Text('14/02/2025', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Excelente servicio. Por supuesto que volvería a hacer este tratamiento, súper relajante.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
                
              ),
            
              //ActivityStateWidget()
            ]
          ),
        ), 
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '\$10 - \$30',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción para agregar servicio
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Agregar Servicio'),
            ),
          ],
        ),
      ),
    );
  }
}
