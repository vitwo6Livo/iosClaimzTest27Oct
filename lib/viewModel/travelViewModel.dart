import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/apiResponse.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/models/travelListModel.dart';
import 'package:claimz/repository/travelClaimRepository.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:http/http.dart' as http;
import '../views/screens/managertravelClaimList.dart';
import '../views/screens/success_tick_screen.dart';
import '../views/screens/travelClaimList.dart';
import 'package:http/http.dart' as http;

class TravelViewModel with ChangeNotifier {
  String finalAmount = "0";
  updateSomeValue(String text) {
    finalAmount = text;
    notifyListeners();
  }

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  Map<String, dynamic> _travelStatus = {};
  List<Map<String, dynamic>> _pendingapproval = [];
  List<Map<String, dynamic>> _pendingpayment = [];
  List<Map<String, dynamic>> _partialpayment = [];
  List<Map<String, dynamic>> _paid = [];
  List<Map<String, dynamic>> _rejected = [];
  Map<String, dynamic> _travellist = {};

  Map<String, dynamic> get travellist {
    return {..._travellist};
  }

  Map<String, dynamic> get travelStatus {
    return {..._travelStatus};
  }

  List<Map<String, dynamic>> get pendingapproval {
    return [..._pendingapproval];
  }

  List<Map<String, dynamic>> get pendingpayment {
    return [..._pendingpayment];
  }

  List<Map<String, dynamic>> get partialpayment {
    return [..._partialpayment];
  }

  List<Map<String, dynamic>> get paid {
    return [..._paid];
  }

  List<Map<String, dynamic>> get rejected {
    return [..._rejected];
  }

