import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pertama_login/main.dart';
import 'package:pertama_login/pages/beranda.dart';
import 'package:pertama_login/pages/profile.dart';
import 'package:pertama_login/contoh_beranda/hasil_cek.dart';

import 'booking.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  var _textController = new TextEditingController();
  final  Stream<QuerySnapshot>booking=FirebaseFirestore.instance.collection('booking').snapshots();

  bool laptopSelected = false;
  bool komputerSelected = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[
            Container(
                   margin: EdgeInsets.all(15),

              child: Column(  
                children: <Widget>[
             
                  CheckboxListTile(
                    title: Text('Laptop'),
                    value: laptopSelected,
                    onChanged: (newValue) {
                      setState(() {
                        laptopSelected = newValue!;
                      });
                    },
                  ),
                  
                  CheckboxListTile(
                    title: Text('Komputer'),
                    value: komputerSelected,
                    onChanged: (newValue) {
                      setState(() {
                        komputerSelected = newValue!;
                      });
                    },
                  ),
                  new ListTile(
                    
                    leading: new Text('Kerusakan'),
                    title: new TextField(
                      decoration:InputDecoration(
                        labelText: 'Masukan Deskripsi',

                      ),
                      
                      controller: _textController,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              child: Column(
                children: <Widget>[
                 
                  new ListTile(
                    title: new RaisedButton(
                      child: new Text('Booking Sekarang'),
                      onPressed: () {
                        Navigator.push(
                          
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SecondPage(
                                laptopSelected: laptopSelected,
                                komputerSelected: komputerSelected,
                                value: _textController.text),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
