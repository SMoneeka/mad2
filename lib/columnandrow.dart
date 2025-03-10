import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Column and row example")),
        body: Column(
          children: [
            Text("Column Layout",style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Icon(Icons.star,size:30,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
                Icon(Icons.star,size:40,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
                Icon(Icons.star,size:50,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
                Icon(Icons.star,size:60,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
              ],
            ),
            Text("Column Layout",style: TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Icon(Icons.delete,size:30,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
                Icon(Icons.delete,size:40,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
                Icon(Icons.delete,size:50,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
                Icon(Icons.delete,size:60,color:Colors.blue),
                SizedBox(width: 10),
                Text("Row item"),
              ],
            )
          ],
        )
      )
    );
  }
}