  Future<void> postTravelList(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('DATA: $data');

    String authToken = localStorage.getString('token').toString();

    _travelClaimRepository
        .postTravelList(AppUrl.travel_list_date, data, authToken)
        .then((value) {
      setTravelList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setTravelList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postTravellist(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Manager Travellllllllllllllllll: $data');

    var response = await http.post(Uri.parse(AppUrl.travel_list_date),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode == 200) {
      _travellist = json.decode(response.body);

      print('Travel List: $_travellist');
    } else {
      _travellist = json.decode(response.body);

      print('Travel List: $_travellist');

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
    notifyListeners();
  }

  Future<void> getTravelClaimStatus(String doc) async {
    _pendingapproval = [];
    _pendingpayment = [];
    _partialpayment = [];
    _paid = [];
    _rejected = [];
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse(AppUrl.travel_list_doc + "/" + doc), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${localStorage.getString('token')}'
    });

    print(localStorage.getString('token'));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print(response.toString());
      _travelStatus = json.decode(response.body);
      for (int i = 0; i < _travelStatus['data'].length; i++) {
        if (_travelStatus['data'][i]['status'] == 'Pending for Approval') {
          _pendingapproval.add(_travelStatus['data'][i]);
        } else if (_travelStatus['data'][i]['status'] ==
            'Pending for Payment') {
          _pendingpayment.add(_travelStatus['data'][i]);
        } else if (_travelStatus['data'][i]['status'] == 'Partial Paid') {
          _partialpayment.add(_travelStatus['data'][i]);
        } else if (_travelStatus['data'][i]['status'] == 'Fully Paid') {
          _paid.add(_travelStatus['data'][i]);
        } else if (_travelStatus['data'][i]['status'] == 'Rejected')
          _rejected.add(_travelStatus['data'][i]);
      }
    } else {
      // print('ERROR');
      _travelStatus = json.decode(response.body);
    }
    if (kDebugMode) {
      print('Manager Travel Claim: $_travelStatus');
    }

    notifyListeners();
  }

  TravelClaimRepository _travelClaimRepository = TravelClaimRepository();

  ApiResponse<iternaryModel> iternaryDetails = ApiResponse.loading();
  ApiResponse<travelListModel> travelList = ApiResponse.loading();

  void setTravelList(ApiResponse<travelListModel> response) {
    travelList = response;
    notifyListeners();
  }

  setIternaryData(ApiResponse<iternaryModel> response) {
    iternaryDetails = response;
    notifyListeners();
  }

  Future<void> postTravelIternary(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    // _travelClaimRepository.postIternaryDetails(AppUrl.travel_getdocdetails, data,authToken).then((value) {
    _travelClaimRepository
        .postIternaryDetails(AppUrl.travel_itinerary, data, authToken)
        .then((value) {
      setIternaryData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setIternaryData(ApiResponse.error(error.toString()));
    });
  }

  Future<void> postTravelDoc(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    // _travelClaimRepository.postIternaryDetails(AppUrl.travel_getdocdetails, data,authToken).then((value) {
    _travelClaimRepository
        .postIternaryDetails(AppUrl.travel_getdocdetails, data, authToken)
        .then((value) {
      setIternaryData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setIternaryData(ApiResponse.error(error.toString()));
    });
  }

  Future<dynamic> postPurposeDetails(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    EasyLoading.show(status: 'loading...');

    String authToken = localStorage.getString('token').toString();
    dynamic resp = _travelClaimRepository
        .postPurpose(AppUrl.travel_purpose, data, authToken)
        .then((value) {
      EasyLoading.dismiss();
      Flushbar(
        message: value['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
      return value;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
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

    notifyListeners();
    return resp;
  }

  Future<dynamic> postFinalSubmit(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // EasyLoading.show(status: 'loading...');

    print('DOC IDDDD: $data');

    //using same repository func as return type is same
    String authToken = localStorage.getString('token').toString();
    dynamic resp = _travelClaimRepository
        .postPurpose(AppUrl.travel_final_submit, data, authToken)
        .then((value) {
      EasyLoading.dismiss();

      // EasyLoading.showSuccess("Submmited Claims")
      //     .then((value) => Navigator.of(context).push(
      //         MaterialPageRoute(builder: (context) => SuccessTickScreen())))
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        // Provider.of<UserIncidentalViewModel>(context, listen: false)
        //     .getUserIncidental();
        Navigator.of(context).pop();
        // Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TravelClaimList()));
      });
      EasyLoading.dismiss();
      // Flushbar(
      //   message: value['data'].toString(),
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue,
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.blue,
      // )..show(context);
      // return value;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
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

    notifyListeners();
    return resp;
  }

  Future<dynamic> postManagerApprove(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.travel_approval),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      print('Travellll Responseeeee: ${json.decode(response.body)}');

      // Navigator.of(context).pop();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessTickScreen()))
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ManagerTravelClaimList()));
      });
      // .then((value) => Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ManagerTravelClaimList())));

      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => ManagerTravelClaimList()));
    } else {
      print('Travellll Responseeeee: ${json.decode(response.body)}');
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

    // EasyLoading.show(status: 'loading...');

    //using same repository func as return type is same
    // String authToken = localStorage.getString('token').toString();
    // dynamic resp = _travelClaimRepository
    //     .postPurpose(AppUrl.travel_approval, data, authToken)
    //     .then((_) => Navigator.of(context)
    //             .push(MaterialPageRoute(
    //                 builder: (context) => SuccessTickScreen()))
    //             .then((value) => Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (context) => ManagerTravelClaimList())))
    //         //     {
    //         //   EasyLoading.showSuccess("Submmited CLAIM")
    //         //       .then((value) => Navigator.of(context).push(
    //         //           MaterialPageRoute(builder: (context) => SuccessTickScreen())))
    //         //       .then((value) {
    //         //     Navigator.of(context).push(
    //         //         MaterialPageRoute(builder: (context) => ManagerTravelClaimList()));
    //         //     // Navigator.of(context).pop();
    //         //     // Navigator.of(context).pop();
    //         //   });
    //         //   // EasyLoading.dismiss();
    //         //   // Flushbar(
    //         //   //   message: value['data'].toString(),
    //         //   //   icon: Icon(
    //         //   //     Icons.info_outline,
    //         //   //     size: 28.0,
    //         //   //     color: Colors.blue,
    //         //   //   ),
    //         //   //   duration: Duration(seconds: 3),
    //         //   //   leftBarIndicatorColor: Colors.blue,
    //         //   // )..show(context);
    //         //   return value;
    //         // }
    //         )
    //     .onError((error, stackTrace) {
    //   EasyLoading.dismiss();
    //   Flushbar(
    //     message: error.toString(),
    //     icon: Icon(
    //       Icons.info_outline,
    //       size: 28.0,
    //       color: Colors.blue,
    //     ),
    //     duration: Duration(seconds: 3),
    //     leftBarIndicatorColor: Colors.blue,
    //   )..show(context);
    // });

    // notifyListeners();
    // return resp;
    notifyListeners();
  }

  Future<dynamic> postManagerPartial(BuildContext context, dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    EasyLoading.show(status: 'loading...');

    //using same repository func as return type is same
    String authToken = localStorage.getString('token').toString();
    dynamic resp = _travelClaimRepository
        .postPurpose(AppUrl.travel_approval_partial, data, authToken)
        .then((value) {
      EasyLoading.dismiss();
      Flushbar(
        message: value['data'].toString(),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context)
          .then((_) => WidgetsBinding.instance.addPostFrameCallback((_) {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) =>
                //         ManagerIncidentalExpenseScreen())
                //         );
                Navigator.of(context).pop();
              }));
      return value;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
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

    notifyListeners();
    return resp;
  }

  Future<dynamic> postApprovalLog(dynamic data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    //using same repository func as return type is same
    String authToken = localStorage.getString('token').toString();
    dynamic resp = _travelClaimRepository
        .postPurpose(AppUrl.travel_claim_approvalLog, data, authToken)
        .then((value) {
      return value;
    }).onError((error, stackTrace) {});
    notifyListeners();
    return resp;
  }

  Future<void> postTravelApproval(Map<String, dynamic> data, Map fielddata,
      String status, String tid) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String authToken = localStorage.getString('token').toString();

    if (status == "payment_pending") {
      _pendingpayment.add(data);
      _pendingapproval
          .removeWhere((element) => element['id'] == int.parse(tid));
    } else if (status == "partial_paid") {
      _partialpayment.add(data);
      _pendingpayment.removeWhere((element) => element['id'] == int.parse(tid));
    } else if (status == "paid") {
      _paid.add(data);
      _pendingpayment.removeWhere((element) => element['id'] == int.parse(tid));
    } else {
      _rejected.add(data);
      _pendingpayment.removeWhere((element) => element['id'] == int.parse(tid));
      _pendingapproval
          .removeWhere((element) => element['id'] == int.parse(tid));
    }

    _travelClaimRepository
        .postTravelApprove(AppUrl.travel_approval, fielddata, authToken)
        .then((value) {
      // setIternaryData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print(error.toString());
      // setIternaryData(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  Future<dynamic> postTravelFormSubmit(
      BuildContext context,
      Map request_filename,
      i.XFile file,
      Map<String, String> request_data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    EasyLoading.instance
      ..dismissOnTap = false
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    dynamic result = _travelClaimRepository
        .postFormSubmit(token, request_filename, file, request_data)
        .then((value) {
      // print(value.toString());
      EasyLoading.dismiss();
      Flushbar(
        message: 'Saved As Draft',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
      return value;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();

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

    return result;
  }

  Future<dynamic> postTravelFormSubmit2(
      BuildContext context,
      Map request_filename,
      // i.XFile file,
      // i.XFile file2,
      dynamic file,
      dynamic file2,
      Map<String, String> request_data) async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    String token = localStorage.getString('token').toString();
    EasyLoading.instance
      ..dismissOnTap = false
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    dynamic result = _travelClaimRepository
        .postFormSubmit2(token, request_filename, file, file2, request_data)
        .then((value) {
      // print(value.toString());
      EasyLoading.dismiss();
      Flushbar(
        message: 'Saved As Draft',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
      return value;
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();

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

    return result;
  }
}
