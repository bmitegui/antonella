import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/service/presentation/bloc/service/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key});

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late bool enable;
  late TextEditingController nameService;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    enable = false;
    nameService = TextEditingController();
    isLoading = false;
  }

  @override
  void dispose() {
    nameService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocConsumer<ServiceBloc, ServiceState>(listener: (context, state) {
      setState(() {
        if (state is ServicesLoaded) {
          enable = false;
          isLoading = false;
          if (!state.isFiltered) {
            nameService.clear();
          }
        } else if (state is ServicesError) {
          enable = false;
          isLoading = false;
        }
      });
    }, builder: (context, state) {
      return CustomTextFormFieldWidget(
          textEditingController: nameService,
          onChanged: (value) {
            setState(() {
              enable = value.trim().isNotEmpty;
            });
          },
          hintText: texts.what_looking_for,
          prefixIcon: const Icon(Icons.search),
          onTapOutside: (event) {
            setState(() {
              enable = false;
            });
            FocusScope.of(context).unfocus();
          },
          onEditingComplete: () {
            setState(() {
              enable = false;
              isLoading = true;
            });
            context
                .read<ServiceBloc>()
                .add(GetServicesEvent(name: nameService.text.trim()));
            FocusScope.of(context).unfocus();
          },
          suffixIcon: enable
              ? (isLoading)
                  ? Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 8),
                      child: const CircularProgressIndicator())
                  : GestureDetector(
                      child: const Icon(Icons.send),
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        context.read<ServiceBloc>().add(
                            GetServicesEvent(name: nameService.text.trim()));
                      })
              : null);
    });
  }
}
