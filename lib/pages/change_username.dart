import 'package:flutter/material.dart';
import 'package:google_maps_yt/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key? key}) : super(key: key);

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  TextEditingController _usernameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _usernameController.addListener(_checkTextField);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _checkTextField() {
    setState(() {
      _isButtonEnabled = _usernameController.text.isNotEmpty;
    });
  }

  String? _userEmail;
  Future<void> _loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = preferences.getString("userEmail");
      print(_userEmail);
      print("...................................");
    });
  }

  void changeuname() async {
    final response = await UserApiService().SendUsername(_userEmail.toString(), _usernameController.text);
    if (response['status'] == 'success') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("userName", _usernameController.text); // Update the username in shared preferences
      Navigator.pop(context, _usernameController.text); // Pass the new username back to the previous page
    }
    print(response);
    print("........................................");
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Change User Name",
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
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'New Username',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? Colors.green[900] : null,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isButtonEnabled ? changeuname : null,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
