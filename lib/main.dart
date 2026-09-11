import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/core/routing/app_router.dart';
import 'package:flutter_firebase_app/core/routing/app_routes.dart';
import 'package:flutter_firebase_app/features/athu/login/presentation/ui/login_screen.dart';
import 'package:flutter_firebase_app/features/home/presentation/ui/pages/home_screen.dart';
import 'package:flutter_firebase_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
