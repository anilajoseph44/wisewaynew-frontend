import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Plan/Display_Expense.dart';
import 'package:google_maps_yt/pages/map_page.dart';

class InputPage3 extends StatefulWidget {
  final String planName;

  const InputPage3({Key? key, required this.planName}) : super(key: key);

  @override
  State<InputPage3> createState() => _InputPage3State();
}

class _InputPage3State extends State<InputPage3> {
  bool _isButtonEnabled = false;
  TextEditingController _startingDateController = TextEditingController();
  TextEditingController _endingDateController = TextEditingController();
  TextEditingController _numberOfPeopleController = TextEditingController();
  TextEditingController _vehicleMileageController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  bool _stayNeeded = false;

  @override
  void initState() {
    super.initState();
    _startingDateController.text = _formatDate(DateTime.now());
    _endingDateController.text = _formatDate(DateTime.now());
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = _formatDate(picked);
        _updateButtonState("");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  'assets/screenshotlogo-removebg.png',
                  height: 150,
                ),
                Text(
                  "Enter Details",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _startingDateController,
                  readOnly: true,
                  onTap: () => _selectDate(context, _startingDateController),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Starting Date",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _endingDateController,
                  readOnly: true,
                  onTap: () => _selectDate(context, _endingDateController),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Ending Date",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _numberOfPeopleController,
                  onChanged: _updateButtonState,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Number of People",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _vehicleMileageController,
                  onChanged: _updateButtonState,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Average Vehicle Mileage (MPG)",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  onChanged: _updateButtonState,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Total Budget",
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _stayNeeded,
                      onChanged: (value) {
                        setState(() {
                          _stayNeeded = value!;
                        });
                      },
                    ),
                    Text("Stay Needed"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Container()),
                    ElevatedButton(
                      onPressed: _isButtonEnabled ? _handleButtonPress : null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey; // Disabled color
                            }
                            return Colors.green.shade900; // Enabled color
                          },
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('Calculate Expenses & Plan Trip', style: TextStyle(color: Colors.white)),
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

  void _updateButtonState(String value) {
    setState(() {
      _isButtonEnabled = _startingDateController.text.isNotEmpty &&
          _endingDateController.text.isNotEmpty &&
          _numberOfPeopleController.text.isNotEmpty &&
          _amountController.text.isNotEmpty;
    });
  }

  void _handleButtonPress() {
    String planName = widget.planName;
    String startingDate = _startingDateController.text;
    String endingDate = _endingDateController.text;
    int numberOfPeople = int.parse(_numberOfPeopleController.text);
    double? vehicleMileage = _vehicleMileageController.text.isNotEmpty ? double.parse(_vehicleMileageController.text) : null;
    double budget = double.parse(_amountController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayExpense(
          planName: planName,
          startingDate: startingDate,
          endingDate: endingDate,
          numberOfPeople: numberOfPeople,
          vehicleMileage: vehicleMileage,
          budget: budget,
          stayNeeded: _stayNeeded, // Pass the _stayNeeded value
        ),
      ),
    );
  }

}
