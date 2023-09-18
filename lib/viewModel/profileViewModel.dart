import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/profileRepository.dart';
import 'package:provider/provider.dart';
import '../data/response/apiResponse.dart';
import '../models/profileDetailsModel.dart';
import '../res/appUrl.dart';
import './userViewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class ProfileViewModel with ChangeNotifier {
  // final profileRepository = ProfileRepository();

  // ApiResponse<ProfileDetails> profileDetails = ApiResponse.loading();

  // setProfileDetails(ApiResponse<ProfileDetails> profile) {
  //   profileDetails = profile;
  //   print('Profile Details: $profileDetails');
  //   notifyListeners();
  // }

  // Future<void> getProfileDetails(BuildContext context) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   String authToken = localStorage.getString('token').toString();

  //   String userId = localStorage.getString('userId').toString();

  //   profileRepository.getProfileDetails(authToken, userId).then((value) {
  //     setProfileDetails(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) {
  //     setProfileDetails(ApiResponse.error(error.toString()));
  //   });
  // }
  Map<String, dynamic> _profileDetails = {};

  Map<String, dynamic> get profileDetails {
    return {..._profileDetails};
  }

  Future<void> getProfileDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // print('User ID: ${localStorage.getInt('userId').toString()}');

    print('User ID: ${localStorage.getInt('id')}');

    var response = await http.get(
        Uri.parse('${AppUrl.profileDetails}${localStorage.getInt('id')}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _profileDetails = json.decode(response.body);
    } else {
      _profileDetails = {};
    }
    print('Profile Details: $_profileDetails');
    notifyListeners();
  }

  Future<void> postImage(BuildContext context, File? image) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('FILEEEEEEEEe: $image');

    final url = Uri.parse(AppUrl.uploadPhoto);

    var request = http.MultipartRequest('POST', url);

    request.headers
        .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    request.files.add(await http.MultipartFile.fromPath('photo', image!.path,
        contentType: MediaType('application', 'x-tar')));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Uploaded');
      // _profileDetails['photo'] = 'https://claimz.vitwo.in/profile_photo/$image';
      Provider.of<ProfileViewModel>(context, listen: false).getProfileDetails();
    } else {
      print('Response Code: ${response.statusCode}');
    }
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../repository/profileRepository.dart';
// import 'package:provider/provider.dart';
// import '../data/response/apiResponse.dart';
// import '../models/profileDetailsModel.dart';
// import '../res/appUrl.dart';
// import './userViewModel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProfileViewModel with ChangeNotifier {
//   // final profileRepository = ProfileRepository();

//   // ApiResponse<ProfileDetails> profileDetails = ApiResponse.loading();

//   // setProfileDetails(ApiResponse<ProfileDetails> profile) {
//   //   profileDetails = profile;
//   //   print('Profile Details: $profileDetails');
//   //   notifyListeners();
//   // }

//   // Future<void> getProfileDetails(BuildContext context) async {
//   //   SharedPreferences localStorage = await SharedPreferences.getInstance();

//   //   String authToken = localStorage.getString('token').toString();

//   //   String userId = localStorage.getString('userId').toString();

//   //   profileRepository.getProfileDetails(authToken, userId).then((value) {
//   //     setProfileDetails(ApiResponse.completed(value));
//   //   }).onError((error, stackTrace) {
//   //     setProfileDetails(ApiResponse.error(error.toString()));
//   //   });
//   // }
//   Map<String, dynamic> _profileDetails = {};

//   Map<String, dynamic> get profileDetails {
//     return {..._profileDetails};
//   }

//   Future<void> getProfileDetails() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     // print('User ID: ${localStorage.getInt('userId').toString()}');

//     print('User ID: ${localStorage.getInt('id')}');

//     var response = await http.get(
//         Uri.parse(
//             '${AppUrl.profileDetails}${localStorage.getInt('id')}'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${localStorage.getString('token')}'
//         });

//     if (response.statusCode == 200) {
//       _profileDetails = json.decode(response.body);
//     } else {
//       _profileDetails = {};
//     }
//     print('Profile Details: $_profileDetails');
//   }

//   Future<void> postImage(dynamic data) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     var formData;

    
//   }
// }
