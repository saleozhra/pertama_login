import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  var _textController = TextEditingController();
  final Stream<QuerySnapshot> booking =
      FirebaseFirestore.instance.collection('antrian').snapshots();

  final bookingCol = FirebaseFirestore.instance.collection('antrian');
  // pilihan
  String? selectedOption = '';

  void handleRadioValueChanged(value) {
    setState(() {
      selectedOption = value;
    });
  }

  // bool laptopSelected = false;
  // bool komputerSelected = false;
  int currentIndex = 0;
  int nomorAntrean = 0;
  String emailLogin = '';
  String kodBok = '';
  String noAnti = '';

  @override
  void initState() {
    super.initState();
    // Memanggil metode untuk mengambil data antrian
    fetchData();
  }

  // tambahkan data
  Future<void> addData() async {
    final noAnti = nomorAntrean.toString().padLeft(3, '0');
    final kodBok = 'A${nomorAntrean.toString().padLeft(2, '0')}';
    print(kodBok);
    print(noAnti);
    print(emailLogin);
    print(_textController.text);
    print(selectedOption);
    await FirebaseFirestore.instance.collection('antrian').add({
      'jam_booking': Timestamp.now(),
      'kerusakan': _textController.text,
      'kode_booking': '$kodBok',
      'layanan': '',
      'nama': emailLogin,
      'no_antrian': noAnti,
      // ...
    }).then((value) => print(value));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Berhasil'),
          content: Text(
              'Data telah berhasil disimpan.\ndengan nomor antrian $noAnti \ndengan nomor booking $kodBok'),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    _textController.clear();
    setState(() {
      selectedOption = null;
    });

    // return 1;
  }

  void fetchData() async {
    try {
      //
      final share = await SharedPreferences.getInstance();
      emailLogin = share.getString('email') ?? 'kosong';
      print(emailLogin);
      // Mengambil referensi ke koleksi di Firebase Firestore
      final collectionReference =
          await FirebaseFirestore.instance.collection('antrian').get();

      final user = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'email',
            isEqualTo: emailLogin,
          )
          .get();

          if (user.size != 0) {
        // Mengambil data antrian dari field array

        setState(() {
          // Menyimpan data antrian dalam state
        //  final data = user.docs.first.data() as Map;
        //  print(data['nama']);
        });
      } else {
        print('Dokumen tidak ditemukan.');
      }

      // Mengambil data antrian dalam bentuk dokumen

      if (collectionReference.size != 0) {
        // Mengambil data antrian dari field array

        setState(() {
          // Menyimpan data antrian dalam state
          nomorAntrean = collectionReference.size + 1;
        });
      } else {
        print('Dokumen tidak ditemukan.');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  // void getNextQueue() {
  //   if (currentIndex < nomorAntrean - 1) {
  //     setState(() {
  //       currentIndex++; // Menambah indeks untuk mengambil nomor antrean berikutnya
  //     });
  //   } else {
  //     // ignore: avoid_print
  //     print('Semua nomor antrean telah diambil.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(15),
              // value: laptopSelected,

              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Laptop'),
                    leading: Radio(
                      value: 'Laptop',
                      groupValue: selectedOption,
                      onChanged: handleRadioValueChanged,
                    ),
                  ),
                  ListTile(
                    title: Text('Komputer'),
                    leading: Radio(
                      value: 'Komputer',
                      groupValue: selectedOption,
                      onChanged: handleRadioValueChanged,
                    ),
                  ),
                  SizedBox(height: 20.0),

                  //hasil pilihanbox
                  // Text('Pilihan Anda: $selectedOption'),
                  // CheckboxListTile(
                  //   title: const Text('Laptop'),
                  //   value: laptopSelected,
                  //   onChanged: (v) {
                  //     setState(() {
                  //       laptopSelected = v!;
                  //     });
                  //   },
                  // ),
                  // CheckboxListTile(
                  //   title: const Text('Komputer'),
                  //   value: komputerSelected,
                  //   onChanged: (v) {
                  //     setState(() {
                  //       komputerSelected = v!;
                  //     });
                  //   },
                  // ),
                  ListTile(
                    leading: const Text('Kerusakan'),
                    title: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Masukan Deskripsi',
                      ),
                      controller: _textController,
                    ),
                  ),
                  // Text(
                  //   nomorAntrean.isNotEmpty
                  //       ? nomorAntrean[currentIndex]
                  //       : 'Tidak ada data',
                  //   style: TextStyle(fontSize: 24),
                  // ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addData();
              },
              child: Text('Booking Sekarang'),
            ),
            // Text(
            //   nomorAntrean.toString(),
            //   style: const TextStyle(fontSize: 24),
            // ),
          ]),
    );
  }
}
