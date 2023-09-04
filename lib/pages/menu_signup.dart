import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController namaController = TextEditingController();

  Future<void> addData() async {
    await FirebaseFirestore.instance.collection('users').add({
      'email': emailController.text,
      'nama': namaController.text,
      'password': passwordController.text,
      // ...
    });
  }

  void _register() async {
    try {
      addData();

      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        //  nama:namaController.text,
        password: passwordController.text,

        
      ))
          .user;
      if (user != null) {
        setState(() {
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
        print('gagal!!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
              child: const Text(
                "SignUp",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),
          Container(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
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
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                      labelText: 'Nama ',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                // BAGIAN PASSWORD
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
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
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, left: 40, right: 40),
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

                    child: const Text('SIGNUP'))
              ],
            ),
          ),
          const SizedBox(
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
                child: const Text(
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
