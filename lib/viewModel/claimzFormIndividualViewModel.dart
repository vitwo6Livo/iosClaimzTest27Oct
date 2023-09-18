import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/models/User_limit.dart';
import 'package:claimz/models/claimzDetailModel.dart';
import 'package:claimz/repository/claimzRepository.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/viewModel/userViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../views/screens/claimzHistory/claimzHistory.dart';
import '../views/screens/incidentalClaimsScreen.dart';
import '../views/screens/incidentalExpenseScreen.dart';
import '../views/screens/success_tick_screen.dart';
import '../views/widgets/managerScreenWidgets/claimManager/claimManagerScreen.dart';
import 'managerIncidentalViewModel.dart';
import 'userIncidentalViewModel.dart';

class ClaimzFormIndividualViewModel with ChangeNotifier {
  final ClaimzRespository = ClaimzRepository();
  int _ownBike = 0;
  int _ownCarD = 0;
  int _public = 0;
  int _ownCarP = 0;
  int _compVehicle = 0;
  Map<String, dynamic> _limit = {};
  List<String> _modeOfTravel = [];
  Map<String, dynamic> _claimzForm = {};
  List<dynamic> _travelDetails = [];
  List<dynamic> _foodDetails = [];
  List<dynamic> _incidentalDetails = [];

  Map<String, dynamic> get limit {
    return {..._limit};
  }

  Map<String, dynamic> get claimzForm {
    return {..._claimzForm};
  }

  List<String> get modeOfTravel {
    return [..._modeOfTravel];
  }

  List<dynamic> get travelDetails {
    return [..._travelDetails];
  }

  List<dynamic> get foodDetails {
    return [..._foodDetails];
  }

  List<dynamic> get incidentalDetails {
    return [..._incidentalDetails];
  }

  int get ownBike {
    return _ownBike;
  }

  int get ownCarD {
    return _ownCarD;
  }

  int get public {
    return _public;
  }

  int get ownCarP {
    return _ownCarP;
  }

  int get compVehicle {
    return _compVehicle;
  }

  ClaimzHistoryViewModel claimz_list = ClaimzHistoryViewModel();

  ApiResponse<User_limit> claimz_user_limit = ApiResponse.loading();
  void setClaimzUserLimit(ApiResponse<User_limit> apiResponse) {
    claimz_user_limit = apiResponse;
    notifyListeners();
  }

  // Future<void> getClaimzLimit(dynamic data, BuildContext context) async {
  //   //get per user limit
  //   final SharedPreferences localStorage =
  //       await SharedPreferences.getInstance();
  //   final String? token = localStorage.getString('token');
  //   ClaimzRespository.getClaimzUserLimit(data, token).then((value) {
  //     setClaimzUserLimit(ApiResponse.completed(value));
  //     print('VALUEEEEEEEEEE: ${value.travel}');
  //     for (int i = 0; i < value.travel!.length; i++) {
  //       if (value.travel![i].componentName == 'Own Bike') {
  //         _ownBike = value.travel![i].limitPerKm!;
  //       } else if (value.travel![i].componentName == 'Own Car(Diesel)') {
  //         _ownCarD = value.travel![i].limitPerKm!;
  //       } else if (value.travel![i].componentName == 'Public Transport') {
  //         _public = value.travel![i].limitPerKm!;
  //       } else if (value.travel![i].componentName == 'Own Car(Petrol)') {
  //         _ownCarP = value.travel![i].limitPerKm!;
  //       } else {
  //         _compVehicle = value.travel![i].limitPerKm!;
  //       }
  //     }

  //     print(_ownBike);
  //     print(_ownCarD);
  //     print(_public);
  //     print(_ownCarP);
  //     print(_compVehicle);
  //   }).onError((error, stackTrace) {
  //     setClaimzUserLimit(ApiResponse.error(error.toString()));
  //   });
  //   notifyListeners();
  // }

