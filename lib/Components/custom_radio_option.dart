import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatefulWidget {
  IconData icon;
  final T value;
  final T? groupValue;
  final String label;

  final ValueChanged<T?> onChanged;

  MyRadioOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
    required this.icon,
  });

  @override
  State<MyRadioOption<T>> createState() => _MyRadioOptionState<T>();
}

class _MyRadioOptionState<T> extends State<MyRadioOption<T>> {
  Widget _buildLabel() {
    final bool isSelected = widget.value == widget.groupValue;
    double width = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: widget.value=='MCQ'?width * 0.09381:widget.value=='Survey'?width * 0.09381:width * 0.1381,
      height: height * 0.06,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color:
            isSelected ? const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(widget.icon,
            size: 14,
            color: isSelected
                ? Colors.white
                : const Color.fromRGBO(82, 165, 160, 1)),
        const SizedBox(width: 5),
        Text(
          widget.label.toString(),
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : const Color.fromRGBO(82, 165, 160, 1),
            fontSize: 14,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Row(
        children: [
          _buildLabel(),
        ],
      ),
    );
  }
}
