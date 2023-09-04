import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pertama_login/pages/login_page.dart';
import 'package:pertama_login/pages/beranda.dart';

class MenuLogin extends StatelessWidget {
  const MenuLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          
          // user is loggend in
          if(snapshot.hasData){
            return Beranda();

          }
          // USER IS NOT LOGGEN
          else{
            return MyApp();
            
          }
        },
      )
    );
      
    
    
  }
}