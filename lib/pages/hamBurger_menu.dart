import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HamBurgerMenu extends StatefulWidget {
  const HamBurgerMenu({super.key});


  @override
  HamBurgerMenuState createState() => HamBurgerMenuState();
}
class HamBurgerMenuState extends State<HamBurgerMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double localWidth = MediaQuery
        .of(context)
        .size
        .width;
    double localHeight = MediaQuery
        .of(context)
        .size
        .height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: localWidth * 0.80,
              height: localHeight * 0.25,
              margin:  const EdgeInsets.only(right: 100),
              decoration: const BoxDecoration(
                  gradient:  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(0, 106, 100, 1),
                      Color.fromRGBO(82, 165, 160, 1),
                    ],
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: localHeight / 6,
                    child: Stack(children: [
                      Positioned(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01,
                         left: localWidth / 40,
                          child:
                          Row(
                              children:  [
                                CircleAvatar(
                                  backgroundColor: const Color.fromRGBO(0,106,100,0),
                            radius: MediaQuery
                                .of(context)
                                .size
                                .width * 0.15,
                                  child: Image.asset(
                                    "assets/images/ProfilePic_Avatar.png",
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  "Student Name",
                                  style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1
                                    ?.merge(const TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.02,
                                    fontSize: 16)),
                                )]),
                      ),
                    ]),
                  ),
              Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
                left: localWidth / 40,
                child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: localWidth * 0.09),
                        child: Text(
                          "Student",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(221, 221, 221, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 12)),
                        )
                      ),
                    ],
                  ),
              ),
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01,
                  left: localWidth / 80,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: localWidth * 0.09),
                        child: Text(
                          "Student@gmail.com",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(const TextStyle(
                              color: Color.fromRGBO(221, 221, 221, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 12)),
                        )
                      ),
                    ],
                  ),
              )],
              ),
            ),
            Flexible(
                child: ListView(
                  children: [
                    Container(
                      // width: localWidth * 0.80,
                      // height: localHeight * 0.25,
                      margin:  const EdgeInsets.only(right: 100),
                      child:  ListTile(
                          leading:
                          const Icon(
                              Icons.people_alt,
                              color: Color.fromRGBO(141, 167, 167, 1)),
                          title: Text("User Profile",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                ?.merge(TextStyle(
                                color: textColor,
                                //Color.fromRGBO(48, 145, 139, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.02,
                                fontSize: 16)),),
                          trailing:  const Icon(Icons.navigate_next,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: ListTile(
                          leading:
                          const Icon(
                              Icons.key_outlined,
                              color: Color.fromRGBO(141, 167, 167, 1)
                          ),
                          title: Text("Change Password",
                            style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: ListTile(
                          leading:
                          const Icon(
                            Icons.mail_outline_sharp,
                              color: Color.fromRGBO(141, 167, 167, 1)),
                          title: Text("Change Email ID",
                            style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                        trailing:  const Icon(Icons.navigate_next,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: const Divider(
                        thickness: 2,
                      ),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: ListTile(
                          leading:
                          const Icon(
                              Icons.translate,
                              color: Color.fromRGBO(141, 167, 167, 1)),
                          title: Text("Language",style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                          trailing:  const Icon(Icons.navigate_next,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () async {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: ListTile(
                          leading:
                          const Icon(
                              Icons.verified_user_outlined,
                              color: Color.fromRGBO(141, 167, 167, 1)),
                          title: Text("Privacy & Terms",style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                          trailing:  const Icon(Icons.navigate_next,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () async {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: const Divider(
                        thickness: 2,
                      ),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: ListTile(
                          leading:
                          const Icon(
                              Icons.note_alt_outlined,
                              color: Color.fromRGBO(141, 167, 167, 1)),
                          title: Text("Cookie Policy",style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText1
                              ?.merge(TextStyle(
                              color: textColor,
                              //Color.fromRGBO(48, 145, 139, 1),
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.02,
                              fontSize: 16)),),
                          trailing:  const Icon(Icons.navigate_next,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () async {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: ListTile(
                          leading:
                          const Icon(
                              Icons.perm_contact_calendar_outlined,
                              color: Color.fromRGBO(141, 167, 167, 1)),
                          title: Text("About Us",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1
                                ?.merge(TextStyle(
                                color: textColor,
                                //Color.fromRGBO(48, 145, 139, 1),
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.02,
                                fontSize: 16)),),
                          trailing:  const Icon(Icons.navigate_next,
                              color: Color.fromRGBO(153, 153, 153, 1)),
                          onTap: () async {
                          }),
                    ),
                    Container(
                      margin:  const EdgeInsets.only(right: 100),
                      child: const Divider(
                      thickness: 2,
                    ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}