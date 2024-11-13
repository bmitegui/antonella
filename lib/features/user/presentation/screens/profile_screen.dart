import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/profile_option_widget.dart';
import 'package:antonella/features/user/presentation/widgets/user_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: BlocConsumer<UserBloc, UserState>(
                listener: (BuildContext context, UserState state) {
      if (state is UserUnauthenticated) {
        showTopSnackBar(Overlay.of(context),
            const CustomSnackBar.success(message: 'Cierre exitoso'));
      } else if (state is UserError) {
        showTopSnackBar(Overlay.of(context),
            CustomSnackBar.error(message: state.message, maxLines: 3));
      }
    }, builder: (context, state) {
      return (state is UserAuthenticated)
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const UserPhotoWidget(),
                    const SizedBox(height: 16),
                    Text(state.user.name,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(state.user.email,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    ProfileOptionWidget(
                        title: 'Mis citas',
                        iconData: Icons.calendar_month,
                        onTap: () {}),
                    const SizedBox(height: 8),
                    ProfileOptionWidget(
                        title: 'Datos de facturación',
                        iconData: Icons.description,
                        onTap: () {}),
                    const SizedBox(height: 8),
                    ProfileOptionWidget(
                        title: 'Editar perfil',
                        iconData: Icons.edit,
                        onTap: () {}),
                    const SizedBox(height: 8),
                    ProfileOptionWidget(
                        title: 'Ajustar notificaciones',
                        iconData: Icons.notifications,
                        onTap: () {}),
                    const SizedBox(height: 8),
                    ProfileOptionWidget(
                        title: 'Cerrar sesión',
                        iconData: Icons.exit_to_app,
                        onTap: () => context
                            .read<UserBloc>()
                            .add(SignOutEvent(userEntity: state.user)))
                  ]))
          : LottieBuilder.asset("assets/lottie/loading_screen.json");
    })));
  }
}
