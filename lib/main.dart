import 'package:digital_paca_test/screens/home.dart';
import 'package:digital_paca_test/screens/login.dart';
import 'package:digital_paca_test/services/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => StreamBuilder(
              stream: apiService.authState(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF03A9F4)),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data == true) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              }),
            ),
        // '/details': (context) => const ShowDetails(),
      },
    );
  }
}
