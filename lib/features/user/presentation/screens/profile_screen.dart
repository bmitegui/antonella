import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/widgets/profile_option_widget.dart';
import 'package:antonella/features/user/presentation/widgets/settings_photowidget.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF0F0F0),
          title: Text('Ajustes',
              textAlign: TextAlign.left,
              style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: const Color(0xFFFF4B7D))),
        ),
        backgroundColor: Color(0xFFF0F0F0),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        SizedBox(height: 16),
                        Center(child: const SettingsPhotowidget()),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(state.user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith()),
                        ),
                        Center(
                            child: Text(state.user.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ))),
                        // Sección: Cuenta
                        SizedBox(
                          child: Text('Cuenta',
                              textAlign: TextAlign.left,
                              style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF333333))),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.lock_outline),
                                title: const Text('Cambiar Contraseña'),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.edit_outlined),
                                title: const Text('Editar Perfil'),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Cerrar Sesión'),
                                onTap: () {
                                  sl<ServicesSelectedBloc>()
                                      .add(ClearServicesSelectedEvent());
                                  context.read<UserBloc>().add(
                                      SignOutEvent(userEntity: state.user));
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Sección: Preferencias
                        Text('Preferencias',
                            textAlign: TextAlign.left,
                            style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333))),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Text('ESP',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                title: const Text('Cambiar Idioma'),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.dark_mode_outlined),
                                title: const Text('Modo Oscuro'),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.notifications_none),
                                title: const Text('Notificaciones'),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Sección: Soporte y Legales
                        Text('Soporte y Legales',
                            textAlign: TextAlign.left,
                            style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF333333))),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.policy_outlined),
                                title: const Text('Políticas de Privacidad'),
                                onTap: () {},
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.build_outlined),
                                title: const Text('Soporte Técnico'),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ])))
              : LottieBuilder.asset("assets/lottie/loading_screen.json");
        })));
  }
}
