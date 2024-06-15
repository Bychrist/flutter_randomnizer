import 'dart:math';
import 'package:flutter/material.dart';

class Randomnize extends StatefulWidget {
  final int? minn;
  final int? maxx;
  const Randomnize({super.key, required this.minn, required this.maxx});

  @override
  State<Randomnize> createState() => _RandomnizeState();
}

class _RandomnizeState extends State<Randomnize> {
  late int resultone;
  void generateRandomValue() {
    final random = Random();
    final minn = widget.minn ?? 0;
    final maxx = widget.maxx ?? 1;
    final result = minn + random.nextInt(maxx - minn + 1);
    setState(() {
      resultone = result;
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$resultone',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: generateRandomValue,
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Randomnize',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
