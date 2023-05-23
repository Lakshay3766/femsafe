import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Language'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              // Add your logic for changing the language to English
            },
          ),
          ListTile(
            title: Text('Spanish'),
            onTap: () {
              // Add your logic for changing the language to Spanish
            },
          ),
          ListTile(
            title: Text('French'),
            onTap: () {
              // Add your logic for changing the language to French
            },
          ),
          // Add more language options as needed
        ],
      ),
    );
  }
}
