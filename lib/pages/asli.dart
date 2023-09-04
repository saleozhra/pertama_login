import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Noantri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  int currentIndex = 0;
  List<dynamic> nomorAntrean = [];

  @override
  void initState() {
    super.initState();
    // Memanggil metode untuk mengambil data antrian
    fetchData();
  }

  void fetchData() async {
    try {
      // Mengambil referensi ke koleksi di Firebase Firestore
      final collectionReference = FirebaseFirestore.instance.collection('antrian');

      // Mengambil data antrian dalam bentuk dokumen
      final documentSnapshot = await collectionReference.doc('VjkMAEPIvJlO9SO8liFk').get();

      if (documentSnapshot.exists) {
        // Mengambil data antrian dari field array
        final data = documentSnapshot.data();

        setState(() {
          // Menyimpan data antrian dalam state
          nomorAntrean = data?['no.antri'];
        });
      } else {
        print('Dokumen tidak ditemukan.');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  void getNextQueue() {
    if (currentIndex < nomorAntrean.length - 1) {
      setState(() {
        currentIndex++; // Menambah indeks untuk mengambil nomor antrean berikutnya
      });
    } else {
      // ignore: avoid_print
      print('Semua nomor antrean telah diambil.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mengambil Data Antrian Satu Persatu dari Firebase Firestore'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nomor Antrean Sekarang:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              nomorAntrean.isNotEmpty ? nomorAntrean[currentIndex] : 'Tidak ada data',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mengambil nomor antrean berikutnya
                getNextQueue();
              },
              child: Text('Ambil Nomor Antrean Berikutnya'),
            ),
          ],
        ),
      ),
    );
  }
}