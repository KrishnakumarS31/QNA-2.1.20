import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qna_test/pages/settings_languages.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../pages/cookie_policy.dart';
import '../pages/privacy_policy_hamburger.dart';
import '../pages/terms_of_services.dart';
import '../pages/about_us.dart';
import '../pages/help_page.dart';
import '../DataSource/http_url.dart';

class EndDrawerMenuPreLogin extends StatefulWidget {
  const EndDrawerMenuPreLogin({Key? key})
      : super(key: key);


  @override
  State<EndDrawerMenuPreLogin> createState() => _EndDrawerMenuPreLoginState();
}

class _EndDrawerMenuPreLoginState extends State<EndDrawerMenuPreLogin> {
  @override
  Widget build(BuildContext context) {
    double localHeight = MediaQuery.of(context).size.height;
    Color textColor = const Color.fromRGBO(48, 145, 139, 1);
    return Drawer(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        children: [
          Flexible(
            child: ListView(
              children: [
                // ListTile(
                //     leading: const Icon(Icons.chevron_left,
                //         size: 40,
                //         color: Color.fromRGBO(28, 78, 80, 1)),
                //     onTap: () async {
                //       Navigator.of(context).pop();
                //     }),
                ListTile(
                    leading: const Icon(Icons.translate,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.language,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          
                          fontSize: 16),
                    ),
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const SettingsLanguages(),
                        ),
                      );
                    }),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                    leading: const Icon(Icons.verified_user_outlined,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.privacy_and_terms,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const PrivacyPolicyHamburger(
                              ),
                        ),
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.library_books_sharp,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.terms_of_services,
                      //'Terms of Services',
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          
                          fontSize: 16),
                    ),
                    
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const TermsOfServiceHamburger(
                              ),
                        ),
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.note_alt_outlined,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.cookie_policy,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          
                          fontSize: 16),
                    ),
                    
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const CookiePolicy(),
                        ),
                      );
                    }),
                const Divider(
                  thickness: 2,
                ),
                ListTile(
                    leading: const Icon(Icons.perm_contact_calendar_outlined,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.about_us,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge
                          ?.merge(TextStyle(
                              color: textColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              
                              fontSize: 16)),
                    ),
                    
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const AboutUs(),
                        ),
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.help_outline,
                        color: Color.fromRGBO(141, 167, 167, 1)),
                    title: Text(
                      AppLocalizations.of(context)!.help,
                      style: TextStyle(
                          color: textColor,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          
                          fontSize: 16),
                    ),
                    
                    onTap: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const HelpPageHamburger(),
                        ),
                      );
                    }),
                SizedBox(height: localHeight * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${AppLocalizations.of(context)!.version}: $version",
                    style: const TextStyle(
                        color: Color.fromRGBO(180, 180, 180, 1),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: localHeight * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
