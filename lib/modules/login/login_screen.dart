import 'package:flutter/material.dart';
import 'package:hotelbooking/language/app_localizations.dart';
import 'package:hotelbooking/routes/route_name.dart';
import 'package:hotelbooking/widgets/common_appbar_view.dart';
import 'package:hotelbooking/widgets/common_button.dart';
import 'package:hotelbooking/widgets/common_textfield_view.dart';
import 'package:hotelbooking/widgets/remove_focuse.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String errorEmail = '';
  TextEditingController emailController = TextEditingController();
  String errorPassword = '';
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonAppbarView(
              iconData: Icons.arrow_back_ios_new,
              titleText: AppLocalizations(context).of("login"),
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonTextFieldView(
                      controller: emailController,
                      errorText: errorEmail,
                      titleText: AppLocalizations(context).of("your_mail"),
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                      hintText: AppLocalizations(
                        context,
                      ).of("enter_your_email"),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      controller: passwordController,
                      errorText: errorPassword,
                      titleText: AppLocalizations(context).of("password"),
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                      hintText: AppLocalizations(context).of("enter_password"),
                      onChanged: (String txt) {},
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    CommonButton(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 15),
                      buttonText: AppLocalizations(context).of("login"),
                      onTap: () {
                        NavigationServices(context).gotoTabScreen();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
