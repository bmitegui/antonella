import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_service_forms_widget.dart';
import 'package:flutter/material.dart';

class FormServiceSelectedWidget extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const FormServiceSelectedWidget({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
        closeAction: false,
        title: serviceEntity.name,
        body: Expanded(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              CustomTitle(
                  title: 'Categoría:',
                  description: serviceEntity.category.name),
              const SizedBox(height: 8),
              CustomTitle(
                  title: 'Valor aproximado:',
                  description:
                      '\$${serviceEntity.minPrice} - ${serviceEntity.maxPrice}'),
              const SizedBox(height: 8),
              ListServiceFormsWidget(serviceEntity: serviceEntity)
            ]))));
  }
}
