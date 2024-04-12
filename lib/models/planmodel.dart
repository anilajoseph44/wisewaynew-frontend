// To parse this JSON data, do
//
//     final planList = planListFromJson(jsonString);

import 'dart:convert';

List<PlanList> planListFromJson(String str) => List<PlanList>.from(json.decode(str).map((x) => PlanList.fromJson(x)));

String planListToJson(List<PlanList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanList {
  String id;
  String planName;
  String startingdate;
  String endingdate;
  String numberofpeople;
  String vehiclemilege;
  String totalbudget;
  String staycost;
  String foodcost;
  String distancetotravel;
  String maxdistance;
  int v;

  PlanList({
    required this.id,
    required this.planName,
    required this.startingdate,
    required this.endingdate,
    required this.numberofpeople,
    required this.vehiclemilege,
    required this.totalbudget,
    required this.staycost,
    required this.foodcost,
    required this.distancetotravel,
    required this.maxdistance,
    required this.v,
  });

  factory PlanList.fromJson(Map<String, dynamic> json) => PlanList(
    id: json["_id"],
    planName: json["planName"],
    startingdate: json["startingdate"],
    endingdate: json["endingdate"],
    numberofpeople: json["numberofpeople"],
    vehiclemilege: json["vehiclemilege"],
    totalbudget: json["totalbudget"],
    staycost: json["staycost"],
    foodcost: json["foodcost"],
    distancetotravel: json["distancetotravel"],
    maxdistance: json["maxdistance"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "planName": planName,
    "startingdate": startingdate,
    "endingdate": endingdate,
    "numberofpeople": numberofpeople,
    "vehiclemilege": vehiclemilege,
    "totalbudget": totalbudget,
    "staycost": staycost,
    "foodcost": foodcost,
    "distancetotravel": distancetotravel,
    "maxdistance": maxdistance,
    "__v": v,
  };
}
