import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height * 0.075,
      width: MediaQuery.of(context).size.width * 0.075,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(102, 102, 102, 0.3))
      ),
      child: Row(
          children: const [
            TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  helperStyle: TextStyle(color: Color.fromRGBO(102, 102, 102, 0.3),fontFamily: 'Inter',fontWeight: FontWeight.w400,fontSize: 16),
                  hintText: "Your Reg ID / Email ID",
                  prefixIcon: Icon(
                      Icons.contacts_outlined,color: Color.fromRGBO(82, 165, 160, 1)),
                )
            )
          ]
      ),
    );
  }
}
