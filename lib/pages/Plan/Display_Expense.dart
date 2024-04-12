import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/map_page.dart';
import 'package:google_maps_yt/services/plan_service.dart';

class DisplayExpense extends StatefulWidget {
  final String planName;
  final String startingDate;
  final String endingDate;
  final int numberOfPeople;
  final double? vehicleMileage;
  final double budget;
  final bool stayNeeded;

  const DisplayExpense({
    Key? key,
    required this.planName,
    required this.startingDate,
    required this.endingDate,
    required this.numberOfPeople,
    this.vehicleMileage,
    required this.budget,
    required this.stayNeeded,
  }) : super(key: key);

  @override
  State<DisplayExpense> createState() => _DisplayExpenseState();
}

class _DisplayExpenseState extends State<DisplayExpense> {
  double stayCost = 0.0;
  double distanceToTravel = 0.0;
  double maxDistance = 0.0;
  double foodCost = 0.0;

  @override
  void initState() {
    super.initState();
    calculateStayCost();
  }

  int calculateNumberOfDays() {
    DateTime startDate = DateTime.parse(widget.startingDate);
    DateTime endDate = DateTime.parse(widget.endingDate);
    return endDate.difference(startDate).inDays;
  }

  void calculateStayCost() {
    double stayPercentage = 0.25;
    double budget = widget.budget;
    double totalBudget = widget.budget;
    double? averageMileage = widget.vehicleMileage;
    double numberOfDays = calculateNumberOfDays().toDouble();
    double budgetPerPerson = budget / widget.numberOfPeople;

    if (numberOfDays == 0.0) {
      numberOfDays = 1;
    }
    double budgetPerPersonPerDay = budgetPerPerson / numberOfDays;

    if (widget.stayNeeded) {
      if (budgetPerPersonPerDay <= 1200) {
        stayCost = budgetPerPersonPerDay * stayPercentage * widget.numberOfPeople * numberOfDays;
      } else {
        stayCost = budgetPerPersonPerDay <= (800 * widget.numberOfPeople * numberOfDays) ? budget : 800 * widget.numberOfPeople * numberOfDays;
      }

      budget -= stayCost;
      budgetPerPerson = budget / widget.numberOfPeople;
      budgetPerPersonPerDay = budgetPerPerson / numberOfDays;
    }

    if (budgetPerPersonPerDay <= 300) {
      foodCost = budgetPerPersonPerDay * 0.5 * widget.numberOfPeople * numberOfDays;
    } else {
      foodCost = 200 * widget.numberOfPeople * numberOfDays;
    }

    budget -= foodCost;

    double averagePetrolPrice = 100;
    double costPerKm = averagePetrolPrice / averageMileage!;

    maxDistance = budget / costPerKm;
    distanceToTravel = maxDistance * 0.45;
  }

  void sendValuesToApi() async {
    print("*********************************************");
    print("Sending values to API...");
    print("Plan Name: ${widget.planName}");
    print("Starting Date: ${widget.startingDate}");
    print("Ending Date: ${widget.endingDate}");
    print("Number of People: ${widget.numberOfPeople}");
    print("Vehicle Mileage: ${widget.vehicleMileage}");
    print("Budget: ${widget.budget}");
    print("Stay Cost: $stayCost");
    print("Food Cost: $foodCost");
    print("Distance To Travel: $distanceToTravel");
    print("Max Distance: $maxDistance");
    print("*********************************************");

    final response = await PlanApiService().sendPlanDetails(
      widget.planName,
      widget.startingDate,
      widget.endingDate,
      widget.numberOfPeople,
      widget.vehicleMileage,
      widget.budget,
      stayCost,
      foodCost,
      distanceToTravel,
      maxDistance,
    );

    if (response["status"] == "success") {
      print("API response: $response");
    } else {
      print("Failed to send plan details to API.");
    }
    print("*********************************************");
  }

  @override
  Widget build(BuildContext context) {
    int numberOfDays = calculateNumberOfDays();

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Details'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.green.shade900,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              ' ${widget.planName}',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                          SizedBox(height: 16),
                          Divider(color: Colors.white),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.date_range, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Starting Date: ${widget.startingDate}',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.date_range, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Ending Date: ${widget.endingDate}',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.people, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Number of People: ${widget.numberOfPeople}',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          if (widget.vehicleMileage != null)
                            Row(
                              children: [
                                Icon(Icons.directions_car, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Vehicle Mileage: ${widget.vehicleMileage}',
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          SizedBox(height: 40),
                          Text(
                            'Total Budget: ${widget.budget}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'Number of Days: $numberOfDays',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'Total Stay Cost: $stayCost',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'Total Food Cost: $foodCost',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            'Distance Can Travel(km): $distanceToTravel',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 24),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: sendValuesToApi,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text('Save plan and suggest place', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Note: The displayed values are approximate and subject to change.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
