import 'dart:convert';

import 'package:http/http.dart' as http;

class UserApiService {
  Future<dynamic> SendUserLogin(String email, String password) async
  {
    var client = http.Client();
    var apiurl = Uri.parse("http://192.168.145.62:3002/api/users/signin");
    var response = await client.post(apiurl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Failed to Login");
    }
  }
  Future<dynamic>SendData(String name,String email,String password,String confirmPassword)async
  {
    var client=http.Client();
    var apiurl=Uri.parse("http://192.168.145.62:3002/api/users/signup");
    var response=await client.post(apiurl,
        headers: <String,String>{
          "Content-Type":"application/json; charset=UTF-8"

        },
        body: jsonEncode(<String,String>
        {
          "name":name,
          "email":email,
          "password":password,
          "confirmPassword":confirmPassword
        })
    );
    if(response.statusCode==200)
    {

      return json.decode(response.body);


    }
    else
    {
      throw Exception("Failed to send data");
    }
  }
  Future<dynamic>SendUsername(String email,String name)async
  {
    var client=http.Client();
    var apiurl=Uri.parse("http://192.168.145.62:3002/api/users/changeusername");
    var response=await client.post(apiurl,
        headers: <String,String>{
          "Content-Type":"application/json; charset=UTF-8"

        },
        body: jsonEncode(<String,String>
        {
          "email":email,
          "name":name
        })
    );
    if(response.statusCode==200)
    {
      return json.decode(response.body);
    }
    else
    {
      throw Exception("Failed to send data");
    }
  }



  Future<dynamic> changePassword(String email, String oldPassword, String newPassword) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.145.62:3002/api/users/changepassword");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "oldpassword": oldPassword,
          "newpassword": newPassword
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to send data");
      }
    } catch (error) {
      throw Exception("Error: $error");
    } finally {
      client.close();
    }
  }

  Future<dynamic> deleteAccount(String email, String password) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.145.62:3002/api/users/deleteaccount");
    try {
      var response = await client.post(
        apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to send data");
      }
    } catch (error) {
      throw Exception("Error: $error");
    } finally {
      client.close();
    }
  }

}