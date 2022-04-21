import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {

  final int age;
  final int result;
  final bool isMale;

  BmiResultScreen({Key? key,
    required this.age,
    required this.isMale,
    required this.result,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Gender: ${isMale ?'Male':'Female'}',
            style: TextStyle(
             fontSize: 25.0,
             fontWeight: FontWeight.bold,
            ),
            ),
            Text(
                'Result: ${result}',
            style: TextStyle(
             fontSize: 25.0,
             fontWeight: FontWeight.bold,
            ),
            ),
            Text(
                'Age: ${age}',
            style: TextStyle(
             fontSize: 25.0,
             fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
