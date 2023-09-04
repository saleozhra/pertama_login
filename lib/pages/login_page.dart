import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pertama_login/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pertama_login/pages/beranda.dart';
import 'package:pertama_login/pages/menu_signup.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Login',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: LoginPage(title: 'hdhdh'),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        // '/beranda':(BuildContext context) => new beranda.Home(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";

  //try SIGN USER
  void signUserIn() async {
    // sihn user in method
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text))
        .user;

    if (user != null) {
      setState(() async {
        _success = 2;
        _userEmail = user.email!;
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Berhasil Login'),
            );
          },
        );
        // onTap: (){
        //           Navigator.of(context).pushNamed('/signup');
        //         };
      });
    } else {
      setState(() {
        _success = 3;
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Belum punya akun\nsilakan melakukan Registrasi'),
            );
          },
        );
      });
    }

    // try{
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: emailController.text,
    //   password: passwordController.text,
    //   );
    //   }on FirebaseAuthException catch(e){
    // pop the loading   circle
    // Navigator.pop(context);
    //   if(e.code=='user-not-faund'){
    //     emailSalah();
    //     // print('object')
    //   }
    //   else if(e.code=='password salah'){
    //     passwordSalah();
    //   }
  }

  // }
  // void emailSalah(){
  //   showDialog(
  //     context: context,
  //     builder: (context){
  //       return const AlertDialog(
  //         title: Text('Incorrect Email'),
  //       );
  //     },);
  // }
  //  void passwordSalah(){
  //   showDialog(
  //     context: context,
  //     builder: (context){
  //       return const AlertDialog(
  //         title: Text('Incorrect Password'),
  //       );
  //     },);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                      margin: EdgeInsets.all(2),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage:
                    AssetImage('assets/img/gambar.jpg'), // Gambar profil
              ),
              //LOGO
              // const Icon(
              //   Icons.lock,
              //   size: 100,

              // ),
              const SizedBox(height: 10),

              // welcome back you've been missed!
              Text(
                'Welcome back you\'ve been missed',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 15),
              // username textfield
              Container(
                padding: EdgeInsets.only(top: 35, left: 20, right: 30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,
                    ),
                    // BAGIAN PASSWORD
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password  ',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.green),
                        // )
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment(1, 0),
                      padding: EdgeInsets.only(top: 15, left: 20),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // button\
              // MyBotton(
              //   onTap:signUserIn,
              //   buttonText:'Sign In'

              // ),
              // MyButton(
              //   onTap:signUserIn,
              //   buttonText:'Sign In',

              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          signUserIn();
                          // Navigator.pushNamed(context,'/beranda');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Warna latar belakang tombol
                          onPrimary: Colors.white, // Warna teks pada tombol
                        ),
                        // Navigator.pushNamed(context,'/beranda
                        child: Text('LOGIN'))
                  ],
                ),
              ),

              // pr continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // facebook
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // squareTile(imagePath:lib/images/google.com),
                  SizedBox(width: 15),
                  // google button
                  //  squareTile(imagePath:lib/images/google.com),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    // akan mengarahkan ke bagian signup
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontFamily: 'Monserrat',
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
