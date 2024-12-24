import 'package:flutter/material.dart';

class DropDownMenuSection<T> extends StatelessWidget {
  const DropDownMenuSection({super.key, required this.values, this.onSelected, this.horizontalPadding = 15, required this.initialSelection, this.labels});

  final List<T> values;
  final List<String>? labels;

  final void Function(T? value)? onSelected;
  final double horizontalPadding;
  final T initialSelection;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      onSelected: onSelected,
      initialSelection: initialSelection,
      expandedInsets: EdgeInsets.all(horizontalPadding),
      width: MediaQuery.sizeOf(context).width * .75,
      menuHeight: MediaQuery.sizeOf(context).height * .75,
      dropdownMenuEntries: List<DropdownMenuEntry<T>>.generate(
        values.length,
        (int index) {
          return DropdownMenuEntry<T>(
            value: values[index],
            label: labels == null ? values[index].toString() : labels![index],
          );
        },
      ),
    );
  }
}
