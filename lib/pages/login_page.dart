import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pertama_login/pages/menu_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  // final String title;
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
        final share = await SharedPreferences.getInstance();
        final emailLogin = share.setString('email', _userEmail);


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


  }

 
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
                      padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                      margin: const EdgeInsets.all(2),
                      child: const Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                radius: 80,
                backgroundImage:
                    const AssetImage('assets/img/gambar.jpg'), // Gambar profil
              ),
             
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
                padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,
                    ),
                    // BAGIAN PASSWORD
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password  ',
                        labelStyle: const TextStyle(
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
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: const Alignment(1, 0),
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: const InkWell(
                        child: const Text(
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
                        child: const Text('LOGIN'))
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
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupPage()));

                    },
                    child: const Text(
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
