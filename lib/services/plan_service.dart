import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanApiService {
  Future<dynamic> sendPlanDetails(
      String planName,
      String startingDate,
      String endingDate,
      int numberOfPeople,
      double? vehicleMileage,
      double totalBudget,
      double stayCost,
      double foodCost,
      double distanceToTravel,
      double maxDistance,
      ) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.145.62:3002/api/plan/createplan");

    var response = await client.post(
      apiUrl,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(<String, dynamic>{
        "planName": planName,
        "startingdate": startingDate,
        "endingdate": endingDate,
        "numberofpeople": numberOfPeople.toString(), // Convert int to String
        "vehiclemileage": vehicleMileage?.toString(), // Convert double? to String
        "totalbudget": totalBudget.toString(), // Convert double to String
        "staycost": stayCost.toString(), // Convert double to String
        "foodcost": foodCost.toString(), // Convert double to String
        "distancetotravel": distanceToTravel.toString(), // Convert double to String
        "maxdistance": maxDistance.toString(), // Convert double to String
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to send plan details");
    }
  }

}
