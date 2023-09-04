import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueueNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nomor Antrian'),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          // stream: FirebaseFirestore.instance.collection('antrian').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(); // Menampilkan loading jika data belum tersedia
            }

            // Mengambil nomor antrian dari array di dalam dokumen
            var queueNumbers = snapshot.data!['no.antri'] ?? []; // Menggunakan default array kosong jika data belum tersedia
            var currentIndex = 0; // Index nomor antrian yang ingin diambil

            if (currentIndex >= 0 && currentIndex < queueNumbers.length) {
              var queueNumber = queueNumbers[currentIndex];

              return Text(
                'Nomor Antrian Saat Ini: $queueNumber',
                style: TextStyle(fontSize: 24),
              );
            } else {
              return Text(
                'Tidak ada nomor antrian yang tersedia pada index $currentIndex',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
