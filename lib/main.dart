import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:friendzo_app/Providers/user_provider.dart';
import 'package:friendzo_app/Screens/login.dart';
import 'package:friendzo_app/Utils/colors.dart';
import 'package:provider/provider.dart';

import 'Responsive/mobile_layout.dart';
import 'Responsive/responsive_layout.dart';
import 'Responsive/web_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyC9LDq6UEoc7SHSIrmbGxfUqxJ7zYifkh8",
      appId: "1:917592075327:web:98e71ff6934b0078225c8a",
      messagingSenderId: "917592075327",
      projectId: "friendzo-app",
      storageBucket: "friendzo-app.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),

        //There are 3 methods that firebase give us to persist auth state
        //1)IdTokenchanges(): called when the user registered and listen when user signin and signout and there is a unique id token every user has which firebase give.
        //2)userchanges(): same as id token but little differ
        //3)authstatechanges(): this runs only when user has signed in and signed out
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileLayout(),
                  webScreenLayout: WebLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
