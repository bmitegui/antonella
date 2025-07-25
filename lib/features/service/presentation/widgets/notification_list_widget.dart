import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationListWidget extends StatelessWidget {
  final List<NotificationEntity> notifications;

  const NotificationListWidget({super.key, required this.notifications});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy \'a las\' hh:mma', 'es_ES').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
        onRefresh: () async =>
            sl<NotificationsBloc>().add(GetNotificationsEvent()),
        child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1, color: Colors.grey.shade300),
            itemBuilder: (context, index) {
              final notification = notifications[index];

              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ícono circular a la izquierda
                        CircleAvatar(
                            backgroundColor: colorScheme.primary,
                            radius: 30,
                            child: Icon(Icons.mail_outline,
                                color: colorScheme.onPrimary, size: 34)),
                        const SizedBox(width: 16),
                        // Contenido del texto
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(notification.title,
                                  style: titleBlack54Style(context)),
                              const SizedBox(height: 4),
                              Text(notification.body,
                                  style: bodyBlack54Style(context)),
                              const SizedBox(height: 8),
                              Row(children: [
                                Icon(Icons.notifications_none,
                                    size: 16,
                                    color: colorScheme.onSecondaryContainer),
                                const SizedBox(width: 4),
                                Text(_formatDate(notification.createdAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: colorScheme
                                                .onSecondaryContainer))
                              ])
                            ]))
                      ]));
            }));
  }
}
