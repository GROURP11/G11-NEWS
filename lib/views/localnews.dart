import 'package:flutter/material.dart';

class LocalNews extends StatelessWidget {
  const LocalNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const [
          Text(
            'Local News Page',
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
          ),
          CircleAvatar(
            child: Icon(
              Icons.newspaper,
              size: 120,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            'Local News Page Content',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
