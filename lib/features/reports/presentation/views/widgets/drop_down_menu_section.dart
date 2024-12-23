import 'package:flutter/material.dart';

class DropDownMenuSection<T> extends StatelessWidget {
  const DropDownMenuSection({super.key, required this.values, this.onSelected});

  final List<T> values;
  final void Function(T? value)? onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      onSelected: onSelected,
      initialSelection: values[0],
      expandedInsets: EdgeInsets.all(10),
      width: MediaQuery.sizeOf(context).width * .75,
      menuHeight: MediaQuery.sizeOf(context).height * .75,
      dropdownMenuEntries: List<DropdownMenuEntry<T>>.generate(
        values.length,
        (int index) {
          return DropdownMenuEntry<T>(
            value: values[index],
            label: values[index].toString(),
          );
        },
      ),
    );
  }
}
