import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.button})
      : super(key: key);
  final String title;
  final String content;
  final String button;
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      color: Colors.black12,
      child: Stack(alignment: Alignment.center, children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2.0),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          margin: const EdgeInsets.all(5.0),
          height: height * 0.1625,
          width: width * 0.88,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                widget.title,
                style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
                    const TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
              ),
              Text(
                widget.content,
                style: Theme.of(context).primaryTextTheme.bodyLarge?.merge(
                    const TextStyle(
                        color: Color.fromRGBO(51, 51, 51, 1),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 15)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  widget.button,
                  style: TextStyle(
                      color: const Color.fromRGBO(48, 145, 139, 1),
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.w500),
                  // style: GoogleFonts.poppins(
                  //     fontSize: localHeight * 0.02),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: height * 0.385,
            left: width * 0.10,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: height * 0.045,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(226, 68, 0, 1),
                ),
                height: height * 0.10,
                width: width * 0.10,
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ))
      ]),
    );
  }
}

// class CustomPopup{
//
//   static customDialog(BuildContext context) async {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//       height: height * 0.03,
//       width: width * 0.06,
//       color:  Colors.amberAccent,
//     );
//   }
// }
