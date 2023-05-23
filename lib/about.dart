import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'This is a fantastic app that provides various features to enhance your productivity and convenience. It offers a user-friendly interface, advanced functionality, and a seamless user experience. Download the app now and explore its amazing features!',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                colors: [Color(0xd40354d7), Color(0xFFDAA520)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Made by',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Lakshay Madaan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Team Members',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Lakshay Madaan'),
            ),
          ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Tajvinder Makkar'),
            ),
          ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Eklavya Bhardwaj'),
            ),
          ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Shivi Dutta'),
            ),
          ),
          Card(
            elevation: 2.0,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text('Nischay'),
            ),
          ),
        ],
      ),
    );
  }
}