  Future<void> getClaimzLimit(String docNo, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _modeOfTravel = [];

    var response = await http.post(Uri.parse(AppUrl.claimzFormLimit),
        body: json.encode({'doc_no': docNo}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _limit = json.decode(response.body);
      for (int i = 0; i < _limit['travel'].length; i++) {
        _modeOfTravel.add(_limit['travel'][i]['component_name']);
      }

      print('MODE OF TRAVEL: $_modeOfTravel');
    } else {
      _limit = json.decode(response.body);

      print('ERRRRROR: $_limit');

      Flushbar(
        message: 'An Error Occured',
        icon: const Icon(Icons.info_outline, size: 28, color: Colors.white),
        leftBarIndicatorColor: Colors.red,
        duration: const Duration(seconds: 3),
      )..show(context);
    }
    notifyListeners();
  }

  Future<void> postClaimzFormSubmit(BuildContext context, dynamic request_file,
      XFile file, Map<String, String> request_data) async {
    //individual claimz submit
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postclaimzSubmission(
            token, request_file, file, request_data)
        .then((value) => Flushbar(
              message: value['data'].toString(),
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.blue,
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue,
            )..show(context))
        .onError(((error, stackTrace) => Flushbar(
              message: error.toString(),
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.red,
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.blue,
            )..show(context)));
    // Map data = {
    //   // "month": "",
    //   "month": '',
    //   "all": 1,
    //   "year": "2022",
    // };

    // print('DATAAAAA: $data');

    // claimz_list.postClaimzHistoryList(context, data);
    // notifyListeners();
  }

  Future<void> postIncidentalClaimz(BuildContext context, dynamic request_file,
      dynamic file, Map<String, String> request_data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    ClaimzRespository.postclaimzSubmissionIncidental(
            token, request_file, file, request_data)
        .then((value) {
      print('SUCCESS CLAIM: $value');
      localStorage.setString('claimNo', value['claim_no']);
      print('Saved CLAIM: ${localStorage.getString('claimNo')}');
      Flushbar(
        message: "Your claim has been saved as draft posted!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
      Provider.of<UserIncidentalViewModel>(context, listen: false)
          .getUserIncidental();
    }).onError((error, stackTrace) {
      print('SUCCESS CLAIM: $error');
      Flushbar(
        message: error.toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    });
  }

  Future<void> getConveyanceDetails(BuildContext context, String docNo) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _travelDetails = [];
    _foodDetails = [];
    _incidentalDetails = [];

    var response = await http.post(Uri.parse(AppUrl.claimzFormView),
        body: json.encode({'doc_no': docNo}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _claimzForm = json.decode(response.body);

      for (int i = 0; i < _claimzForm['data']['approval_log'].length; i++) {
        if (_claimzForm['data']['approval_log'][i]['claim_type'] == 'travel') {
          _travelDetails.add(_claimzForm['data']['approval_log'][i]);
        } else if (_claimzForm['data']['approval_log'][i]['claim_type'] ==
            'food') {
          _foodDetails.add(_claimzForm['data']['approval_log'][i]);
        } else {
          _incidentalDetails.add(_claimzForm['data']['approval_log'][i]);
        }
      }
      print('TRAVEL: $_travelDetails');
      print('FOOD: $_foodDetails');
      print('INCIDENTAL: $_incidentalDetails');
    } else {
      _claimzForm = json.decode(response.body);

      Flushbar(
        message: 'An Error Occured!! Please Try Again Later',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    }
    notifyListeners();
  }

  Future<void> conveyanceSaveAsDraft(
      BuildContext context,
      dynamic file,
      Map<String, dynamic> request_data,
      Map<String, dynamic> dateData,
      String type) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('FOOOOD FILEEEEEEEEEE: $file');

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.conveyanceAsDraft));

    request.headers
        .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    request.fields['doc_no'] = request_data['doc_no'];
    request.fields['service_provider'] = request_data['service_provider'];
    type == 'travel'
        ? request.fields['mode_of_travel'] = request_data['mode_of_travel']
        : null;
    type == 'travel'
        ? request.fields['distance'] = request_data['distance']
        : null;
    type == 'travel' ? request.fields['from'] = request_data['from'] : null;
    request.fields['bill_no'] = request_data['bill_no'];
    request.fields['gst_no'] = request_data['gst_no'];
    request.fields['gst_amount'] = request_data['gst_amount'];
    request.fields['claim_amount'] = request_data['claim_amount'];
    request.fields['basic_amount'] = request_data['basic_amount'];
    file == ''
        // ? request.files.add(await http.MultipartFile.fromPath('document', ''))
        ? request.fields['document'] = ''
        : request.files.add(await http.MultipartFile.fromPath(
            'document', file.path.toString()));
    request.fields['claim_type'] = request_data['claim_type'];

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      // print('Saved CLAIM: ${localStorage.getString('claimNo')}');
      // var responseData = json.decode(response.body);

      var responseResult = await http.Response.fromStream(response);

      final result = json.decode(responseResult.body) as Map<String, dynamic>;

      print('RESPONSEEEEE: $result');

      Flushbar(
        message: result['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context).then((_) =>
          Provider.of<ClaimzHistoryViewModel>(context, listen: false)
              .getClaimList(dateData, context));
      // .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
      //       Navigator.of(context).pop();
      //       Navigator.of(context).push(
      //           MaterialPageRoute(builder: (context) => ClaimzHistory()));
      //     }));
      // });
    } else {
      Flushbar(
        message: 'An Error Occured',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    }
  }

  Future<void> conveyanceFinalSubmit(BuildContext context, String docNo) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var responseData;

    var response = await http.post(Uri.parse(AppUrl.claimzFinalSubmit),
        body: json.encode({'doc_no': docNo}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      responseData = json.decode(response.body);

      EasyLoading.showSuccess("Submmited Regularise")
          .then((value) => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SuccessTickScreen())))
          .then((value) {
        // Provider.of<UserIncidentalViewModel>(context, listen: false)
        //     .getUserIncidental();
        Navigator.of(context).pop();
      });
      EasyLoading.dismiss();

      Flushbar(
        message: responseData['data'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context)
          .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ClaimzHistory()));
              }));
    } else {
      responseData = json.decode(response.body);

      print('ERROR: $responseData');

      Flushbar(
        message: 'An Error Occured',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context)
          .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              }));
    }
  }

  Future<void> conveyanceManagerEdit(Map<String, dynamic> data,
      Map<String, dynamic> refreshData, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.conveyanceManagerEdit),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      print('Response Data: $responseData');

      Flushbar(
        message: responseData['data'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context).then((value) => Navigator.of(context).pop());

      // Provider.of<ClaimzHistoryViewModel>(context, listen: false)
      //     .postClaimzHistoryList(context, refreshData);
    } else {
      var responseData = json.decode(response.body);

      print('Response Data: $responseData');

      Flushbar(
        message: responseData['data'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context).then((value) => Navigator.of(context).pop());
    }

    print('REFRESH DATA: $refreshData');
  }

  Future<void> conveyanceAction(Map<String, dynamic> data,
      Map<String, dynamic> refreshData, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('RESPONSEEEEEEEE DATAAAAAAA: $data');

    var response = await http.post(Uri.parse(AppUrl.conveyanceAction),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseData = json.decode(response.body);

      print('ACTION RESPONSE: $responseData');

      // Flushbar(
      //   message: responseData['data'],
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.blue,
      // )..show(context)
      //     .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
      //           Navigator.of(context).pop();
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ClaimManagerScreen(
      //                   // refreshData
      //                   )));
      //         }));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ClaimManagerScreen()));
      });
    } else {
      var responseData = json.decode(response.body);

      print('ACTION RESPONSE: $responseData');

      Flushbar(
        message: responseData['message'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }

  Future<void> directIncidentalSubmit(
      BuildContext context,
      dynamic request_file,
      dynamic file,
      Map<String, dynamic> request_data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    EasyLoading.show(status: 'Submitting Claim...');

    // var response = await http.post(Uri.parse(AppUrl.incidentalFinalSubmit),
    //     body: json.encode(request_data),
    //     headers: {
    //       'Authorization': 'Bearer ${localStorage.getString('token')}',
    //       'Content-Type': 'application/json'
    //     });

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.incidentalFinalSubmit));

    request.headers
        .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    request.fields['claim_no'] = request_data['claim_no'];
    request.fields['gst_no'] = request_data['gst_no'];
    request.fields['gst_amount'] = request_data['gst_amount'];
    request.fields['basic_amount'] = request_data['basic_amount'];
    request.fields['claim_amount'] = request_data['claim_amount'];
    request.fields['purpose'] = request_data['purpose'];
    request.fields['service_provider'] = request_data['service_provider'];
    request.fields['bill_no'] = request_data['bill_no'];
    request.files.add(
        await http.MultipartFile.fromPath('attachment', file.path.toString()));

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // print('Saved CLAIM: ${localStorage.getString('claimNo')}');
      // var responseData = json.decode(response.body);

      final responseString = await response.stream.bytesToString();

      print('Responseeeee: $responseString');

      EasyLoading.showSuccess("Submmited CLAIM")
          .then((value) => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SuccessTickScreen())))
          .then((value) {
        Provider.of<UserIncidentalViewModel>(context, listen: false)
            .getUserIncidental();
        Navigator.of(context).pop();
      });
      EasyLoading.dismiss();

      print('SUBMITTED INCIDENTAL: ${response.stream.bytesToString()}');

      // Flushbar(
      //   message: 'Claim Submitted Successfully',
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.blue,
      // )..show(context)
      //     .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
      //           Navigator.of(context).pop();
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => IncidentalExpenseScreen()));
      //         }));

      // Navigator.removeRoute(context,
      //     MaterialPageRoute(builder: (context) => IncidentalClaimsScreen()));
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.of(context).pop();
      //   Navigator.of(context).push(
      //       MaterialPageRoute(builder: (context) => IncidentalExpenseScreen()));
      // });
    } else {
      // print('SUCCESS ERROR: $error');
      // var responseData = json.decode(response.body);

      EasyLoading.dismiss();
      final responseString = await response.stream.bytesToString();

      print('Failed Response: $responseString');

      Flushbar(
        message: 'An Error Occured',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }

  Future<void> postFinalIncidentalSubmit(
      BuildContext context,
      // dynamic request_file,
      // dynamic file,
      Map<String, String> request_data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    EasyLoading.show(status: 'Submitting Claim...');

    var response = await http.post(Uri.parse(AppUrl.incidentalFinalSubmit),
        body: json.encode(request_data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      // print('Saved CLAIM: ${localStorage.getString('claimNo')}');
      var responseData = json.decode(response.body);
      EasyLoading.showSuccess("Submmited CLAIM")
          .then((value) => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SuccessTickScreen())))
          .then((value) {
        Provider.of<UserIncidentalViewModel>(context, listen: false)
            .getUserIncidental();
        Navigator.of(context).pop();
      });
      // Flushbar(
      //   message: responseData['data'].toString(),
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.blue,
      // )..show(context);
      // Provider.of<UserIncidentalViewModel>(context, listen: false)
      //     .getUserIncidental();
    } else {
      // print('SUCCESS ERROR: $error');
      var responseData = json.decode(response.body);

      Flushbar(
        message: responseData['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }

  // Future<void> editIncidentalExpense(
  //     BuildContext context, Map<String, dynamic> data) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   // Navigator.of(context, rootNavigator: true).pop();

  //   var response = await http.post(Uri.parse(AppUrl.incidentalUpdate),
  //       body: json.encode(data),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${localStorage.getString('token')}'
  //       });

  //   if (response.statusCode >= 200) {
  //     var responseData = json.decode(response.body);

  //     Flushbar(
  //       message: responseData['data'].toString(),
  //       icon: Icon(
  //         Icons.info_outline,
  //         size: 28,
  //         color: Colors.blue,
  //       ),
  //       duration: Duration(seconds: 3),
  //       leftBarIndicatorColor: Colors.blue,
  //     )..show(context).then((value) {
  //         Provider.of<ManagerIncidentalViewModel>(context, listen: false)
  //             .getManagerIncidental();
  //         Navigator.of(context).pop();
  //       });
  //   } else {
  //     var responseData = json.decode(response.body);

  //     Flushbar(
  //       message: responseData['data'].toString(),
  //       icon: Icon(
  //         Icons.info_outline,
  //         size: 28,
  //         color: Colors.red,
  //       ),
  //       duration: Duration(seconds: 3),
  //       leftBarIndicatorColor: Colors.red,
  //     )..show(context);
  //   }
  // }
}
