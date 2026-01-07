import 'package:flutter/material.dart';
import 'pages/onboarding_page.dart';
import 'pages/dashboard_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hzvjpdtlrffthlzhxqtf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh6dmpwZHRscmZmdGhsemh4cXRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzMzQ4MjksImV4cCI6MjA3OTkxMDgyOX0.Ysx8sl_0FF4DOgcXN5Y5Y_Mkz6ZgBM--YCnP2aB0sL8',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flydle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB85C5C)),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}
