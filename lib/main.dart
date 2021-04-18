import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soshare/views/screens/home_screen.dart';
import 'package:custom_splash/custom_splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(child: Text(snapshot.error));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return Container();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: CustomSplash(
        imagePath: 'assets/logo/logo.png',
        backGroundColor: Colors.teal.shade900,
        animationEffect: 'zoom-in',
        logoSize: 200,
        home: HomeScreen(),
        duration: 2500,
        type: CustomSplashType.StaticDuration,
      ),
    );
  }
}
