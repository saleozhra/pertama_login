import 'package:flutter/material.dart';
// import 'package:pertama_login/contoh_beranda/cek.dart';
import 'package:pertama_login/pages/booking.dart';

class SecondPage extends StatelessWidget {
  String value;
    // NextPage({Key? key, required this.value}) : super(key: key);
  final bool laptopSelected;
  final bool komputerSelected;
   var _textController=new  TextEditingController();

  

  SecondPage({
    required this.laptopSelected,
    required this.komputerSelected,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Pilihan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
      
            Text(
              'Pilihan Anda:',
              style: TextStyle(fontSize: 20),
            ),
            if (laptopSelected)
              Text(
                'Laptop',
                style: TextStyle(fontSize: 18),
              ),
            if (komputerSelected)
              Text(
                'Komputer',
                style: TextStyle(fontSize: 18),
              ),

             
              Text("${value }")
                    // body: new Text("${widget.value }",

          //     new ListTile(
                    
          //      title: new TextField(
              
              
          //   ),
          // ),
          ],
          
        ),
      ),
    );
  }
}
