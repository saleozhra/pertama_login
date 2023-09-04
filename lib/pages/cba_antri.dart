import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MyData extends StatefulWidget {
  const MyData({Key? key}) : super(key: key);

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  // @override
  // Widget build(BuildContext context) {
  Widget ListItem() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 110,
      color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Age',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Salary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColorDark,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red[700],
                      ),
                    ],
                  ),
                ),
              ],
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return  Scaffold(
    appBar: AppBar(
      title: const Text('Membuat antrian'),
    ),
    body: Container(
      height:double.infinity,
      // child: FirebaseAnimatedList,

    ),
  );
  }
}



