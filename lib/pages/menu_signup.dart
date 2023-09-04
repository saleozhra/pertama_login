import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pertama_login/pages/menu_signup.dart';
import 'package:pertama_login/pages/beranda.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;

  void _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email!;
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Berhasil Registrasi'),
            );
          },
        );
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                    child: Text(
                      "SignUp",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
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
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                // BAGIAN PASSWORD
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )),
                  // PERIKSA APAKAH SDH BENAR
                  obscureText: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      _register();
                      // Navigator.pushNamed(context,'/beranda');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Warna latar belakang tombol
                      onPrimary: Colors.white, // Warna teks pada tombol
                    ),
                    // Navigator.pushNamed(context,'/beranda');

                    child: Text('SIGNUP'))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                // akan mengarahkan ke bagian signup
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Back To',
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
    );
  }
}
