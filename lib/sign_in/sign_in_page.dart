import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/sign_in/sign_in_button.dart';
import 'package:parental_control/sign_in/sign_in_manager.dart';
import 'package:parental_control/sign_in/social_sign_in_button.dart';
import 'package:provider/provider.dart';

import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({
    Key? key,
    required this.manager,
    required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  ///Here we had the provider wrapping the Sign in Page
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  ///----------------------------------------------------------------------
  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'error_on_signing'.tr, exception: exception);
  }

  ///Future void Function called to Sign In Anonymously
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  ///Future void Function called to Sign In with Google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  ///Future void Function called to Sign In with Facebook
  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }


  ///Future void Function called to Sign In with Email and password
  ///
  ///[fullscreenDialog] gives the orientation that the page will have while created
  ///from bottom to to if false or slide on the side (ONLY FOR IOS)
  Future<void>? _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        fullscreenDialog: true, builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 180.0, child: _buildHeader()),
            // SizedBox(height: 28.0),
            // SocialSignInButton(
            //   assetName: 'images/google-logo.png',
            //   text: 'Google hisob bilan login',
            //   textColor: Colors.black87,
            //   color: Colors.white,
            //   onPressed: isLoading ? () {}  : () => _signInWithGoogle(context),
            // ),
            // SizedBox(height: 8.0),
            // SocialSignInButton(
            //   assetName: 'images/facebook-logo.png',
            //   text: 'Facebook bilan login',
            //   textColor: Colors.white,
            //   color: Color(0xFF334D92),
            //   onPressed: isLoading ? () {} : () => _signInWithFacebook(context),
            // ),
            // SizedBox(height: 8.0),
            SignInButton(
              text: 'login_with_email'.tr,
              textColor: Colors.white,
              color: Colors.teal[700] ?? Colors.black,
              onPressed: isLoading ? () {} : () => _signInWithEmail(context),
            ),
            // SizedBox(height: 8.0),
            // SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Image.asset(
      'images/splash_svg/clip-sign-up.png',
    );
  }
}
