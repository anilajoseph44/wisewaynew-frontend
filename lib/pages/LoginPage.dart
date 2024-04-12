import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Bottom_Navigation_Page.dart';
import 'package:google_maps_yt/pages/Signup_page.dart';
import 'package:google_maps_yt/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<LoginPage> {
  bool _showPassword = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errorMessage = '';

  @override
  void userlogin() async {
    final response = await UserApiService().SendUserLogin(email.text, password.text);
    if (response["status"] == "success") {
      String userId = response["userdata"]["_id"].toString();
      String userEmail = response["userdata"]["email"].toString();
      String userName = response["userdata"]["name"].toString();
      print("Successfully Logged In");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userId", userId);
      preferences.setString("userEmail", userEmail); // Store email ID
      preferences.setString("userName", userName);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (response["status"] == "Incorrect email id") {
      setState(() {
        errorMessage = 'User does not have an account';
      });
    } else {
      setState(() {
        errorMessage = 'Invalid Credentials. Please check.';
      });
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 90,),
                Image.asset("assets/screenshotlogo.png"),
                SizedBox(height: 90,),
                Text(
                  "Explore the world effortlessly with WiseWay",
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                Text("Start planning your next adventure today!", style: TextStyle(color: Colors.white.withOpacity(0.6))),
                SizedBox(height: 30,),
                TextField(
                  controller: email,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    hintText: "example@gmail.com",
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.30)),
                    suffixIcon: Icon(Icons.alternate_email, color: Colors.black.withOpacity(0.50),),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: password,
                  obscureText: !_showPassword,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.30)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.black.withOpacity(0.50)),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: userlogin,
                    child: Text("Login"),
                  ),
                ),
                SizedBox(height: 10,), // Added SizedBox for spacing
                if (errorMessage.isNotEmpty) // Display error message if not empty
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red), // Error message color set to red
                  ),
                SizedBox(height: 20,),
                Divider(color: Colors.grey, thickness: 2,),
                SizedBox(height: 15,),
                Text("Unlock Adventure with Ease", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 20),),
                SizedBox(height: 25,),
                Row(
                  children: [
                    SizedBox(width: 83,),
                    Text("New user? ", style: TextStyle(color: Colors.white.withOpacity(0.40), fontSize: 18),),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("Sign Up", style: TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold, fontSize: 22),),
                    )
                  ],
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}