import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_icon_button.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/form_service_selected_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListServicesSelectedWidget extends StatelessWidget {
  const ListServicesSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesSelectedBloc, ServicesSelectedState>(
        builder: (context, state) {
      if (state is ServicesSelectedLoaded) {
        return state.listServicesSelected.isNotEmpty
            ? SingleChildScrollView(
                child: ExpansionPanelList.radio(
                    children: state.listServicesSelected.map((service) {
                return ExpansionPanelRadio(
                    backgroundColor: Colors.white,
                    canTapOnHeader: true,
                    value: service.id,
                    headerBuilder: (context, isExpanded) => Padding(
                        padding:
                            const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                        child: Row(children: [
                          CircleAvatar(
                              foregroundImage: NetworkImage(service.urlImage)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(service.category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(service.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)
                              ]))
                        ])),
                    body: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: Row(children: [
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                    '\$${service.minPrice} - ${service.maxPrice}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        ),
                                const SizedBox(height: 8),
                                Text(service.description)
                              ])),
                          const SizedBox(width: 16),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomIconButton(
                                    iconData: Icons.edit,
                                    onTap: () async {
                                      sl<ServiceFormBloc>().add(
                                          GetListServiceFormEvent(
                                              serviceEntity: service));
                                      await showModalBottomSheet<List>(
                                          scrollControlDisabledMaxHeightRatio:
                                              1,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return FormServiceSelectedWidget(
                                                serviceEntity: service);
                                          });
                                    }),
                                const SizedBox(height: 12),
                                CustomIconButton(
                                    color: Colors.red,
                                    iconData: Icons.delete,
                                    onTap: () async => await showWarningDialog(
                                        context: context,
                                        title: 'Eliminar servicio',
                                        message:
                                            '¿Está seguro que desea eliminar el servicio seleccionado?',
                                        textOnAccept: 'Eliminar',
                                        onAccept: () => context
                                            .read<ServicesSelectedBloc>()
                                            .add(DeleteServiceSelectedEvent(
                                                serviceEntitySelected: service,
                                                listServicesSelected:
                                                    state.listServicesSelected,
                                                dateSelected:
                                                    state.dateSelected,
                                                timeSelected:
                                                    state.timeSelected))))
                              ])
                        ])));
              }).toList()))
            : const Center(child: Text('No hay servicios seleccionados'));
      }
      return const SizedBox.shrink();
    });
  }
}
