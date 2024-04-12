import 'package:flutter/material.dart';
import 'package:google_maps_yt/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  bool _isButtonEnabled = false;
  String? _userEmail;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _oldPasswordController.addListener(_checkTextField);
    _newPasswordController.addListener(_checkTextField);
    _loadUserData(); // Load user email when the widget initializes
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _checkTextField() {
    setState(() {
      _isButtonEnabled = _oldPasswordController.text.isNotEmpty &&
          _newPasswordController.text.isNotEmpty;
    });
  }

  Future<void> _loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = preferences.getString("userEmail");
    });
  }

  void changePassword() async {
    final response = await UserApiService().changePassword(
      _userEmail.toString(),
      _oldPasswordController.text,
      _newPasswordController.text,
    );
    if (response['status'] == 'success') {
      setState(() {
        _message = 'Password changed successfully';
      });
    } else {
      setState(() {
        _message = 'Failed to change password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Change Password",
            style: TextStyle(color: Colors.white),
          ),
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
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Old Password',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  cursorColor: Colors.black,
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? Colors.green[900] : null,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isButtonEnabled ? changePassword : null,
                  child: Text('Save'),
                ),
                SizedBox(height: 10),
                Text(
                  _message,
                  style: TextStyle(
                    color: _message.startsWith('Failed') ? Colors.red : Colors.green,
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
