import 'package:firebase_demo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'services/services.dart';
import 'package:firebase_demo/preferences/preferences.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init(); 
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArbolService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: 'login',
      routes: {
        'home': (_) => HomeScreen(),
        'detail': (_) => DetailScreen(),
        'login': (_) => LoginScreen(),
      },
    );
  }
}
