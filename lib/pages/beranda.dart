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
    controller =  TabController(vsync: this, length: 2);
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
    return  Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(
            onPressed: signUserOut, 
            icon: const Icon(Icons.logout))
        ],
        leading: const Icon(Icons.home),
        title:  const Center(child: Text('Kami Siap Melayani Anda '),),
        backgroundColor: Colors.blueGrey,
       
      ),
      body:  TabBarView(
        controller: controller,
        children: const <Widget>[
            booking.Booking(),
            profile.Profile(), 
          //  laptop.Laptop(),
          ],
      ),

      bottomNavigationBar:  Material(
        color: Colors.blueGrey,
        child:  TabBar(
        controller: controller,
        tabs: const <Widget>[
           Tab(icon:  Icon(Icons.message_outlined),text: 'Booking',),
           Tab(icon:  Icon(Icons.person),text: 'Profile',),
        ],
      ),    
      ),
    );
  }
}
