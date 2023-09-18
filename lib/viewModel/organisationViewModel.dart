import 'dart:convert';

import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/material.dart';
import '../models/organisationModel.dart';
import '../repository/organisationRespository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrganizationViewModel with ChangeNotifier {
  // final organizationRepository = OrganizationRepository();

  // ApiResponse<OrganisationModel> organisation = ApiResponse.loading();

  // setOrganisationList(ApiResponse<OrganisationModel> response) {
  //   organisation = response;
  //   notifyListeners();
  // }

  // Future<void> getOrganisationList() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   String token = localStorage.getString('token').toString();

  //   organizationRepository
  //       .getOrganisation(token)
  //       .then((value) => setOrganisationList(ApiResponse.completed(value)))
  //       .onError((error, stackTrace) =>
  //           setOrganisationList(ApiResponse.error(error.toString())));
  // }

  Map<String, dynamic> _organisation = {};

  Map<String, dynamic> get organisation {
    return {..._organisation};
  }

  Future<void> getOrganisation() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.get(Uri.parse(AppUrl.organisation), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _organisation = json.decode(response.body);

      // var apiResponse = json.decode(response.body);

      // var organisationEncoded = json.encode(apiResponse);

      // localStorage.setString('organisation', organisationEncoded);

      // var decodedString = localStorage.getString('organisation');

      // _organisation = json.decode(decodedString!);
    }

    // print('ORGANISATION STORED IN CACHE: $_organisation');
  }
}
