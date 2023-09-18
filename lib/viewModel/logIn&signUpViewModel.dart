import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/loginScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/authRepository.dart';
import '../res/components/bottomNavigationBar.dart';
import '../services/locationPermissions.dart';
import '../utils/routes/routeNames.dart';
import '../res/components/alert_dialog.dart';
import 'package:provider/provider.dart';
import '../viewModel/userViewModel.dart';
import '../models/authenticationModel.dart';
import '../views/screens/introScreen.dart';
import '../views/screens/otpScreen.dart';
import '../views/screens/shimmerScreen.dart';
import '../views/screens/signup/kycdetails_Screen.dart';
import '../views/screens/signup/signupdetails_Screen.dart';
import './leaveRemainingViewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'announcementViewModel.dart';
import 'claimsStatusViewModel.dart';
import 'claimzListViewModel.dart';
import 'leaveRequestViewModel.dart';
import 'profileViewModel.dart';
import 'toDoViewModel.dart';

class LoginSignUpViewModel with ChangeNotifier {
  final myRepo = AuthRepository();
  bool _count = true;
  bool get count => _count;
  var returnedResponse;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  String newPassword = '';
  String confirmPassword = '';

  Map<String, dynamic> _verificationResponse = {};
  Map<String, dynamic> _kycResponse = {};
  Map<String, dynamic> _bankDetails = {};

  Map<String, dynamic> get verificationResponse {
    return {..._verificationResponse};
  }

  Map<String, dynamic> get kycResponse {
    return {..._kycResponse};
  }

  Map<String, dynamic> get bankDetails {
    return {..._bankDetails};
  }

  Map<String, dynamic> _createAccountResponse = {};

  Map<String, dynamic> get createAccountResponse {
    return {..._createAccountResponse};
  }

  set count(bool counting) {
    _count = counting;
    notifyListeners();
  }

  bool _loading = false;

  bool get loading {
    return _loading;
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<dynamic> verificationCode(
      String verificationCode, BuildContext context) async {
    print('API CALLEEEEEDDDDDD');
    print('VERIFICATION CODE: $verificationCode');

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.verificationDetails),
        body: json.encode({'unique_id': verificationCode}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _verificationResponse = json.decode(response.body);

      print('VERIFICATION s: $_verificationResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'An Error Occured',
        message: 'Code Verified',
        barBlur: 20,
      ).show(context);

      localStorage.setInt('userId', _verificationResponse['data']['id']);
    } else {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'An Error Occured',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }

    print('VERIFICATION RESPONSE: $_verificationResponse');

    notifyListeners();
    return _verificationResponse;
  }

