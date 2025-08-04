import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/screens/change_language_screen.dart';
import 'package:antonella/features/user/presentation/screens/dark_mode_screen.dart';
import 'package:antonella/features/user/presentation/screens/edit_profile_screen.dart';
import 'package:antonella/features/user/presentation/screens/update_pasword_screen.dart';
import 'package:antonella/features/user/presentation/widgets/list_title_settings.dart';
import 'package:antonella/features/user/presentation/screens/support_screen.dart';
import 'package:antonella/features/product/presentation/shopping_cart_screen.dart';
import 'package:antonella/features/product/presentation/purchase_history_screen.dart';
import 'package:antonella/features/user/presentation/widgets/user_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import "package:antonella/core/l10n/app_localizations.dart";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScaffold(
        text: texts.settings,
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
                  Center(child: UserPhotoWidget()),
                  const SizedBox(height: 8),
                  Center(
                      child: Text(state.user.name,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Center(
                      child: Text(state.user.email,
                          style: bodyBlack54Style(context))),
                  const SizedBox(height: 16),
                  Text(texts.account,
                      textAlign: TextAlign.left,
                      style: titleBlack54Style(context)),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTitleSettings(
                            text: texts.change_password,
                            iconData: Icons.lock_outline,
                            goTo: UpdatePaswordScreen()),
                        Divider(height: 1, color: colorScheme.onSurfaceVariant),
                        ListTitleSettings(
                            text: texts.edit_profile,
                            iconData: Icons.edit,
                            goTo: EditProfileScreen()),
                        Divider(height: 1, color: colorScheme.onSurfaceVariant),
                        ListTitleSettings(
                            text: texts.log_out,
                            iconData: Icons.logout,
                            onTap: () {
                              sl<ServicesSelectedBloc>()
                                  .add(ClearServicesSelectedEvent());
                              context
                                  .read<UserBloc>()
                                  .add(SignOutEvent(userEntity: state.user));
                            })
                      ])),
                  (state.user.rol == Rol.cliente)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              const SizedBox(height: 16),
                              Text(texts.purchases,
                                  textAlign: TextAlign.left,
                                  style: titleBlack54Style(context)),
                              const SizedBox(height: 8),
                              Container(
                                  decoration: BoxDecoration(
                                      color: colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(children: [
                                    // ListTitleSettings(
                                    //     text: texts.purchases_history,
                                    //     iconData: Icons.article_outlined,
                                    //     goTo: PurchaseHistoryScreen()),
                                    // Divider(
                                    //     height: 1,
                                    //     color: colorScheme.onSurfaceVariant),
                                    ListTitleSettings(
                                        text: texts.shopping_cart,
                                        iconData: Icons.add_shopping_cart,
                                        goTo: ShoppingCartScreen())
                                  ]))
                            ])
                      : const SizedBox.shrink(),
                  const SizedBox(height: 16),
                  Text(texts.preferences,
                      textAlign: TextAlign.left,
                      style: titleBlack54Style(context)),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTitleSettings(
                            text: texts.idm,
                            iconData: Icons.language,
                            goTo: ChangeLanguageScreen()),
                        Divider(height: 1, color: colorScheme.onSurfaceVariant),
                        ListTitleSettings(
                            text: texts.dark_mode,
                            iconData: Icons.dark_mode,
                            goTo: DarkModeScreen()),
                        Divider(height: 1, color: colorScheme.onSurfaceVariant),
                        ListTitleSettings(
                            text: texts.notifications,
                            iconData: Icons.notifications)
                      ])),
                  const SizedBox(height: 16),
                  Text(texts.support_and_legal,
                      textAlign: TextAlign.left,
                      style: titleBlack54Style(context)),
                  const SizedBox(height: 8),
                  Container(
                      decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: [
                        ListTitleSettings(
                            text: texts.privacy_policy, iconData: Icons.policy),
                        Divider(height: 1, color: colorScheme.onSurfaceVariant),
                        ListTitleSettings(
                            text: texts.technical_support,
                            iconData: Icons.build,
                            goTo: SupportScreen())
                      ]))
                ])
              : LottieBuilder.asset("assets/lottie/loading_screen.json");
        }));
  }
}
