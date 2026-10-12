import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );
  
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.containsKey('auth_token');
  
  runApp(FinvaApp(isLoggedIn: isLoggedIn));
}

class FinvaApp extends StatelessWidget {
  final bool isLoggedIn;
  const FinvaApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finva',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isLoggedIn ? const MainScreen() : const LoginScreen(),
    );
  }
}

