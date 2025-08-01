import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/promotion_cart/promotion_cart_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/label_detail_service_widget.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PromotionViewDetails extends StatelessWidget {
  final PromotionEntity promotionEntity;
  const PromotionViewDetails({super.key, required this.promotionEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
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
                onPressed: () {
                  sl<PromotionCartBloc>().add(AddPromotionToCartEvent(
                      promotionEntity: promotionEntity));
                  showTopSnackBar(Overlay.of(context),
                      CustomSnackBar.success(message: texts.product_added));
                  Navigator.pop(context);
                },
                text: texts.add_to_cart)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 16),
              ImagesScrollview(
                  images: promotionEntity.images,
                  height: MediaQuery.of(context).size.height / 2),
              SizedBox(height: 16),
              CustomTitle(title: "Descripción"),
              Text(promotionEntity.description),
              SizedBox(height: 16),
              SizedBox(height: 16),
              CustomTitle(title: "Servicios incluidos"),
              Column(
                  children: promotionEntity.serviceItems.map((item) {
                final service = item.serviceEntity;

                return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(service.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text(service.description,
                                  maxLines: 3, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              LabelDetailServiceWidget(
                                  category: getCategoryText(
                                      context: context,
                                      serviceCategory: service.type),
                                  rating: service.rating,
                                  duration: service.duration),
                              const SizedBox(height: 8),
                              if (item.discount != null)
                                Text("Descuento: ${item.discount! * 100}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.red)),
                              if (item.fixedAmount != null)
                                Text("Monto fijo: \$${item.fixedAmount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.red))
                            ])));
              }).toList())
            ])));
  }
}
