import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Plan/Input_Page2.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool _isButtonEnabled = false;
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isTextFieldFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isTextFieldFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  'assets/screenshotlogo-removebg.png',
                  height: 150,
                ),
                Text(
                  "Create Plan",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Focus(
                  onFocusChange: (hasFocus) {
                    setState(() {
                      _isTextFieldFocused = hasFocus;
                    });
                  },
                  child: TextFormField(
                    cursorColor: Colors.black, // Set cursor color to black
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        _isButtonEnabled = value.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isTextFieldFocused ? Colors.black : Colors.grey,
                        ),
                      ),
                      labelText: "Name of the Plan",
                      labelStyle: TextStyle(
                        color: _isTextFieldFocused ? Colors.black : Colors.grey,
                      ),
                      // Set cursor color to black
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Container()),
                    IconButton(
                      onPressed: _isButtonEnabled
                          ? () {
                        String planName = _textEditingController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InputPage3(planName: planName),
                          ),
                        );
                      }
                          : null,
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isButtonEnabled ? Colors.green.shade900 : Colors.grey,
                        ),
                        child: Icon(Icons.arrow_forward, size: 25, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
