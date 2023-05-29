import 'package:flutter/foundation.dart';
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
      width: width > 400
          ? 400 * 0.05
          :width * 0.09,
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
              ? Icon(Icons.done, size: width> 500
              ? 25
              : 15,
              color: Colors.white)
              : null),
    );
  }

  Widget _buildText() {

    return SizedBox(
      width: width > 500
          ? width * 0.35
          : width * 0.3,
      child: Text(
        text,
        style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
            TextStyle(
                color: const Color.fromRGBO(82, 165, 160, 1),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: height * 0.03)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
           bottom: height * 0.008, top: height * 0.008),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLabel(),
            SizedBox(
              width: width> 500
                  ? 0
                  : width * 0.03),
            _buildText(),
          ],
        ),
      ),
    );}}
