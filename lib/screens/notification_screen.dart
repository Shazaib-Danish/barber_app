import 'package:flutter/material.dart';



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('Empty', style: TextStyle(
          fontSize: 20.0,
          color: Colors.grey
        ),),
      ),
    );
  }
}
