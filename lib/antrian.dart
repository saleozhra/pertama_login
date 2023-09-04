import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database
import 'package:flutter/material.dart';

class Antrian extends StatefulWidget {
  const Antrian({Key? key}) : super(key: key);

  @override
  State<Antrian> createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  int nomorAntrian = 0; // Inisialisasi nomor antrian

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Antrian'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Nomor Antrian:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                nomorAntrian.toString(), // Menampilkan nomor antrian
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () async {
                  int nextNumber = await getAutoIncrementNumber();
                  setState(() {
                    nomorAntrian = nextNumber;
                  });
                },
                child: Text('Ambil Antrian'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mendapatkan nomor antrian otomatis dari Firebase
  Future<int> getAutoIncrementNumber() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    DataSnapshot dataSnapshot = (await databaseReference.child('antrian').once()) as DataSnapshot;
    
    // Ambil nomor antrian terakhir dari database
    int? lastNumber = (dataSnapshot.value ?? 0) as int?;
    
    // Tambahkan 1 untuk mendapatkan nomor antrian berikutnya
    int nextNumber = lastNumber! + 1;
    
    // Simpan nomor antrian berikutnya ke database
    await databaseReference.child('antrian').set(nextNumber);
    
    return nextNumber;
  }
}
