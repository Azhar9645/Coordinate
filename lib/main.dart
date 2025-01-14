import 'package:coordinate_app/presentation/screens/auth%20screen/signIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coordinate',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // Set the background color to black
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, // Use dark mode for the entire app
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Set AppBar background color to black
          iconTheme: IconThemeData(
            color: Colors.white, // Set AppBar icon color to white
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.jost(fontSize: 24.0, color: Colors.white),
          titleMedium: GoogleFonts.jost(fontSize: 18.0, color: Colors.white),
          bodyLarge: GoogleFonts.mulish(fontSize: 16.0, color: Colors.white),
          bodyMedium: GoogleFonts.mulish(fontSize: 14.0, color: Colors.white),
        ),
        useMaterial3: true,
      ),
      home: SignInScreen(),
    );
  }
}
