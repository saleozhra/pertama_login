import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pertama_login/pages/booking.dart' as booking;
import 'package:pertama_login/pages/profile.dart' as profile;


class Beranda extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> with SingleTickerProviderStateMixin {
  // membuat controller
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  // fungsi tombol keluar
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: Icon(Icons.logout))
        ],
        leading:new Icon(Icons.home),
        title: new Center(child: new Text('Kami Siap Melayani Anda '),),
        backgroundColor: Colors.blueGrey,
       
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new booking.Booking(),
          new profile.Profile(), 
          // new laptop.Laptop(),
          ],
      ),

      bottomNavigationBar: new Material(
        color: Colors.blueGrey,
        child: new TabBar(
        controller: controller,
        tabs: <Widget>[
          new Tab(icon: new Icon(Icons.message_outlined),text: 'Booking',),
          new Tab(icon: new Icon(Icons.person),text: 'Profile',),
        ],
      ),    
      ),
    );
  }
}
