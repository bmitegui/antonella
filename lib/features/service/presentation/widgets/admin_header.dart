import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/features/user/presentation/bloc/admin/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<AdminBloc, AdminState>(builder: (context, state) {
      return (state is AdminLoaded)
          ? Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Row(children: [
                Container(
                    width: 32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    clipBehavior: Clip.hardEdge,
                    child: state.userEntity.photoUrl != null
                        ? CustomCachedNetworkImage(
                            imageUrl:
                                Environment.apiUrl + state.userEntity.photoUrl!)
                        : Icon(Icons.person)),
                const SizedBox(width: 8),
                Text(state.userEntity.name)
              ]),
          )
          : Row(children: [
              Icon(Icons.person),
              const SizedBox(width: 8),
              Text(texts.administrator)
            ]);
    });
  }
}
