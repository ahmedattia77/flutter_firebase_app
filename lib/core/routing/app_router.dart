import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/core/routing/app_routes.dart';
import 'package:flutter_firebase_app/features/athu/login/presentation/cubit/login_cubit.dart';
import 'package:flutter_firebase_app/features/athu/login/presentation/ui/login_screen.dart';
import 'package:flutter_firebase_app/features/home/presentation/cubit/add_screen/cubit/add_note_screen_cubit.dart';
import 'package:flutter_firebase_app/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_firebase_app/features/home/presentation/ui/pages/add_note_screen.dart';
import 'package:flutter_firebase_app/features/home/presentation/ui/pages/home_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                final user = snapshot.data!;
                return BlocProvider(
                  create: (context) => HomeCubit()..fetchNotes(),
                  child: HomeScreen(
                    email: user.email ?? 'No Email',
                    displayName: user.displayName ?? 'User',
                  ),
                );
              }
              return BlocProvider(
                create: (context) => LoginCubit(),
                child: const LoginScreen(),
              );
            },
          ),
        );

      case AppRoutes.addNoteScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddNoteScreenCubit(),
            child: const AddNoteScreen(),
          ),
        );

      case AppRoutes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginScreen(),
          ),
        );

      case AppRoutes.registerScreenRoute:
        return MaterialPageRoute(
          builder: (context) => Center(child: Text("comming soon")),
        );

      case AppRoutes.resetPasswordScreenRoute:
        return MaterialPageRoute(
          builder: (context) => Center(child: Text("comming soon")),
        );

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
