import 'package:flutter/material.dart';

class KnownWords extends StatefulWidget {
  const KnownWords({Key? key}) : super(key: key);

  @override
  State<KnownWords> createState() => _KnownWordsState();
}

class _KnownWordsState extends State<KnownWords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListView(
            children: [
              Text('1'),
              Text('2'),
            ],
          ),
        ),
    );
  }
}
