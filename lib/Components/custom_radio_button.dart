import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;
  final double height;
  final double width;
  final BuildContext context;

  const CustomRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.label,
      required this.text,
      required this.onChanged,
      required this.height,
      required this.width,
      required this.context});

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;
    return Container(
      width: width * 0.07,
      height: height * 0.04,
      decoration: ShapeDecoration(
        shape: const CircleBorder(
          side: BorderSide(color: Color.fromRGBO(82, 165, 160, 1)),
        ),
        color:
            isSelected ? const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
      ),
      child: Center(
          child: isSelected
              ? const Icon(Icons.done, size: 25, color: Colors.white)
              : null),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
          const TextStyle(
              color: Color.fromRGBO(82, 165, 160, 1),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 22)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: height * 0.068, bottom: height * 0.008, top: height * 0.008),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: width * 0.2,
            // ),
            _buildLabel(),
            const SizedBox(width: 10),
            _buildText(),
          ],
        ),
      ),
    );
  }
}
