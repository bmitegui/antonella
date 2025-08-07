import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:antonella/features/service/presentation/promotion_cart/promotion_cart_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/service_promotion_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PromotionViewDetails extends StatelessWidget {
  final PromotionEntity promotionEntity;
  final void Function(bool data)? selected;
  const PromotionViewDetails({super.key, required this.promotionEntity, this.selected});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      bool allServicesSelected = false;

      if (state is ServicesSelectedLoaded) {
        final selectedServiceIds = state.services.map((s) => s.id).toSet();
        final requiredServiceIds = promotionEntity.serviceItems
            .map((item) => item.serviceEntity.id)
            .toSet();

        allServicesSelected =
            requiredServiceIds.difference(selectedServiceIds).isEmpty;
      }

      return CustomScaffold(
          text: promotionEntity.title,
          paddingScroll: EdgeInsets.all(0),
          leading: ArrowBack(),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
            child: CustomElevatedButton(
              onPressed: allServicesSelected
                  ? () {
                      sl<PromotionCartBloc>().add(AddPromotionToCartEvent(
                          promotionEntity: promotionEntity));
                      showTopSnackBar(Overlay.of(context),
                          CustomSnackBar.success(message: texts.product_added));
                      selected!(true);
                      Navigator.pop(context);
                    }
                  : null,
              text: texts.add_to_cart,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    ImagesScrollview(
                        images: promotionEntity.images,
                        height: MediaQuery.of(context).size.height / 2),
                    SizedBox(height: 16),
                    CustomTitle(title: "Descripción"),
                    SizedBox(height: 16),
                    Text(promotionEntity.description),
                    SizedBox(height: 16),
                    CustomTitle(title: "Servicios incluidos"),
                    Column(
                        children: promotionEntity.serviceItems
                            .map((serviceItemEntity) => ServicePromotionInfo(
                                  service: serviceItemEntity.serviceEntity,
                                  serviceItemEntity: serviceItemEntity,
                                ))
                            .toList())
                  ])));
    });
  }
}
