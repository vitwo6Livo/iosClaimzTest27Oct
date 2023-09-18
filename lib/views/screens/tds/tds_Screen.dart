import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/screens/tds/investment_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';
import 'widget/disabled.dart';
import 'widget/donation_widget.dart';
import 'widget/investment_Widget.dart';
import 'widget/loanInterest.dart';
import 'widget/medicalAllowance.dart';
import 'widget/others.dart';
import 'widget/political.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { Old, New }

// ignore: camel_case_types
class Tds_Screen extends StatefulWidget {
  const Tds_Screen({super.key});

  @override
  State<Tds_Screen> createState() => _Tds_ScreenState();
}

// ignore: camel_case_types
class _Tds_ScreenState extends State<Tds_Screen> {
  SingingCharacter? _character = SingingCharacter.Old;
  int _selection = 0;
  var docNo = '0';
  var id = '';
  var isLoading = false;
  var status = '';
  var ctc = 0;
  var gross = 0;
  var deduction = 0;
  var tds = 0;
  var exemptAmt = 0;
  var netGross = 0;
  var investmentAmount = 0.0;
  var medicalAmount = 0.0;
  var loanAmount = 0.0;
  var politicalAmount = 0.0;
  var donationAmount = 0.0;
  var othersAmount = 0.0;
  var disabledAmount = 0.0;
  var _limitation1 = '0';
  var _limitation2 = '0';
  var _limitation3 = '0';
  var _limitation4 = '0';
  var _limitation5 = '0';
  var _mLimitation1 = '0';
  var _mLimitation2 = '0';
  var _mLimitation3 = '0';
  var _hEducation = '0';
  var _housingLoan1 = '0';
  var _housingLoan2 = '0';
  var _vehicleloan = '0';
  var _contribution = '0';
  var _individual = '0';
  var _institution = '0';
  var _development = '0';
  var _patens = '0';
  var _income = '0';
  var _earned = '0';
  var _interestEarned = '0';
  var _desable = '0';

  void updateInvestmentAmount(value) {
    setState(() {
      investmentAmount = value;
    });
  }

  void updateMedicalAmount(value) {
    setState(() {
      medicalAmount = value;
    });
  }

  void updateLoanAmount(value) {
    setState(() {
      loanAmount = value;
    });
  }

  void updatePoliticalAmount(value) {
    setState(() {
      politicalAmount = value;
    });
  }

  void updateDonationAmount(value) {
    setState(() {
      donationAmount = value;
    });
  }

  void updateOthersAmount(value) {
    setState(() {
      othersAmount = value;
    });
  }

  void updateDisabledAmount(value) {
    setState(() {
      disabledAmount = value;
    });
  }

