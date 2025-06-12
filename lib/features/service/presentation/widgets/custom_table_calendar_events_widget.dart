import 'package:antonella/core/widgets/custom_icon_button.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/service_image_network.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String name;
  final String category;
  final String subCategory;
  final String urlImage;
  final double minPrice;
  final double maxPrice;
  final Color color;
  final String address;
  final String hours;
  final String proffessional;

  Event(
      {required this.name,
      required this.category,
      required this.subCategory,
      required this.urlImage,
      required this.minPrice,
      required this.maxPrice,
      required this.color,
      required this.address,
      required this.hours,
      required this.proffessional});
}

class CustomTableCalendarEventsWidget extends StatefulWidget {
  const CustomTableCalendarEventsWidget({super.key});

  @override
  State<CustomTableCalendarEventsWidget> createState() =>
      _CustomTableCalendarEventsWidgetState();
}

class _CustomTableCalendarEventsWidgetState
    extends State<CustomTableCalendarEventsWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Event>> _events = {
    DateTime(2025, 06, 5): [
      Event(
          proffessional: 'Sabrina Carpenter',
          name: 'Hidratante',
          category: 'Spa',
          subCategory: 'Tratamientos faciales',
          urlImage:
              'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
          minPrice: 50.0,
          maxPrice: 80.0,
          color: Colors.amber,
          address: 'Av. Calle principal, Calle numero #',
          hours: '09:00-10:00'),
      Event(
          proffessional: 'Sabrina Carpenter',
          name: 'Anti edad',
          category: 'Spa',
          subCategory: 'Tratamientos faciales',
          urlImage:
              'https://maison-spa.com/wp-content/uploads/2024/05/STOCK-PHOTOS-1-1-9.png',
          minPrice: 50.0,
          maxPrice: 80.0,
          color: Colors.redAccent,
          address: 'Av. Calle principal, Calle numero #',
          hours: '11:00-12:00')
    ],
    DateTime(2025, 06, 10): [
      Event(
          proffessional: 'Taylor Swift',
          name: 'Corte de puntas',
          category: 'Cabello',
          subCategory: 'Corte de cabello',
          urlImage:
              'https://imagenes.elpais.com/resizer/v2/CZKQQ4VB7NIEVH7LOHB3N4NRRI.jpg?auth=69135426f9fa4930e1c38426ca5d79b198f3b38d8077dc6efd8502117ad05e22&width=1960&height=1103&smart=true',
          minPrice: 50.0,
          maxPrice: 80.0,
          color: Colors.blueAccent,
          address: 'Av. Calle principal, Calle numero #',
          hours: '09:00-10:00'),
      Event(
          proffessional: 'Sabrina Carpenter',
          name: 'Hidratante',
          category: 'Spa',
          subCategory: 'Tratamientos faciales',
          urlImage:
              'https://lavandacasaspa.com/wp-content/uploads/2020/09/los-beneficios-de-recibir-un-tratamiento-hidratacion-facial.jpg',
          minPrice: 50.0,
          maxPrice: 80.0,
          color: Colors.orange,
          address: 'Av. Calle principal, Calle numero #',
          hours: '09:00-10:00'),
      Event(
          proffessional: 'Maria Fernandez',
          name: 'Volumen de postizos',
          category: 'Cabello',
          subCategory: 'Extensiones y postizos',
          urlImage:
              'https://pelucasypostizosvalencia.com/wp-content/uploads/2019/07/extensiones-clip-baratas-para-el-cabello.jpg',
          minPrice: 50.0,
          maxPrice: 80.0,
          color: Colors.purpleAccent,
          address: 'Av. Calle principal, Calle numero #',
          hours: '09:00-10:00')
    ],
    DateTime(2024, 12, 15): [
      Event(
          proffessional: 'Carlos Klein',
          name: 'Corte de barba',
          category: 'Cabello',
          subCategory: 'Corte de cabello',
          urlImage:
              'https://i.pinimg.com/236x/80/2b/1d/802b1d0ec61e803d9b521816a906f0dc.jpg',
          minPrice: 50.0,
          maxPrice: 80.0,
          color: Colors.pinkAccent,
          address: 'Av. Calle principal, Calle numero #',
          hours: '09:00-10:00')
    ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TableCalendar(
          headerStyle: HeaderStyle(
              headerMargin: const EdgeInsets.only(bottom: 8),
              leftChevronPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              rightChevronPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
              headerPadding: EdgeInsets.zero,
              titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              leftChevronIcon:
                  const Icon(Icons.chevron_left, color: Colors.black, size: 32),
              rightChevronIcon:
                  const Icon(Icons.chevron_right, color: Colors.black, size: 32),
              titleCentered: true,
              titleTextFormatter: (date, locale) {
                return DateFormat('MMMM yyyy', locale).format(date).toUpperCase();
              },
          ),
          
          availableCalendarFormats: const {CalendarFormat.month: 'Mes'},
          locale: 'es_EC',
          firstDay: DateTime.utc(2023),
          lastDay: DateTime.utc(2099),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
              todayTextStyle: const TextStyle(
                color:  Color(0XFFBD818E)
                ),
              todayDecoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0XFFBD818E)
                    ),
                  shape: BoxShape.circle),
              selectedDecoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              markerDecoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle)),
          eventLoader: _getEventsForDay,
          calendarBuilders:
              CalendarBuilders(markerBuilder: (context, date, events) {
            if (events.isEmpty) return const SizedBox.shrink();
            return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: events
                    .map((event) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: (event as Event).color,
                            shape: BoxShape.circle)))
                    .toList());
          })),
      const SizedBox(height: 16),
      Expanded(
          child: _selectedDay == null
              ? const Center(
                  child: Text('Selecciona un horario para ver sus citas'),
                )
              : ListView.builder(
                  itemCount: _getEventsForDay(_selectedDay!).length,
                  itemBuilder: (context, index) {
                    final event = _getEventsForDay(_selectedDay!)[index];
                    return buildEventInfo(event: event);
                  }))
    ]);
  }

  Widget buildEventInfo({required Event event}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: event.color)),
            child: Row(children: [
              Column(children: [
                Text(event.category,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: event.color)),
                const SizedBox(height: 8),
                ServiceImageNetwork(
                    urlImage: event.urlImage,
                    width: MediaQuery.of(context).size.width / 3.2,
                    height: MediaQuery.of(context).size.height / 7),
                const SizedBox(height: 8),
                Text('\$${event.minPrice} - ${event.maxPrice}')
              ]),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(children: [
                Text(event.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: event.color)),
                const SizedBox(height: 8),
                Row(children: [
                  const CustomIconButton(
                      iconData: Icons.person,
                      color:  Color(0XFFD3C7CB),
                      size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(event.proffessional,
                          maxLines: 1, overflow: TextOverflow.ellipsis))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  const CustomIconButton(
                      iconData: Icons.watch_later,
                      color:  Color(0XFFD3C7CB),
                      size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(event.hours,
                          maxLines: 1, overflow: TextOverflow.ellipsis))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  CustomIconButton(
                      iconData: Icons.location_on,
                      color: const Color(0XFFD3C7CB),
                      size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(event.address,
                          maxLines: 1, overflow: TextOverflow.ellipsis))
                ])
              ]))
            ])));
  }
}
