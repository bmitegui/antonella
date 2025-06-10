import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/core/widgets/retroceder_logo_widget.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/service/presentation/widgets/label_detail_service_widget.dart';
import 'package:flutter/material.dart';

class DetailServiceScreen extends StatefulWidget {
  final ServiceEntity serviceEntity;
  const DetailServiceScreen({super.key, required this.serviceEntity});

  @override
  State<DetailServiceScreen> createState() => _DetailServiceWidgetState();
}

class _DetailServiceWidgetState extends State<DetailServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          AppBar(leading: ArrowBack(), backgroundColor: Colors.transparent, title: Text('Detalles')),
      backgroundColor: Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        child: Column(children: [
          ImagesScrollview(imageLinks: 
          [
            'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
            'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
            'https://www.esteticalink.com/wp-content/uploads/2017/04/masaje-pies.jpg'
          ]
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.serviceEntity.name),
                SizedBox(height: 16),
                Text(widget.serviceEntity.subCategory),
                SizedBox(height: 16),
                LabelDetailServiceWidget(
                  category: getCategoryText(context: context, serviceCategory: widget.serviceEntity.category), 
                  rating: '4.0[45]', 
                  duration: '45 min'
                ),
                SizedBox(height: 16),
                Text(widget.serviceEntity.description),
                SizedBox(height: 16),
                const Divider(color: Colors.grey),
                Text('Calificaciones y Opiniones'),
                const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/icon/logo.png'),
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
                            Text('14/02/2025',
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Excelente servicio. Por supuesto que volvería a hacer este tratamiento, súper relajante.',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ]),
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
                Text(
                  '${widget.serviceEntity.minPrice} - ${widget.serviceEntity.maxPrice}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () {
                      // Acción para agregar servicio
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('Agregar Servicio'))
              ])));
  }
}
