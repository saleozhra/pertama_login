import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String emailLogin = '';
  String user = '';
  var data = <String, dynamic>{};

  @override
  void initState()  {
    fetchData();
    super.initState();
  }

  // ambil user
  Future<void> fetchData() async {
    //
    final share = await SharedPreferences.getInstance();
    emailLogin = share.getString('email') ?? 'kosong';
    // print(emailLogin);
    // // Mengambil referensi ke koleksi di Firebase Firestore
    // final collectionReference =
    //     await FirebaseFirestore.instance.collection('antrian').get();

    final user = await FirebaseFirestore.instance
        .collection('users')
        .where(
          'email',
          isEqualTo: emailLogin,
        )
        .get();

    if (user.size != 0) {
      // Mengambil data antrian dari field array

      // Menyimpan data antrian dalam state
      setState(() {
        data = user.docs.first.data();
      });
      print(data['email']);
    } else {
      print('Dokumen tidak ditemukan.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profil'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 80,
              backgroundImage:
                  AssetImage('assets/img/gambar.jpg'), // Gambar profil
            ),
            const SizedBox(height: 20),
            Text(
              data['nama'].toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $emailLogin',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi yang sesuai di sini
              },
              child: const Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
