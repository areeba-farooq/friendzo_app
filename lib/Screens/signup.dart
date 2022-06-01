import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:friendzo_app/Screens/login.dart';
import 'package:friendzo_app/Utils/colors.dart';
import 'package:friendzo_app/Utils/utils.dart';
import 'package:friendzo_app/Widgets/textfield_inputs.dart';
import 'package:image_picker/image_picker.dart';

import '../Resources/auth_methods.dart';
import '../Responsive/mobile_layout.dart';
import '../Responsive/responsive_layout.dart';
import '../Responsive/web_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().getSignUp(
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      username: _userNameController.text,
      file: _image!,
    );

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

  void navToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
                      Image.asset(
                        "assets/logo.png",
                        height: 200,
                      ),
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!))
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundColor: Colors.yellow,
                                ),
                          Positioned(
                              bottom: -10,
                              left: 80,
                              child: IconButton(
                                onPressed: () {
                                  selectImage();
                                },
                                icon: const Icon(Icons.add_a_photo),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFieldInputs(
                        editingController: _userNameController,
                        hintText: "Enter your username",
                        isPass: false,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 24,
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
                      TextFieldInputs(
                        editingController: _bioController,
                        hintText: "Enter your short bio",
                        isPass: false,
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      InkWell(
                        onTap: signUpUser,
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : Container(
                                child: const Text(
                                  "Sign Up",
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
                              "Already have an account?",
                              style: TextStyle(
                                letterSpacing: 0.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          GestureDetector(
                            onTap: navToLogin,
                            child: Container(
                              child: const Text(
                                "  Login.",
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
                ]),
          ),
        ));
  }
}
