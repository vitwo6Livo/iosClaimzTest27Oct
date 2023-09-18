// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import './userViewModel.dart';
// import '../repository/leaveTypeRepository.dart';
// import '../data/response/apiResponse.dart';
// import '../models/leaveTypeModel.dart';

// class LeaveTypeViewModel with ChangeNotifier {
//   final leaveTypeRepository = LeaveTypeRepository();

//   ApiResponse<LeaveTypes> leaveType = ApiResponse.loading();

//   setLeaveTypes(ApiResponse<LeaveTypes> leaves) {
//     leaveType = leaves;
//     notifyListeners();
//   }

//   Future<void> getLeaveTypes(BuildContext context) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     String token = localStorage.getString('token').toString();

//     leaveTypeRepository.getLeaveType(token).then((value) {
//       setLeaveTypes(ApiResponse.completed(value));
//     }).onError((error, stackTrace) {
//       setLeaveTypes(ApiResponse.error(error.toString()));
//     });
//   }
// }
