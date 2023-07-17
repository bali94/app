import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juba/constants.dart' as Constants;
import 'package:email_validator/email_validator.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/userProvider.dart';
import 'package:juba/theme/app_colors.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';

class PasswordForgotPage extends StatefulWidget {
  const PasswordForgotPage({Key? key}) : super(key: key);

  @override
  _PasswordForgotState createState() => _PasswordForgotState();
}

class _PasswordForgotState extends State<PasswordForgotPage> {
  late final GlobalKey _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _repeatEmailController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _repeatEmailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _repeatEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    var userProvider = context.watch<UserProvider>();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GlobalWidgets().simpleBackButton(context, globalProvider, width),
            Center(
              child: GlobalWidgets().text(S.of(context).newPw,
                  textColor: globalProvider.getTheme().colorScheme.secondary,
                  fontSize: Constants.kBigSize),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      style: BorderStyle.solid,
                      width: 4,
                      color: Constants.kWhiteColor,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: S.of(context).forgotPassw,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              wordSpacing: 1.5,
                              height: 1.4,
                              color: globalProvider
                                  .getTheme()
                                  .colorScheme
                                  .secondary,
                              fontSize: kMediumSize,
                              fontFamily: kFontFamily,
                            ),
                          ),
                          TextSpan(
                            text:
                                S.of(context).requestResponse,
                            style: TextStyle(
                              wordSpacing: 1.5,
                              height: 1.4,
                              fontSize: Constants.kMediumSize,
                              color: globalProvider
                                  .getTheme()
                                  .colorScheme
                                  .secondary,
                              fontFamily: kFontFamily,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _validateEmail,
                        enableSuggestions: true,
                        autocorrect: false,
                        cursorColor: Constants.kWhiteColor,
                        decoration: InputDecoration(
                          labelText: S.of(context).email,
                          labelStyle: const TextStyle(
                            color: Constants.kWhiteColor,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          filled: true,
                          fillColor: Colors.black26,
                          prefixIcon: const Icon(
                              Icons.email,
                              color: Constants.kWhiteColor
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Constants.kWhiteColor,
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        style: const TextStyle(
                          color: Constants.kWhiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateRepeatMail,
                        controller: _repeatEmailController,
                        enableSuggestions: true,
                        autocorrect: false,
                        cursorColor: Constants.kWhiteColor,
                        decoration: InputDecoration(
                          labelText: S.of(context).repeatMail,
                          labelStyle: const TextStyle(
                            color: Constants.kWhiteColor,
                          ),
                          filled: true,
                          fillColor: Colors.black26,
                          focusColor: Constants.kWhiteColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: const TextStyle(
                          color: Constants.kWhiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        width: 275,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff2ba8ff),
                                Color(0xff33a3f1),
                                Color(0xff2b93dc),
                                Color(0xff238cd5),
                                Color(0xff1e6b9f),
                                Color(0xff195781),
                                Color(0xff0f3c5c),
                              ]),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 5.0),
                              blurRadius: 6.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: _resetPassword,
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(50, 50)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                ),
                            ),
                            elevation: MaterialStateProperty.all(0.1),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              S.of(context).reset.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 15.5,
                                color: Colors.white,
                                letterSpacing: 1.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
    ));
  }

  String? _validateEmail(String? email) =>
      email != null && email.isNotEmpty && EmailValidator.validate(email)
          ? null
          : S.of(context).validMail;

  String? _validateRepeatMail(String? email) =>
      email != _emailController.value.text
          ? S.of(context).matchingMails
          : null;

  Future<void> _resetPassword() async {
    // close keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    // check validation before submitting
    if (_validateEmail(_emailController.value.text) != null ||
        _validateRepeatMail(_repeatEmailController.value.text) != null) {
      _showSnackbar(S.of(context).checkYourData, Colors.red);
      return;
    }
    // loading indicator
    showDialog(
        context: context,
        builder: (context) => Center(
            child: GlobalWidgets().circular(context),
        )
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // show success snackbar
      _showSnackbar(S.of(context).sendMailCheck, Colors.green);
      // remove loading indicator when sending is completed
      //Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pop();
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      debugPrint('E-Mail not found: $e');
      // show error snackbar
      _showSnackbar(S.of(context).emailNotFound, Colors.red);
      // remove loading indicator on error
      Navigator.of(context).pop();
    }
  }
}
