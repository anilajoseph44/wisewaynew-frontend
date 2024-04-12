import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Signup_page.dart';
import 'package:google_maps_yt/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  String? _userEmail;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkTextField);
    _loadUserData(); // Load user data when the widget initializes
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = preferences.getString("userEmail");
    });
  }

  void _checkTextField() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty;
    });
  }

  void deleteAccount() async {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                // Proceed with account deletion
                final response = await UserApiService().deleteAccount(
                  _userEmail.toString(),
                  _passwordController.text,
                );
                if (response['status'] == 'success') {
                  setState(() {
                    _message = 'Account deleted successfully';
                    _passwordController.clear(); // Clear the TextField
                  });
                  // Navigate to signup page
                  _navigateToSignUp();
                } else {
                  setState(() {
                    _message = 'Incorrect password or failed to delete account';
                  });
                }
                print(response);
                print("********************************");
                print(_userEmail.toString());
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()), // Navigate to signup page
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Delete Account'),
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/final_logo.png",
                  height: 90,
                ),
                SizedBox(height: 40),
                TextField(
                  cursorColor: Colors.black,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? Colors.green[900] : null,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isButtonEnabled ? deleteAccount : null,
                  child: Text('Delete Account'),
                ),
                SizedBox(height: 10),
                Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Incorrect') ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
