import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/payment_method.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';

class OptionsPayShoppingCartScreen extends StatefulWidget {
  const OptionsPayShoppingCartScreen({super.key});

  @override
  State<OptionsPayShoppingCartScreen> createState() =>
      _OptionsPayShoppingCartScreenState();
}

class _OptionsPayShoppingCartScreenState
    extends State<OptionsPayShoppingCartScreen> {
  String _metodo = "EFECTIVO";

  @override
  Widget build(BuildContext context) {
    UserEntity? userEntity;

    final userState = sl<UserBloc>().state;
    if (userState is UserAuthenticated) {
      userEntity = userState.user;
    }

    return CustomScaffold(
        leading: ArrowBack(),
        text: "Pagar productos",
        child: Column(children: [
          const SizedBox(height: 16),
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.white),
              child: Column(children: [
                Row(children: [
                  Text('Datos de facturación'),
                  Spacer(),
                  Text('Cambiar',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Color(0xFFF44565),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFF44565)))
                ]),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Row(children: [
                  CustomLocalSvgImage(
                      assetPath: 'assets/svg/factura.svg',
                      height: 64,
                      color: Color(0xFFF44565)),
                  const SizedBox(width: 16),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userEntity!.name,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(userEntity.dni)
                      ])
                ])
              ])),
          const SizedBox(height: 16),
          PaymentMethod(
              metodo: _metodo,
              onChange: (value) => setState(() => _metodo = value)),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          FilledButton(
              onPressed: () {},
              child: Text('Copiar estructura de PayOrderButton'))
        ]));
  }
}
