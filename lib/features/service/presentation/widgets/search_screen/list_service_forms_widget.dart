import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/core/widgets/custom_title_separator_widget.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/buttons_end_form_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/input_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/is_select_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/list_photos_widget.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/select_photos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListServiceFormsWidget extends StatelessWidget {
  final ServiceEntity serviceEntity;
  const ListServiceFormsWidget({super.key, required this.serviceEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
      return (state is ServiceFormLoaded)
          ? Column(
              children: state.listServiceForms.asMap().entries.map((entry) {
                    final index = entry.key;
                    final serviceFormEntity = entry.value;
                    return buildFormByType(
                        serviceFormEntity: serviceFormEntity,
                        indexForm: (index + 1).toString());
                  }).toList() +
                  [
                    const Divider(),
                    ButtonsEndFormWidget(
                        listServiceForms: state.listServiceForms,
                        serviceEntity: serviceEntity)
                  ])
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }

  Widget buildFormByType(
      {required ServiceFormEntity serviceFormEntity,
      required String indexForm}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(children: [
          CustomTitle(title: serviceFormEntity.title, index: indexForm),
       
          const SizedBox(height: 16),
          (serviceFormEntity.type == 'uploadPhotos')
              ? ListPhotosWidget(serviceFormEntity: serviceFormEntity)
              : (serviceFormEntity.type == 'selectPhotos')
                  ? SelectPhotosWidget(serviceFormEntity: serviceFormEntity)
                  : (serviceFormEntity.type == 'isSelected')
                      ? IsSelectWidget(serviceFormEntity: serviceFormEntity)
                      : (serviceFormEntity.type == 'input')
                          ? InputWidget(serviceFormEntity: serviceFormEntity)
                          : const SizedBox.shrink()
        ]));
  }
}
