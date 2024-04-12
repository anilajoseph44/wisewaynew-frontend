import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              'Email: support@wiseway.com',
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(Icons.email),
            onTap: () {
              // Implement action to open email app with pre-filled recipient
            },
          ),
          SizedBox(height: 20),
          Text(
            'For general inquiries, support requests, or partnership opportunities, please feel free to reach out to us via email. We are here to assist you!',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