  Future<void> accountCreation(
      dynamic data, String name, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.createAccount),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _createAccountResponse = json.decode(response.body);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Kycdetails_Screen(name)));
    } else {
      _createAccountResponse = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'An Error Occured',
        message: _createAccountResponse['password'][0],
        barBlur: 20,
      ).show(context);
    }

    print('Account Creation Response: $_createAccountResponse');
  }

  Future<void> kycDetailsUpload(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // data['candidate_id'] = localStorage.getInt('userId')!;

    print('DATA: $data');

    var response = await http.post(Uri.parse(AppUrl.documentsUpload),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _kycResponse = json.decode(response.body);
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'KYC Done',
        barBlur: 20,
      ).show(context);
    } else {
      // _kycResponse = {};
      _kycResponse = json.decode(response.body);

      print('Response: $_kycResponse');
    }

    print('KYC Response: $_kycResponse');
  }

  Future<void> bankDetailsUpload(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('BANKKKKKKKK: $data');

    var response = await http.post(Uri.parse(AppUrl.documentsUpload),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${localStorage.getString('token')}'
        });

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      _bankDetails = json.decode(response.body);
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'Bank Details Uploaded',
        barBlur: 20,
      ).show(context);
    } else {
      _bankDetails = json.decode(response.body);
    }

    print('Bank Response: $_bankDetails');
  }

  Future<void> documentUpload(
      BuildContext context,
      File aadhar_back,
      File aadhar_front,
      File voter_front,
      File voter_back,
      File pan_front,
      File pan_back,
      File passport_front,
      File passport_back,
      File ten,
      File twelve,
      File graduate,
      File post_graduate,
      File passbook,
      int id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var result;

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.documentsUpload));

    print('Aadhar Back: $aadhar_back');

    print('Aadhar Front: $aadhar_front');

    print('Pan Back: $pan_front');

    print('Pan Back: $pan_back');

    print('Voter Front: $voter_front');

    print('Voter Back: $voter_back');

    print('Passbook Front: $passport_front');

    print('Passbook Back: $passport_back');

    print('Ten: $ten');

    print('Twelve: $twelve');

    print('Graduate: $graduate');

    print('Post Graduate: $post_graduate');

    print('Passbook: $passbook');

    print('User ID: $id');

    // request.headers
    //     .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    request.files.add(await http.MultipartFile.fromPath(
        'aadhar_back', aadhar_back.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'aadhar_front', aadhar_front.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'voter_front', voter_front.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'voter_back', voter_back.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'pan_front', pan_front.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'pan_back', pan_back.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'passport_front', passport_front.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'passport_back', passport_back.path.toString()));

    request.files
        .add(await http.MultipartFile.fromPath('ten', ten.path.toString()));

    request.files.add(
        await http.MultipartFile.fromPath('twelve', twelve.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'graduate', graduate.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'post_graduate', post_graduate.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'passbook', passbook.path.toString()));

    request.fields['candidate_id'] = id.toString();

    // Map<String, dynamic> data = {'candidate_id': id};

    // request.fields['candidate_id'] = jsonEncode(data['candidate_id']);

    var response = await request.send();

    var res = await http.Response.fromStream(response);

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      result = jsonDecode(res.body) as dynamic;

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'Documents Uploaded',
        barBlur: 20,
      ).show(context);
    } else {
      result = jsonDecode(res.body) as dynamic;

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }

    print('Response Stream Documents: $result');
  }

  Future<void> previousCompanyDetail(
      BuildContext context,
      File offer_letter,
      File resignation,
      File appointment,
      File release,
      File payslip,
      int id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var result;

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.documentsUpload));

    // request.headers
    //     .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    request.files.add(await http.MultipartFile.fromPath(
        'offer_letter', offer_letter.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'resignation', resignation.path.toString()));

    request.files.add(await http.MultipartFile.fromPath(
        'appointment', appointment.path.toString()));

    request.files.add(
        await http.MultipartFile.fromPath('release', release.path.toString()));

    request.files.add(
        await http.MultipartFile.fromPath('payslip', payslip.path.toString()));

    request.fields['candidate_id'] = id.toString();

    var response = await request.send();

    var res = await http.Response.fromStream(response);

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      result = jsonDecode(res.body) as dynamic;

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'Documents Uploaded',
        barBlur: 20,
      ).show(context).then((_) => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => IntroScreen(true))));
    } else {
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Failed',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setLoading(true);
    myRepo.loginApi(data).then((value) {
      setLoading(false);

      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      String approval = value['data']['approval'].toString();
      userPreference
          .saveUser(Data(
              accessToken: value['data']['access_token'],
              role: value['data']['role'],
              id: value['data']['id'],
              approval: approval ??= "null",
              candidateStatus: value['data']['candidate_status'],
              email: value['data']['email'],
              name: value['data']['name'],
              verificationCode: value['data']['verification_code']))
          .then((_) {
        localStorage.setInt('id', value['data']['id']);

        localStorage.setString('deviceId', data['device_id']);

        Navigator.of(context).pop();

        Flushbar(
          duration: const Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.BOTTOM,
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.error, color: Colors.white),
          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          // title: 'Login Successful',
          message: 'Login Successful',
          barBlur: 20,
        ).show(context);
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => ShimmerScreen()));

        if (localStorage.getInt('candidateStatus') == 0) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'Please Complete Your Onboarding from SignUp',
            barBlur: 20,
          ).show(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        } else if (localStorage.getInt('candidateStatus') == 1) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'Please Complete Your Profile',
            barBlur: 20,
          ).show(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Kycdetails_Screen(localStorage.getString('name')!)));
        } else if (localStorage.getInt('candidateStatus') == 2 ||
            localStorage.getInt('candidateStatus') == 3 ||
            localStorage.getInt('candidateStatus') == 4) {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'Login Successful',
            barBlur: 20,
          ).show(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ShimmerScreen()));
        } else {
          Flushbar(
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.circular(10),
            icon: const Icon(Icons.error, color: Colors.white),
            // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
            // title: 'Login Successful',
            message: 'Invalid Login',
            barBlur: 20,
          ).show(context);
        }
      });

      // Provider.of<ToDoViewModel>(context, listen: false)
      //     .getAllToDoList()
      //     .then((_) {
      //   Provider.of<ClaimzListViewModel>(context, listen: false)
      //       .getClaimzList()
      //       .then((_) {
      //     Provider.of<LeaveRemainingViewModel>(context, listen: false)
      //         .getLeaveBalance()
      //         .then((value) {
      //       Provider.of<ClaimzStatusViewModel>(context, listen: false)
      //           .getClaimzStatuss()
      //           .then((value) {
      //         Provider.of<ProfileViewModel>(context, listen: false)
      //             .getProfileDetails()
      //             .then((value) {
      //           Provider.of<LeaveRequestViewModel>(context, listen: false)
      //               .getLeaveRequest()
      //               .then((value) {
      //             Provider.of<TodaysTaskList>(context, listen: false)
      //                 .getTodaysTasks()
      //                 .then((value) {
      //               Provider.of<AnnouncementViewModel>(context, listen: false)
      //                   .getAllAnouncements(
      //                       DateFormat('MMMM')
      //                           .format(DateTime.now())
      //                           .toString(),
      //                       DateFormat('yyyy')
      //                           .format(DateTime.now())
      //                           .toString())
      //                   .then((value) {
      //                 // setState(() {
      //                 //   isLoading = false;
      //                 // });
      //                 // await Future.delayed(Duration(seconds: 4));
      //                 Provider.of<LocationProvider>(context, listen: false)
      //                     .getLocation()
      //                     .then((value) {
      //                   Navigator.of(context).pop();
      //                   Navigator.of(context).push(MaterialPageRoute(
      //                       builder: (context) => CustomBottomNavigation(2)));
      //                 });
      //               });
      //             });
      //           });
      //         });
      //       });
      //     });
      //   });
      // });

      // Navigator.pushNamed(context, RouteNames.navbar);
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Login Successful',
      //           subtitle: 'Login Successful',
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));

      if (kDebugMode) {
        print('Login Value: ${value.toString()}');
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Login Failed',
      //           subtitle: 'Login Failed',
      //           onOk: () => Navigator.of(context).pop(),
      //           onCancel: () => Navigator.of(context).pop(),
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Login Failed',
        message: 'Login Failed',
        barBlur: 20,
      ).show(context);
      if (kDebugMode) {
        print(error.toString());
      }
      print('LOGIN ERROR: ${error.toString()}');

      print('LOGIN ERROR: ${error.toString()}');
    });
  }

  Future<void> logout(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // var response = await http.post(Uri.parse(AppUrl.logOut), headers: {
    //   'Authorization': 'Bearer ${localStorage.getString('token')}'
    // });

    // if (response.statusCode == 200) {
    //   localStorage.remove('token');
    //   localStorage.clear();
    // } else {
    //   Flushbar(
    //     duration: const Duration(seconds: 4),
    //     flushbarPosition: FlushbarPosition.BOTTOM,
    //     borderRadius: BorderRadius.circular(10),
    //     icon: const Icon(Icons.error, color: Colors.white),
    //     // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
    //     title: 'Logout Failed',
    //     message: 'Logout Failed',
    //     barBlur: 20,
    //   ).show(context);
    // }

    String authToken = localStorage.getString('token').toString();

    myRepo.logOut(authToken).then((value) {
      Provider.of<UserViewModel>(context, listen: false).removeToken();
      // localStorage.remove('token');

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));

      if (kDebugMode) {
        print(value.toString());
        print('LOGGED OUT');
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      // CustomDialog(
      //   title: 'Sign Up Failed',
      //   subtitle: error.toString(),
      //   onOk: () => Navigator.of(context).pop(),
      //   onCancel: () => Navigator.of(context).pop(),
      // );
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Logout Failed',
        message: 'Logout Failed',
        barBlur: 20,
      ).show(context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.forgotPassword),
        body: json.encode({'email': email}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OtpScreen(email)));
    } else {
      var responseCode = json.decode(response.body);

      print('Forgot Password Error: $responseCode');
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Error',
      //           subtitle: 'An Error Occured',
      //           onOk: () {},
      //           onCancel: () {},
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
  }

  Future<void> validateOtp(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .post(Uri.parse(AppUrl.verifyOtp), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 62, 61, 61),
                title: Text('Change Password',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 18)),
                content: Container(
                  height: SizeVariables.getHeight(context) * 0.17,
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _newPassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            hintText: 'New Password',
                            hintStyle: TextStyle(color: Colors.white),
                            errorStyle:
                                TextStyle(fontSize: 12, color: Colors.red),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            // border: InputBorder.none,
                            fillColor: Colors.grey,
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'Please Enter Password';
                            } else {
                              newPassword = value;
                            }
                          },
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.05),
                        TextFormField(
                          controller: _confirmPassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.white),
                            errorStyle:
                                TextStyle(fontSize: 12, color: Colors.red),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            // border: InputBorder.none,
                            fillColor: Colors.grey,
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'Please Confirm Password';
                            } else {
                              confirmPassword = value;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          // Provider.of<LoginSignUpViewModel>(context,
                          //         listen: false)
                          //     .forgotPassword(email, context);
                          resetPassword(_newPassword.text,
                              _confirmPassword.text, data['email'], context);
                        }
                      },
                      child: Text(
                        'Change Password',
                        style: Theme.of(context).textTheme.bodyText1,
                      ))
                ],
              ));
    } else {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Error',
      //           subtitle: 'Password Reset Failed',
      //           onOk: () {},
      //           onCancel: () {},
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: 'Password Reset Failed',
        barBlur: 20,
      ).show(context);
    }
  }

  Future<void> resetPassword(String newPassword, String confirmPassword,
      String email, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.resetPassword),
        body: json.encode({
          'email': email,
          'password': newPassword,
          'confirm_password': confirmPassword
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Success',
      //           subtitle: 'Password has been changed',
      //           onOk: () {},
      //           onCancel: () {},
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Success',
        message: 'Password has been changed',
        barBlur: 20,
      ).show(context);
      email = '';
      newPassword = '';
      confirmPassword = '';
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //           title: 'Error',
      //           subtitle: 'Password reset failed. Please try again!',
      //           onOk: () {},
      //           onCancel: () {},
      //         ));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Error',
        message: 'Password reset failed. Please try again!',
        barBlur: 20,
      ).show(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      email = '';
      newPassword = '';
      confirmPassword = '';
    }
  }

  Future<void> changePassword(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // String authToken = localStorage.getString('token').toString();

    if (kDebugMode) {
      print('Data As Received: $data');
    }

    var response = await http.post(Uri.parse(AppUrl.changePassword),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('token')}',
          'Content-Type': 'application/json'
        });

    print('ISSEEEE ${json.decode(response.body)}');

    if (response.statusCode == 200) {
      returnedResponse = json.decode(response.body);
      print('Returned Response $returnedResponse');
      // showDialog(
      //         context: context,
      //         builder: (context) => CustomDialog(
      //             title: 'Success',
      //             subtitle: returnedResponse['message'],
      //             onOk: () => Navigator.of(context).pop(),
      //             onCancel: () => Navigator.of(context).pop()))
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Success',
        message: returnedResponse['message'],
        barBlur: 20,
      ).show(context).then((value) => Navigator.of(context).pop());
    } else {
      print('Returned Response Error $returnedResponse');

      // showDialog(
      //     context: context,
      //     builder: (context) => CustomDialog(
      //         title: 'Failed',
      //         subtitle: 'Password Reset Failed',
      //         onOk: () => Navigator.of(context).pop(),
      //         onCancel: () => Navigator.of(context).pop()));
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Failed',
        message: returnedResponse.toString(),
        barBlur: 20,
      ).show(context);
    }
  }
}


