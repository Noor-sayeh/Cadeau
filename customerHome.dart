import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Customer!')),
      body: Center(child: Text('Customer Dashboard')),
    );
  }
}
