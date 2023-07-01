import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:parental_control/app/pages/change_profile_page.dart';
import 'package:parental_control/app/pages/contacts_page.dart';
import 'package:parental_control/app/splash/splash_screen.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/shared_preferences.dart';
import 'package:parental_control/theme/theme.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, this.title, this.name, this.email, required this.context, required this.auth}) : super(key: key);
  final BuildContext context;
  final AuthBase auth;
  final String? title;
  final String? name;
  final String? email;

  static Future<void> show(BuildContext context, AuthBase auth) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => SettingsPage(context: context, auth: auth),
      ),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _signOut(BuildContext context, AuthBase auth) async {
    try {
      // await auth.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Logger().e(toString());
    }
  }

  Future<void> confirmSignOut(BuildContext context, AuthBase auth) async {
    final didRequestSignOut =
        await showAlertDialog(context, title: 'exit'.tr, content: 'sure_to_exit'.tr, defaultActionText: 'exit'.tr, cancelActionText: 'cancel'.tr);
    if (didRequestSignOut == true) {
      await _signOut(context, auth);
      SharedPreference().setParentDevice(value: null);
      SharedPreference().setVisitingFlag(value: false);
      Get.offAll(() => SplashScreen());
    }
  }

  Widget buildItems(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: LineAwesomeIcons.history,
            onPressed: () {
              Get.to(() => ChangeProfilePage());
            },
            text: 'update_profile'.tr,
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.language,
            onPressed: () async {
              String locale = await SharedPreference().getLocale();
              Logger().w(locale);
              showDialog(
                  context: context,
                  builder: (builder) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 400),
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("change_language".tr, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                            SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      setState(() async {
                                        await SharedPreference().setLocale("uz");
                                        Get.back();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: locale == "uz" ? Colors.indigo : Colors.white,
                                        border: Border.all(color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "O'zbek",
                                          style: TextStyle(color: locale == "uz" ? Colors.white : Colors.indigo),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {
                                      setState(() async {
                                        await SharedPreference().setLocale("ru");
                                        Get.back();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: locale == "ru" ? Colors.indigo : Colors.white,
                                        border: Border.all(color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Русский",
                                          style: TextStyle(color: locale == "ru" ? Colors.white : Colors.indigo),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            text: 'change_language'.tr,
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.moon,
            onPressed: () {},
            text: 'dark_mode'.tr,
            onDeveloping: true,
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.alternate_sign_out,
            onPressed: () => confirmSignOut(context, widget.auth),
            text: 'exit'.tr,
            hasNavigation: false,
          ),
          ProfileListItem(
            icon: LineAwesomeIcons.user_shield,
            onPressed: () {
              Get.to(() => ContactsPage());
            },
            text: 'contact_us'.tr,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, bottom: 8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                buildItems(context),
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.contact_support_sharp),
                    onPressed: () {},
                  ),
                  trailing: Text(
                    'programmer'.trArgs(["Jasurbek Kurganbayev"]),
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final bool onDeveloping;
  final VoidCallback onPressed;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.hasNavigation = true,
    this.onDeveloping = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 25,
              color: Colors.indigo,
            ),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyles.body,
            ),
            Spacer(),
            if (hasNavigation)
              onDeveloping
                  ? Container(
                      width: 135,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(child: Text("in_developing".tr, style: TextStyle(color: Colors.white))),
                    )
                  : Icon(
                      LineAwesomeIcons.alternate_arrow_circle_right,
                      size: 25,
                      color: Colors.indigo,
                    ),
          ],
        ),
      ),
    );
  }
}
