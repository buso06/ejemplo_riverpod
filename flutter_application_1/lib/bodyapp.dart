import 'package:flutter/material.dart';

class Bodyapp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: const Center(
            child: Text(
              'Hello World',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          height: 900,
          width: 400,
          color: Colors.blue,
        ),
      ),
    );
  }
}
