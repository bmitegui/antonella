import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/employees_selected_widget.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/form/form_service_selected_widget.dart';
import 'package:antonella/features/user/presentation/bloc/employees/employees_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListServicesSelectedWidget extends StatefulWidget {
  const ListServicesSelectedWidget({super.key});

  @override
  State<ListServicesSelectedWidget> createState() => _ListServicesSelectedWidgetState();
}

class _ListServicesSelectedWidgetState extends State<ListServicesSelectedWidget> {
  bool isSelected = false;
  
  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return state.services.isNotEmpty
            ? SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: ExpansionPanelList.radio(
                        children: state.services.map((service) {
                      return ExpansionPanelRadio(
                          backgroundColor: Colors.white,
                          canTapOnHeader: true,
                          value: service.id,
                          headerBuilder: (context, isExpanded) => Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 12),
                              child: Row(children: [
                                CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        Environment.apiUrl +
                                            service.images[0])),
                                const SizedBox(width: 20),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Text(
                                          getCategoryText(
                                              context: context,
                                              serviceCategory: service.type),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Text(service.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis)
                                    ]))
                              ])),
                          body: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text(
                                              '\$${service.minPrice} - ${service.maxPrice}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!),
                                          const SizedBox(height: 8),
                                          Text(service.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(color: Colors.grey))
                                        ])),
                                    const SizedBox(width: 16),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                sl<ServiceFormBloc>().add(
                                                    SelectServiceEvent(
                                                        service: service));
                                                await showModalBottomSheet<List>(
                                                    scrollControlDisabledMaxHeightRatio:
                                                        1,
                                                    isScrollControlled: true,
                                                    backgroundColor: Colors.white,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return FormServiceSelectedWidget(
                                                          isDescription: false);
                                                    });
                                              },
                                              icon: Icon(Icons.edit,
                                                  color: Color(0xFFE596A9),
                                                  size: 32)),
                                          IconButton(
                                              onPressed: () async =>
                                                  await showWarningDialog(
                                                      context: context,
                                                      title: texts.delete_service,
                                                      message:
                                                          texts.sure_delete_service,
                                                      textOnAccept: texts.eliminate,
                                                      onAccept: () => context
                                                          .read<
                                                              ServicesSelectedBloc>()
                                                          .add(DeleteServiceEvent(
                                                              service: service))),
                                              icon: Icon(Icons.delete_outline,
                                                  color: Colors.red, size: 32))
                                        ])
                                  ]),
                                  SizedBox(height: 8),
                                  CustomElevatedButton(
                                    onPressed: () async {
                                      sl<EmployeesBloc>().add(
                                          GetEmployeesEvent(
                                              serviceType: service.type));
                                      await showModalBottomSheet<List>(
                                          scrollControlDisabledMaxHeightRatio:
                                              1,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return EmployeesSelectedWidget(
                                                service: service,
                                                onSelected: (data) {
                                                  setState(() {
                                                    isSelected = data;
                                                  });
                                                });
                                          });
                                    }, 
                                    text: "Elegir Especialista",
                                    backgroundColor: (isSelected) ? Colors.green : const Color(0xFFF44565))
                                ],
                              )));
                    }).toList())))
            : Center(child: Text(texts.no_service_selected));
      }
      return const SizedBox.shrink();
    });
  }
}
