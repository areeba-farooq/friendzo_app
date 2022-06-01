import 'package:flutter/material.dart';
import 'package:friendzo_app/Resources/auth_methods.dart';
import 'package:friendzo_app/Screens/signup.dart';
import 'package:friendzo_app/Utils/colors.dart';
import 'package:friendzo_app/Widgets/textfield_inputs.dart';

import '../Responsive/mobile_layout.dart';
import '../Responsive/responsive_layout.dart';
import '../Responsive/web_layout.dart';
import '../Utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().getLogin(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileLayout(),
            webScreenLayout: WebLayout(),
          ),
        ),
      );
    } else {
      showsnackbar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Flexible(
                      //   child: Container(),
                      //   flex: 2,
                      // ),
                      Image.asset(
                        "assets/logo.png",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldInputs(
                        editingController: _emailController,
                        hintText: "Enter your email address",
                        isPass: false,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldInputs(
                        editingController: _passwordController,
                        hintText: "Enter your password",
                        isPass: true,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: loginUser,
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : Container(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.0),
                                ),
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: blueColor,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Flexible(
                      //   child: Container(),
                      //   flex: 2,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                letterSpacing: 0.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          GestureDetector(
                            onTap: navToSignUp,
                            child: Container(
                              child: const Text(
                                "  Sign up.",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 0.3,
                                    fontWeight: FontWeight.w500),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ])),
      ),
    );
  }
}
