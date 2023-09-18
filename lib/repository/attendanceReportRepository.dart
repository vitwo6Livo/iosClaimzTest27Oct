// import 'package:flutter/foundation.dart';

// import '../data/network/baseApiService.dart';
// import '../data/network/networkApiService.dart';
// import '../models/attendanceReportModel.dart';
// import '../res/appUrl.dart';

// class AttendanceReportRepository {
//   BaseApiService baseApiService = NetworkServiceApi();

//   Future<dynamic> getAttendanceReportList(String token, dynamic data) async {
//     try {
//       dynamic response = await baseApiService.postAuthRequests(AppUrl.attendanceReport, data, token);
//       response = AttendanceListModel.fromJson(response);
//       if(kDebugMode) {
//         print('REPOSITORY: ${response.toString()}');
//       }
//       return response;
//     } catch (e) {
//       throw e;
//     }
//   }
// }