import 'package:flutter/material.dart';

class FutureImplementScreen extends StatefulWidget {
  const FutureImplementScreen({super.key});

  @override
  State<FutureImplementScreen> createState() => _FutureImplementScreenState();
}

class _FutureImplementScreenState extends State<FutureImplementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your other widgets here
              Text(
                'This feature is still under development.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}