import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.height,
      required this.label,
      required this.hintValue,
      required this.icon,
      required this.textEditingController})
      : super(key: key);

  final double height;
  final String label;
  final String hintValue;
  final IconData icon;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                label,
                style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
                    const TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              ),
            ),
            SizedBox(
              height: height * 0.0001,
            ),
            Align(
                alignment: Alignment.center,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      helperStyle: const TextStyle(
                          color: Color.fromRGBO(102, 102, 102, 0.3),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      hintText: hintValue,
                      prefixIcon: Icon(icon,
                          color: const Color.fromRGBO(82, 165, 160, 1)),
                    ))),
          ],
        ),
      ],
    );
  }
}
