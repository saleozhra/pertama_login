import 'package:flutter/material.dart';
import 'package:pertama_login/contoh_beranda/hasil_cek.dart';
import 'package:pertama_login/pages/booking.dart';

void main() {
  runApp(MaterialApp(
    home: CheckboxPage(),
  ));
}

class CheckboxPage extends StatefulWidget {
  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  var _textController = new TextEditingController();

  bool laptopSelected = false;
  bool komputerSelected = false;
  // NO
   int currentIndex = 0;
  List<dynamic> nomorAntrean = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Perangkat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              title: new TextField(
                controller: _textController,
              ),
            ),
        
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => SecondPage(
            //           laptopSelected: laptopSelected,
            //           komputerSelected: komputerSelected, 
            //             value:_textController.text
                      
            //         ),
            //       ),
            //     );
            //   },
            //   child: Text('Lanjutkan'),
            // ),
          ],
        ),
      ),
    );
  }
}

