import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pertama_login/antrian.dart';
import 'package:pertama_login/pages/login.dart';
import 'package:pertama_login/pages/beranda.dart';
import 'package:pertama_login/pages/login_page.dart';
import 'package:pertama_login/pages/no_antri.dart';
import 'package:pertama_login/pages/profile.dart';
import 'package:pertama_login/contoh_regis_login.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner:false,
      
      title: 'Aplikasi Booking',
      home: MenuLogin()
    );
    
  }
}