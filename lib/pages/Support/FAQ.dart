import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: Text('Question 1: What is WiseWay?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'WiseWay is a productivity app designed to help users organize their tasks, manage their schedules, and improve their overall efficiency.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Question 2: How do I create a new task?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'To create a new task, go to the Tasks tab and tap on the "+" button. Then, fill out the task details such as title, description, due date, and priority.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Question 3: Can I customize task categories?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Yes, you can customize task categories to better organize your tasks. Go to the Settings tab and select "Task Categories" to add, edit, or delete categories.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Question 4: How do I sync my tasks across devices?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'To sync your tasks across devices, make sure you are logged in with the same account on all devices. Your tasks will automatically sync when you are connected to the internet.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Question 5: Is WiseWay available on multiple platforms?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Currently, WiseWay is available on Android and iOS devices. We are working on expanding to other platforms in the future.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          // Add more ExpansionTile widgets for additional questions and answers
        ],
      ),
    );
  }
}
