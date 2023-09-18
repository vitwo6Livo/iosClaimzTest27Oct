import 'package:claimz/viewModel/announcementViewModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/appUrl.dart';

class DepartmentItem {
  int id;
  String departmentName;
  bool isSelected;

  DepartmentItem({
    required this.id,
    required this.departmentName,
    this.isSelected = false,
  });
}

class PostAnnouncementViewModel with ChangeNotifier {
  Map<String, dynamic> _allDepartments = {};
  Map<String, dynamic> _postResponse = {};

  Map<String, dynamic> get allDepartments {
    return {..._allDepartments};
  }

  Map<String, dynamic> get postResponse {
    return {..._postResponse};
  }

  List<Map<String, dynamic>> _departments = [];

  List<Map<String, dynamic>> get departments {
    return [..._departments];
  }

  Future<void> getAllDepartments() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _departments = [];

    var response = await http.get(Uri.parse(AppUrl.allDeptartment), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _allDepartments = json.decode(response.body);
      for (int i = 0; i < _allDepartments['data'].length; i++) {
        _allDepartments['data'][i]['isClicked'] = false;
        _departments.add(_allDepartments['data'][i]);
      }
      // for (var department in _allDepartments['data']) {
      //   // allDepartments['data'][i]['isSelected'] = false;
      //   // _departments.add(_allDepartments['data'][i]);

      //   _departments.add(DepartmentItem(
      //     // id: int.tryParse(department['id'].toString()) ?? 0,
      //     id: department['id'] == '' ? null : department['id'],
      //     departmentName: department['department_name'],
      //   ));
      // }
    } else {
      _allDepartments = json.decode(response.body);
      print('Error : ${json.decode(response.body)}');
    }
    print('All Departments: $_departments');
    notifyListeners();
  }

  Future<void> postAnnouncement(
      BuildContext context, dynamic data, String month, String year) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.postAnnouncement),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _postResponse = json.decode(response.body);
      Provider.of<AnnouncementViewModel>(context, listen: false)
          .getAllAnouncements(month, year);
      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Success',
              message: _postResponse['data'].toString())
          .show(context);
      print('Response: ${json.decode(response.body)}');
    } else {
      // _postResponse = json.decode(response.body);

      Flushbar(
              duration: const Duration(seconds: 4),
              flushbarPosition: FlushbarPosition.BOTTOM,
              borderRadius: BorderRadius.circular(10),
              icon: const Icon(Icons.error, color: Colors.white),
              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              title: 'Error',
              message: _postResponse.toString())
          .show(context);
      print('Response: $_postResponse');
    }
  }
}
