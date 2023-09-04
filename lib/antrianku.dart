import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Nomor extends StatelessWidget {
  const Nomor({Key? key}) : super(key: key);

// menambhakan data ke firebase
  Future<void> addData() async {
    await FirebaseFirestore.instance.collection('nomor').add({
      'field1': 'nilai1',
      'field2': 'nilai2',
      // ...
    });
  }
  // membca data
   Future<void> readData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('nomor').get();

    querySnapshot.docs.forEach((doc) {
      print(doc.data());
    });
  }
  // update data
  Future<void> updateData() async {
  await FirebaseFirestore.instance
      .collection('nomor')
      .doc('https://console.firebase.google.com/project/undefined/firestore/data/nomor/8dVAN4bwp8KbpOS0AegY')
      .update({
    'field1': 'nilai_baru',
  });
}
// delete data
Future<void> deleteData() async {
  await FirebaseFirestore.instance
      .collection('nomor')
      .doc('https://console.firebase.google.com/project/undefined/firestore/data/nomor/8dVAN4bwp8KbpOS0AegY')
      .delete();
}



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            addData().then((_) {
              readData(); // Setelah menambah data, baca data
            });
          },
          child: Text('Tambah Data'),
        ),
        ElevatedButton(
          onPressed: () {
            readData();
          },
          child: Text('Tampilkan Data'),
        ),
        ElevatedButton(
          onPressed: () {
            updateData();
          },
          child: Text('Perbarui Data'),
        ),
          ElevatedButton(
          onPressed: () {
            deleteData();
          },
          child: Text('Hapus Data'),
        ),
      ],
    );
  }
}
