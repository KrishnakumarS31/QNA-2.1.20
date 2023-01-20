import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatefulWidget {
  IconData icon;
  final T value;
  final T? groupValue;
  final String label;

  final ValueChanged<T?> onChanged;

   MyRadioOption({super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged, required this.icon,
  });

  @override
  State<MyRadioOption<T>> createState() => _MyRadioOptionState<T>();
}

class _MyRadioOptionState<T> extends State<MyRadioOption<T>> {
  Widget _buildLabel() {
    final bool isSelected = widget.value == widget.groupValue;
    return Container(
      width:100,
      height: 50,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
       // border: Border.all(
       //   color: const Color.fromRGBO(82, 165, 160, 1),
       // ),
        color: isSelected ? const Color.fromRGBO(82, 165, 160, 1) : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Icon(
            widget.icon,
        size: 14,
        color: isSelected ? Colors.white : const Color.fromRGBO(82, 165, 160, 1) ),
          const SizedBox(width: 5),
          Text(
          widget.value.toString(),
          style: TextStyle(
            //color:  Color.fromRGBO(82, 165, 160, 1),
            color: isSelected ? Colors.white  : const Color.fromRGBO(82, 165, 160, 1),
            fontSize: 14,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 11),
      child: InkWell(
        onTap: () => widget.onChanged(widget.value),
            child: Row(
            children: [
              _buildLabel(),
              //const SizedBox(width: 10),
            ],
          ),
      ),
    );
  }
}