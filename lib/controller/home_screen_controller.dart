import 'dart:convert';

import 'package:api_crud_operation_jan/model/employee_res_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  String baseUrl = "http://3.93.46.140";

  List<Employee> employeesList = [];
  bool isLoading = false;
  // get employeees

  Future getEmployees() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(baseUrl + "/employees/");
    var response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var decodedData = jsonDecode(response.body);
      EmployeeResModel resModel = EmployeeResModel.fromJson(decodedData);
      employeesList = resModel.employeesList ?? [];
    }
    isLoading = false;
    notifyListeners();
  }

  // delete an employee

  Future deleteEmployee(var id) async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(baseUrl + "/employees/$id/");
    var response = await http.delete(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await getEmployees();
    } else {
      print("failed");
    }

    isLoading = false;
    notifyListeners();
  }

  // add an employee
  Future addEmployee() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(baseUrl + "/employees/create/");
    var response =
        await http.post(url, body: {"name": "Shihab", "role": "flutter"});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await getEmployees();
    } else {
      print("failed");
    }

    isLoading = false;
    notifyListeners();
  }

  // add an employee
  Future updateEmployee(var id) async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(baseUrl + "/employees/update/$id/");
    var response = await http.put(url,
        body: {"name": "Shihab- editted", "role": "flutter - editted"});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      await getEmployees();
    } else {
      print("failed");
    }

    isLoading = false;
    notifyListeners();
  }
}
