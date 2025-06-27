import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/screens/edit_profile_screen.dart';
import 'package:antonella/features/user/presentation/screens/update_pasword_screen.dart';
import 'package:antonella/features/user/presentation/widgets/settings_photowidget.dart';
import 'package:antonella/features/user/presentation/screens/support_screen.dart';
import 'package:antonella/features/product/presentation/shopping_cart_screen.dart';
import 'package:antonella/features/product/presentation/purchase_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomScaffold(
        text: 'Ajustes',
        child: BlocConsumer<UserBloc, UserState>(
            listener: (BuildContext context, UserState state) {
          if (state is UserUnauthenticated) {
            showTopSnackBar(Overlay.of(context),
                const CustomSnackBar.success(message: 'Cierre exitoso'));
          } else if (state is UserError) {
            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                    message: mapFailureToMessage(
                        context: context, failure: state.failure),
                    maxLines: 3));
          }
        }, builder: (context, state) {
          return (state is UserAuthenticated)
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Center(child: const SettingsPhotowidget()),
                  const SizedBox(height: 8),
                  Center(
                      child: Text(state.user.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith())),
                  Center(
                      child: Text(state.user.email,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey))),
                  const SizedBox(height: 16),
                  SizedBox(
                      child: Text('Cuenta',
                          textAlign: TextAlign.left,
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.grey))),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTile(
                            leading: const Icon(Icons.lock_outline),
                            title: Text('Cambiar Contraseña'),
                            onTap: () => navigateWithSlideTransition(
                                context, UpdatePaswordScreen())),
                        Divider(height: 1, color: Colors.grey.shade300),
                        ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Editar Perfil'),
                            onTap: () => navigateWithSlideTransition(
                                context, EditProfileScreen())),
                        Divider(height: 1, color: Colors.grey.shade300),
                        ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('Cerrar Sesión'),
                            onTap: () {
                              sl<ServicesSelectedBloc>()
                                  .add(ClearServicesSelectedEvent());
                              context
                                  .read<UserBloc>()
                                  .add(SignOutEvent(userEntity: state.user));
                            })
                      ])),
                  const SizedBox(height: 16),
                  Text('Compras',
                      textAlign: TextAlign.left,
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTile(
                            leading: const Icon(Icons.article_outlined),
                            title: Text('Historial de Compras'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PurchaseHistoryScreen(),
                                  ));
                            }),
                        Divider(height: 1, color: Colors.grey.shade300),
                        ListTile(
                            leading: const Icon(Icons.add_shopping_cart),
                            title: Text('Carrito de Compras'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ShoppingCartScreen(),
                                  ));
                            }),
                        Divider(height: 1, color: Colors.grey.shade300),
                      ])),
                  const SizedBox(height: 16),
                  Text('Preferencias',
                      textAlign: TextAlign.left,
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTile(
                            leading: Text('ESP',
                                style: Theme.of(context).textTheme.titleMedium),
                            title: const Text('Cambiar Idioma'),
                            onTap: () {}),
                        Divider(height: 1, color: Colors.grey.shade300),
                        ListTile(
                            leading: const Icon(Icons.dark_mode),
                            title: const Text('Modo Oscuro'),
                            onTap: () {}),
                        Divider(height: 1, color: Colors.grey.shade300),
                        ListTile(
                            leading: const Icon(Icons.notifications),
                            title: const Text('Notificaciones'),
                            onTap: () {})
                      ])),
                  const SizedBox(height: 16),
                  Text('Soporte y Legales',
                      textAlign: TextAlign.left,
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTile(
                            leading: const Icon(Icons.policy),
                            title: const Text('Políticas de Privacidad'),
                            onTap: () {}),
                        Divider(height: 1, color: Colors.grey.shade300),
                        ListTile(
                            leading: const Icon(Icons.build),
                            title: const Text('Soporte Técnico'),
                            onTap: () => navigateWithSlideTransition(
                                context, SupportScreen()))
                      ]))
                ])
              : LottieBuilder.asset("assets/lottie/loading_screen.json");
        }));
  }
}
