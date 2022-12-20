import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum DialogAction { Ok, CANCEL }

class CustomAlertDialog {

  static Future<DialogAction> customDialog(BuildContext context, String title,
      String bodyText, String buttonText1, String? buttonText2, IconData imagePath,
      [Widget? widgetBody]) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          var localHeight = MediaQuery.of(context).size.height;
          var localWidth = MediaQuery.of(context).size.width;
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Stack(
                    children: [
                      Container(
                        height: localHeight * 0.25,
                        // padding: EdgeInsets.only(
                        //     top: localHeight * 0.12,
                        //     bottom: localHeight * 0.02,
                        //     right: localWidth * 0.025,
                        //     left: localWidth * 0.025),
                        margin: EdgeInsets.only(top: 26),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(17),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                                offset: Offset(0.0, 10.0),
                              ),
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            title != null
                                ? Column(
                              children: [
                                Center(
                                  child: Text(title,
                                    // style: GoogleFonts.poppins(
                                    //     fontSize: localHeight * 0.021,
                                    //     fontWeight: FontWeight.bold)
                                  ),
                                ),
                                SizedBox(
                                  height: localHeight * 0.01,
                                ),
                              ],
                            )
                                : Container(),
                            widgetBody != null
                                ? Column(
                              children: [
                                widgetBody,
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                              ],
                            )
                                : bodyText != null
                                ? Column(
                              children: [
                                Text(
                                  bodyText ?? "",
                                  // style: GoogleFonts.poppins(
                                  //     fontSize: localHeight * 0.018),
                                ),
                                SizedBox(
                                  height: localHeight * 0.02,
                                ),
                              ],
                            )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (buttonText1 != null)
                                  Container(
                                    // height: localHeight * 0.04,
                                    child:  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(DialogAction.Ok);
                                      },
                                      child: Text(
                                        buttonText1,
                                        style: const TextStyle(
                                            color: Color.fromRGBO(48, 145, 139, 1)
                                        ),
                                        // style: GoogleFonts.poppins(
                                        //     fontSize: localHeight * 0.02),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: localWidth * 0.04,
                                ),
                                if (buttonText2 != null)
                                  Container(
                                    // height: localHeight*0.04,
                                    child:  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                      ),

                                      onPressed: () {
                                        Navigator.of(context).pop(DialogAction.CANCEL);
                                      },
                                      child: Text(
                                        buttonText2,
                                        // style: GoogleFonts.poppins(
                                        //     fontSize: localHeight * 0.02),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: -13,
                          left: 5,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: localHeight * 0.045,
                            child:
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(226, 68, 0, 1),
                              ),
                              height: localHeight * 0.10,
                              width: localWidth * 0.10,
                              child: Icon(imagePath,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                            ),
                          ))
                    ])),
          );
        });
    return action;
  }
}