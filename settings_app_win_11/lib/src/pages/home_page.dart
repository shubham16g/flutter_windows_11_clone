import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed('theme');
                  },
                  child: Text('HomePage: $count')),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          count++;
        });
      },
      child: Icon(Icons.add),),
    );
  }
}
