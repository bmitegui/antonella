import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_text_form_field_widget.dart';
import 'package:antonella/features/service/presentation/bloc/service/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({super.key});

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  late bool enable;
  late TextEditingController nameService;

  @override
  void initState() {
    super.initState();
    enable = false;
    nameService = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
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
            });
            FocusScope.of(context).unfocus();
          },
          suffixIcon: enable
              ? GestureDetector(
                  child: const Icon(Icons.send),
                  onTap: () {
                    showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                            message: texts.not_implemented_yet));
                  })
              : null);
      }
    );
    
  }
}
