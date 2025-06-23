import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/list_service_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormServiceSelectedWidget extends StatelessWidget {
  const FormServiceSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? CustomModalBottomSheetWidget(
              closeAction: false,
              title: state.service.name,
              body: Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    CustomTitle(
                        title: 'Categoría:',
                        description: getCategoryText(
                            context: context,
                            serviceCategory: state.service.type)),
                    const SizedBox(height: 8),
                    CustomTitle(
                        title: 'Valor aproximado:',
                        description:
                            '\$${state.service.minPrice} - ${state.service.maxPrice}'),
                    const SizedBox(height: 8),
                    ListServiceFormsWidget()
                  ]))))
          : const CircularProgressIndicator();
    });
  }
}
