import 'package:dr_app/screen/admin_home_page.dart';
import 'package:dr_app/screen/client_home_page.dart';
import 'package:dr_app/provider/auth_provider.dart';
import 'package:dr_app/screen/profile.dart';
import 'package:dr_app/screen/userType_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/Auth/login_page.dart';
import 'screen/Auth/register_page.dart';

void main() async {
  const apiKey = "AIzaSyC6XUj2scOwd2UNbmIQyd1jaudPOve6MBE";
  const projectId = "dr-app-flutter";

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyC6XUj2scOwd2UNbmIQyd1jaudPOve6MBE",
    appId: '1:1001099437155:web:ad581f5f20ad2677b6c456',
    messagingSenderId: '1001099437155',
    projectId: 'dr-app-flutter',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProviderApp()),
        ],
        child: FutureBuilder(
          builder: (context, appSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.hasData) {
                      return userType();
                    }
                    return LoginPage();
                  }),
              routes: {
                '/login': (context) => LoginPage(),
                '/register': (context) => RegisterPage(),
                '/profile': (context) => Profile()
              },
            );
          },
          future: _initialization,
        ));
  }
}