// import 'package:claimz/res/appUrl.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../repository/authRepository.dart';
// import '../utils/routes/routeNames.dart';
// import '../res/components/alert_dialog.dart';
// import 'package:provider/provider.dart';
// import '../viewModel/userViewModel.dart';
// import '../models/authenticationModel.dart';
// import '../views/screens/otpScreen.dart';
// import './leaveRemainingViewModel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LoginSignUpViewModel with ChangeNotifier {
//   final myRepo = AuthRepository();
//   bool _count = true;
//   bool get count => _count;
//   var returnedResponse;

//   set count(bool counting) {
//     _count = counting;
//     notifyListeners();
//   }

//   bool _loading = false;

//   bool get loading {
//     return _loading;
//   }

//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   Future<void> loginApi(dynamic data, BuildContext context) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     setLoading(true);
//     myRepo.loginApi(data).then((value) {
//       setLoading(false);

//       final userPreference = Provider.of<UserViewModel>(context, listen: false);

//       userPreference.saveUser(Data(
//           accessToken: value['data']['access_token'],
//           role: value['data']['role'],
//           id: value['data']['id']));

//       localStorage.setInt('id', value['data']['id']);

//       Navigator.pushNamed(context, RouteNames.navbar);
//       showDialog(
//           context: context,
//           builder: (context) => CustomDialog(
//                 title: 'Login Successful',
//                 subtitle: 'Login Successful',
//                 onOk: () => Navigator.of(context).pop(),
//                 onCancel: () => Navigator.of(context).pop(),
//               ));
//       if (kDebugMode) {
//         print('Login Value: ${value.toString()}');
//       }
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       showDialog(
//           context: context,
//           builder: (context) => CustomDialog(
//                 title: 'Login Failed',
//                 subtitle: 'Login Failed',
//                 onOk: () => Navigator.of(context).pop(),
//                 onCancel: () => Navigator.of(context).pop(),
//               ));
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       print('LOGIN ERROR: ${error.toString()}');
//     });
//   }

//   Future<void> logout(dynamic data, BuildContext context) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     String authToken = localStorage.getString('token').toString();

//     myRepo.logOut(authToken).then((value) {
//       Provider.of<UserViewModel>(context, listen: false).removeToken();
//       if (kDebugMode) {
//         print(value.toString());
//         print('LOGGED OUT');
//       }
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       CustomDialog(
//         title: 'Sign Up Failed',
//         subtitle: error.toString(),
//         onOk: () => Navigator.of(context).pop(),
//         onCancel: () => Navigator.of(context).pop(),
//       );
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     });
//   }

