import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/user/presentation/bloc/card/card_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/cards/cards_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:antonella/features/user/presentation/widgets/card_text_format_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import './card_input_formatter.dart';
import './card_month_input_formatter.dart';
import './master_card.dart';
import './my_painter.dart';

class CardMain extends StatefulWidget {
  const CardMain({super.key});

  @override
  State<CardMain> createState() => _CardMainState();
}

class _CardMainState extends State<CardMain> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  final Color kDarkBlue = Color(0xFF090943);

  final FlipCardController flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: ArrowBack(),
      text: "Añadir tarjeta",
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              FlipCard(
                  fill: Fill.fillFront,
                  direction: FlipDirection.HORIZONTAL,
                  controller: flipCardController,
                  onFlip: () {},
                  flipOnTouch: false,
                  onFlipDone: (isFront) {},
                  front: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildCreditCard(
                      color: kDarkBlue,
                      cardExpiration: cardExpiryDateController.text.isEmpty
                          ? "XX/XXXX"
                          : cardExpiryDateController.text,
                      cardHolder: cardHolderNameController.text.isEmpty
                          ? "Card Holder"
                          : cardHolderNameController.text.toUpperCase(),
                      cardNumber: cardNumberController.text.isEmpty
                          ? "XXXX XXXX XXXX XXXX"
                          : cardNumberController.text,
                    ),
                  ),
                  back: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      elevation: 4.0,
                      color: kDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 230,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 0),
                            const Text(
                              'https://www.paypal.com',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            ),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            CustomPaint(
                              painter: MyPainter(),
                              child: SizedBox(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cardCvvController.text.isEmpty
                                          ? "XXX"
                                          : cardCvvController.text,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // const Text(
                            //   'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
                            //   style: TextStyle(
                            //     color: Colors.white54,
                            //     fontSize: 11,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 40),
              CardTextFormatWidget(
                  onChanged: (value) {
                    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                    setState(() {
                      cardNumberController.value = cardNumberController.value
                          .copyWith(
                              text: text,
                              selection:
                                  TextSelection.collapsed(offset: text.length),
                              composing: TextRange.empty);
                    });
                  },
                  textController: cardNumberController,
                  hintText: 'Card Number',
                  prefixIcon: Icon(
                    Icons.credit_card,
                    color: Colors.grey,
                  ),
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CardInputFormatter(),
                  ],
                  width: MediaQuery.of(context).size.width / 1.12),
              const SizedBox(height: 12),
              CardTextFormatWidget(
                textController: cardHolderNameController,
                onChanged: (value) {
                  var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                  setState(() {
                    cardHolderNameController.value =
                        cardHolderNameController.value.copyWith(
                            text: text,
                            selection:
                                TextSelection.collapsed(offset: text.length),
                            composing: TextRange.empty);
                  });
                },
                hintText: 'Full Name',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                width: MediaQuery.of(context).size.width / 1.12,
                type: TextInputType.name,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: cardExpiryDateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'MM/YY',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        CardDateInputFormatter(),
                      ],
                      onChanged: (value) {
                        var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          cardExpiryDateController.value =
                              cardExpiryDateController.value.copyWith(
                                  text: text,
                                  selection: TextSelection.collapsed(
                                      offset: text.length),
                                  composing: TextRange.empty);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: cardCvvController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'CVV',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onTap: () {
                        setState(() {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            flipCardController.toggleCard();
                          });
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          int length = value.length;
                          if (length == 4 || length == 9 || length == 14) {
                            cardNumberController.text = '$value ';
                            cardNumberController.selection =
                                TextSelection.fromPosition(
                                    TextPosition(offset: value.length + 1));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20 * 3),
              BlocConsumer<CardBloc, CardState>(listener: (context, state) {
                if (state is CardLoaded) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    cardCvvController.clear();
                    cardExpiryDateController.clear();
                    cardHolderNameController.clear();
                    cardNumberController.clear();
                    flipCardController.toggleCard();
                  });
                  setState(() {});
                  showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.success(
                          message: 'Tarjeta añadida correctamente'));

                  final stateUser = sl<UserBloc>().state;
                  if (stateUser is UserAuthenticated) {
                    context
                        .read<CardsBloc>()
                        .add(GetCardsEvent(userId: stateUser.user.id));
                  }
                } else if (state is CardError) {
                  showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                          message: mapFailureToMessage(
                              context: context, failure: state.failure)));
                }
              }, builder: (context, state) {
                return (state is AddCardLoading)
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: Size(
                              MediaQuery.of(context).size.width / 1.12, 55),
                        ),
                        onPressed: () {
                          final stateUser = sl<UserBloc>().state;
                          if (stateUser is UserAuthenticated) {
                            final date =
                                cardExpiryDateController.text.split('/');

                            context.read<CardBloc>().add(AddCardEvent(
                                userId: stateUser.user.id,
                                number: cardNumberController.text
                                    .replaceAll(RegExp(r"\s+"), ""),
                                expiryMonth: int.parse(date[0]),
                                expiryYear: int.parse('20${date[1]}'),
                                cvc: cardCvvController.text));
                          }
                        },
                        child: Text(
                          'Añadir tarjeta'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
