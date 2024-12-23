import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  const NumberPicker({super.key, required this.onChanged, required this.maxValue, required this.initNumber, required this.minValue});

  final void Function(int number) onChanged;
  final int maxValue;
  final int minValue;
  final int initNumber;

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int quan;
  late final int maxValue;
  late final int minValue;

  @override
  void initState() {
    minValue = widget.minValue;
    maxValue = widget.maxValue;
    quan = widget.initNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        getContainer(
          onTap: () {
            quan--;
            quan = quan.clamp(minValue, maxValue);
            widget.onChanged(quan);
            setState(() {});
          },
          icon: Icons.remove,
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 45,
          child: Center(child: Text(quan.toString())),
        ),
        const SizedBox(width: 5),
        getContainer(
          onTap: () {
            quan++;
            quan = quan.clamp(minValue, maxValue);
            widget.onChanged(quan);
            setState(() {});
          },
          icon: Icons.add,
        ),
      ],
    );
  }

  Widget getContainer({required final void Function() onTap, required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.3), blurStyle: BlurStyle.normal, blurRadius: 5, offset: const Offset(0, 3), spreadRadius: 0),
          ],
        ),
        child: Icon(icon, color: Colors.grey, size: 24),
      ),
    );
  }
}