//   Future<void> forgotPassword(String email, BuildContext context) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     var response = await http.post(Uri.parse(AppUrl.forgotPassword),
//         body: json.encode({'email': email}),
//         headers: {
//           'Authorization': 'Bearer ${localStorage.getString('token')}',
//           'Content-Type': 'application/json'
//         });

//     if (response.statusCode == 200) {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => OtpScreen(email)));
//     } else {
//       showDialog(
//           context: context,
//           builder: (context) => CustomDialog(
//                 title: 'Error',
//                 subtitle: 'An Error Occured',
//                 onOk: () {},
//                 onCancel: () {},
//               ));
//     }
//   }

//   Future<void> changePassword(dynamic data, BuildContext context) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();

//     String authToken = localStorage.getString('token').toString();

//     if (kDebugMode) {
//       print('Data As Received: $data');
//     }

//     var response = await http.post(Uri.parse(AppUrl.changePassword),
//         body: json.encode(data),
//         headers: {
//           'Authorization': 'Bearer ${localStorage.getString('token')}',
//           'Content-Type': 'application/json'
//         });

//     if (response.statusCode == 200) {
//       returnedResponse = json.decode(response.body);
//       print(returnedResponse);
//       showDialog(
//               context: context,
//               builder: (context) => CustomDialog(
//                   title: 'Success',
//                   subtitle: returnedResponse['message'],
//                   onOk: () => Navigator.of(context).pop(),
//                   onCancel: () => Navigator.of(context).pop()))
//           .then((value) => Navigator.of(context).pop());
//     } else {
//       print(returnedResponse);

//       showDialog(
//           context: context,
//           builder: (context) => CustomDialog(
//               title: 'Failed',
//               subtitle: 'Password Reset Failed',
//               onOk: () => Navigator.of(context).pop(),
//               onCancel: () => Navigator.of(context).pop()));
//     }
//   }
// }