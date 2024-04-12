import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Delete_Account.dart';
import 'package:google_maps_yt/pages/Password_Reset.dart';
import 'package:google_maps_yt/pages/Support_Page.dart';
import 'package:google_maps_yt/pages/change_username.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _userName = preferences.getString("userName");
      _userEmail = preferences.getString("userEmail");
      print(_userName);
      print(_userEmail);
      print("...................................");
    });
  }

  Future<void> _refreshUserData() async {

    await _loadUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 29),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh,color: Colors.white,),
            onPressed: _refreshUserData,
          ),
        ],
      ),
      body: _userName != null && _userEmail != null
          ? ListView(
        children: [
          SizedBox(height: 40),
          Card(
            elevation: 4,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 120,
              child: ListTile(
                contentPadding: EdgeInsets.all(17),
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade900,
                  radius: 36,
                  child: Text(
                    _userName != null && _userName!.isNotEmpty
                        ? _userName![0]
                        : '',
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                ),
                title: Text(
                  '$_userName',
                  style: TextStyle(fontSize: 25),
                ),
                subtitle: Text(
                  '$_userEmail',
                  style: TextStyle(fontSize: 13),
                ),
                trailing: Icon(Icons.edit),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeUsername()));
                  // Navigate to edit profile page
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeUsername(),
                        ),
                      );
                    },
                    icon: Icon(Icons.person, color: Colors.green.shade900),
                    label: Text(
                      'Change Username',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextButton.icon(
                    onPressed: () {

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                      // Action for changing password
                    },
                    icon: Icon(Icons.lock, color: Colors.green.shade900),
                    label: Text(
                      'Password Reset    ',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                Divider(),
                TextButton.icon(
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportPage()));
                    // Action for support
                  },
                  icon: Icon(Icons.support, color: Colors.green.shade900),
                  label: Text(
                    'Support            ',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteAccount()));
                      // Action for deleting account
                    },
                    icon: Icon(Icons.delete, color: Colors.green.shade900),
                    label: Text(
                      'Delete My Account',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}