  Future<void> _fetchCTC() async {
    setState(() {
      isLoading = true;
    });
    print('isLoading:-----> $isLoading');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.getCTC);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['doc_no'] = docNo;
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print('isLoading:-----> $isLoading');
      var response2 = await http.Response.fromStream(response);
      var responseDecoded = json.decode(response2.body);
      print('responseDecoded---------------: $responseDecoded');
      print('ctc: ${responseDecoded['ctc']}');
      ctc = responseDecoded['ctc'];
      deduction = responseDecoded['deduction'];
      gross = responseDecoded['gross'];
      tds = responseDecoded['tds'];
      exemptAmt = responseDecoded['exampt_amount'];
      netGross = responseDecoded['net_gross'];
    }
  }

  Future<void> _fetchUserDeclaration() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
    };
    try {
      var response =
          await http.get(Uri.parse(AppUrl.userDeclaration), headers: headers);
      // print(Uri.parse(AppUrl.userDeclaration));
      print('response: ${response.body}');
      var resp = json.decode(response.body);
      print('resp: $resp');
      if (resp['data'].length > 0) {
        docNo = resp['data'][0]['doc_no'];
        status = resp['data'][0]['status'];
        for (var i = 0; i < resp['data'].length; i++) {
          print('${resp['data'][i]['declare_submit_id']}');
          if (resp['data'][i]['sub_type_id'] == "1") {
            _limitation1 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '2') {
            _limitation2 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '3') {
            _limitation3 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '4') {
            _limitation4 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '5') {
            _limitation5 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '6') {
            _mLimitation1 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '7') {
            _mLimitation2 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '8') {
            _mLimitation3 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '9') {
            _hEducation = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '10') {
            _housingLoan1 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '11') {
            _housingLoan2 = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '12') {
            _vehicleloan = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          //donation
          if (resp['data'][i]['sub_type_id'] == '13') {
            _institution = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '15') {
            _development = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          //political
          if (resp['data'][i]['sub_type_id'] == '16') {
            _contribution = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '17') {
            _individual = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          //others royalty
          if (resp['data'][i]['sub_type_id'] == '18') {
            _patens = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '19') {
            _income = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '20') {
            _earned = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          if (resp['data'][i]['sub_type_id'] == '21') {
            _interestEarned = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
          //disable
          if (resp['data'][i]['sub_type_id'] == '22') {
            _desable = (resp['data'][i]['amount'] == '')
                ? '0'
                : resp['data'][i]['amount'];
          }
        }
      }
      print('docNumber-------- $docNo');
      print('status-------- $status');
    } catch (e) {
      print('error');
    }
  }

  Future<void> _finalSubmit() async {
    // setState(() {
    //   isLoading = true;
    // });
    await _fetchUserDeclaration();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.finalSubmit);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['doc_no'] = docNo;
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});
    var response = await request.send();
    if (response.statusCode == 200) {
      print('success');
      Flushbar(
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.green,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.check, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'Submitted successfully',
        barBlur: 20,
      ).show(context);
    } else {
      print('status code: ${response.statusCode}');
      print('error');
      Flushbar(
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Login Successful',
        message: 'Something went wrong',
        barBlur: 20,
      ).show(context);
    }
  }

  @override
  void initState() {
    super.initState();
    //_fetchCTC().then((value) => _fetchUserDeclaration());
    _fetchUserDeclaration().then((value) {
      _fetchCTC();
      setState(() {
        investmentAmount = double.parse(_limitation1) +
            double.parse(_limitation2) +
            double.parse(_limitation3) +
            double.parse(_limitation4) +
            double.parse(_limitation5);

        medicalAmount = double.parse(_mLimitation1) +
            double.parse(_mLimitation2) +
            double.parse(_mLimitation3);

        loanAmount = double.parse(_hEducation) +
            double.parse(_housingLoan1) +
            double.parse(_housingLoan2) +
            double.parse(_vehicleloan);

        politicalAmount =
            double.parse(_contribution) + double.parse(_individual);

        donationAmount =
            double.parse(_institution) + double.parse(_development);

        othersAmount = double.parse(_patens) +
            double.parse(_income) +
            double.parse(_earned) +
            double.parse(_interestEarned);

        disabledAmount = double.parse(_desable);
      });
    });

    // investmentAmount = double.parse(_limitation1) +
    //     double.parse(_limitation2) +
    //     double.parse(_limitation3) +
    //     double.parse(_limitation4) +
    //     double.parse(_limitation5);

    // medicalAmount = double.parse(_mLimitation1) +
    //     double.parse(_mLimitation2) +
    //     double.parse(_mLimitation3);

    // loanAmount = double.parse(_hEducation) +
    //     double.parse(_housingLoan1) +
    //     double.parse(_housingLoan2) +
    //     double.parse(_vehicleloan);

    // politicalAmount = double.parse(_contribution) + double.parse(_individual);

    // donationAmount = double.parse(_institution) + double.parse(_development);

    // othersAmount = double.parse(_patens) +
    //     double.parse(_income) +
    //     double.parse(_earned) +
    //     double.parse(_interestEarned);

    // disabledAmount = double.parse(_desable);
  }

  void _detailsButtom() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => Investment(status, updateInvestmentAmount),
    );
  }

  void _detailsMedical() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => MedicalAllowance(status, updateMedicalAmount),
    );
  }

  void _detailsLoan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => LoanInterest(status, updateLoanAmount),
    );
  }

  void _detailsPolitical() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => Political(status, updatePoliticalAmount),
    );
  }

  void _detailsDonation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => DonationWidget(status, updateDonationAmount),
    );
  }

  void _detailsOthers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => OthersRoyalty(status, updateOthersAmount),
    );
  }

  void _detailsDisabled() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => DisabledWidget(status, updateDisabledAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('docNo: $docNo');
    print('investmentAmount: $investmentAmount');
    print('medicalAmount: $medicalAmount');
    print('loanAmount: $loanAmount');
    print('politicalAmount: $politicalAmount');
    print('donationAmount: $donationAmount');
    print('othersRyalty: $othersAmount');
    print('disabled: $disabledAmount');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          // Navigator.pushNamed(context, RouteNames.investmentUpload);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => investmentUpload(
                      //_finalSubmit,
                      docNumber: docNo,
                      status,
                      deduction: deduction.toString(),
                      disabledAmount: disabledAmount.toString(),
                      donationAmount: donationAmount.toString(),
                      investmentAmount: investmentAmount.toString(),
                      loanAmount: loanAmount.toString(),
                      medicalAmount: medicalAmount.toString(),
                      othersAmount: othersAmount.toString(),
                      politicalAmount: politicalAmount.toString(),
                    )),
          );
        },
        child: const Icon(
          Icons.save_as,
          size: 26,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/back button.svg",
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              'TDS Calculator',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.02,
          right: SizeVariables.getWidth(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 110, 108, 108),
                      spreadRadius: 0.5,
                      blurRadius: 15,
                    )
                  ]),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfffF59F23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      child: (isLoading)
                          ? Text(
                              'CTC : wiating...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            )
                          : Text(
                              'CTC : $ctc',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.004,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Check your TDS amount',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.02,
            ),
            Row(
              children: [
                Container(
                  width: SizeVariables.getWidth(context) * 0.5,
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.175,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            children: [
                              Text(
                                'Gross:  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                '₹ ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                              Text(
                                gross.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.green,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Row(
                            children: [
                              const Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'Check your gross amount',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            children: [
                              Text(
                                'Exempt amount:  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                '₹ ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                              (isLoading)
                                  ? Text(
                                      'waiting...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontSize: 15,
                                          ),
                                    )
                                  : Text(
                                      exemptAmt.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontSize: 15,
                                          ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            children: [
                              Text(
                                'Net gross:  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                '₹ ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                              (isLoading)
                                  ? Text(
                                      'waiting...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontSize: 15,
                                          ),
                                    )
                                  : Text(
                                      netGross.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontSize: 15,
                                          ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            children: [
                              Text(
                                'Deduction:  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                '₹ ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 15,
                                    ),
                              ),
                              (isLoading)
                                  ? Text(
                                      'waiting...',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontSize: 15,
                                          ),
                                    )
                                  : Text(
                                      deduction.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.redAccent,
                                            fontSize: 15,
                                          ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Row(
                            children: [
                              const Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'Check your tax ben amount',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 16, 10, 5),
                          child: Container(
                            color: const Color.fromARGB(255, 71, 70, 70),
                            height: SizeVariables.getHeight(context) * 0.0015,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(8, 1, 8, 0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         'Taxable Amount:  ',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyText2!
                        //             .copyWith(
                        //               fontSize: 14,
                        //             ),
                        //       ),
                        //       Text(
                        //         '₹ 5,00,000',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyText2!
                        //             .copyWith(
                        //               fontSize: 14,
                        //             ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeVariables.getWidth(context) * 0.05,
                ),
                Container(
                  width: SizeVariables.getWidth(context) * 0.4,
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.175,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'TDS Amount',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.002,
                        ),
                        Center(
                          child: Text(
                            '₹ $tds',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio<SingingCharacter>(
                                  activeColor: Colors.amber,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  value: SingingCharacter.Old,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _character = value;
                                      _selection = 0;
                                    });
                                  },
                                ),
                                Text(
                                  'Old',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<SingingCharacter>(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  value: SingingCharacter.New,
                                  groupValue: _character,
                                  onChanged: (SingingCharacter? value) {
                                    setState(() {
                                      _character = value;
                                      _selection = 1;
                                    });
                                  },
                                ),
                                Text(
                                  'New',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Declaration',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 18,
                    ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _selection == 0
                      ? listCard(context)
                      : _selection == 1
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 200),
                                    child: Text(
                                      'No data!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 22,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded listCard(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          GestureDetector(
            onTap: _detailsButtom,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Investment',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $investmentAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _detailsMedical,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.amberAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Medical',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $medicalAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _detailsLoan,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Loan',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $loanAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _detailsPolitical,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Political',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $politicalAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _detailsDonation,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.redAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Donation',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $donationAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _detailsOthers,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.orangeAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Others Royalty',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $othersAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _detailsDisabled,
            child: Container(
              height: SizeVariables.getHeight(context) * 0.25,
              decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              // color: _dataTds[index]['color'],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Disabled Individuals',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '₹ $disabledAmount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
