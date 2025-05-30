import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

class CustomDropdownSearchWidget extends StatelessWidget {
  final String title;
  final String? selectedItem;
  final String initialText;
  final List<String> options;
  final Function(String) onChange;
  final String? Function(String?)? validator;
  final bool showSearchBox;
  const CustomDropdownSearchWidget(
      {super.key,
      required this.title,
      this.selectedItem,
      required this.initialText,
      required this.options,
      required this.onChange,
      this.showSearchBox = true,
      this.validator});

  @override
  Widget build(BuildContext context) {
    //final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black))),
      const SizedBox(height: 8),
      DropdownSearch<String>(
        decoratorProps: DropDownDecoratorProps(decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none
          ))
          ),
          selectedItem: selectedItem,
          validator: validator,
          onChanged: (value) {
            if (value != null) {
              onChange(value);
            }
          },
          dropdownBuilder: (context, selectedItem) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(selectedItem ?? initialText)),
          items: (filter, infiniteScrollProps) => options,
          popupProps: PopupProps.menu(
              searchFieldProps: const TextFieldProps(),
              showSelectedItems: true,
              itemBuilder: (context, item, isDisabled, isSelected) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: isSelected ? colorScheme.primary : null),
                  child: Text(item,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isSelected ? colorScheme.onPrimary : null))),
              menuProps: const MenuProps(),
              emptyBuilder: (context, searchEntry) => Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                      Text('No se encontró nada', textAlign: TextAlign.center)),
              showSearchBox: showSearchBox,
              fit: FlexFit.loose))
    ]);
  }
}