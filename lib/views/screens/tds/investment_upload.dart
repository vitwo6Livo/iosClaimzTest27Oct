import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/theme_provider.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';
import 'animated/card.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class investmentUpload extends StatefulWidget {
  //final Function finalSubmit;
  final String status;
  final String deduction;
  final String investmentAmount;
  final String medicalAmount;
  final String loanAmount;
  final String politicalAmount;
  final String donationAmount;
  final String othersAmount;
  final String disabledAmount;
  final String docNumber;

  investmentUpload(this.status,
      {required this.deduction,
      required this.investmentAmount,
      required this.medicalAmount,
      required this.loanAmount,
      required this.disabledAmount,
      required this.donationAmount,
      required this.othersAmount,
      required this.politicalAmount,
      required this.docNumber});

  @override
  State<investmentUpload> createState() => _investmentUploadState();
}

class _investmentUploadState extends State<investmentUpload> {
  var isLoading = false;

  // final List<Map<String, dynamic>> _data = [
  //   {
  //     //'date': '04/07/2023',
  //     //'Tlimit': '2,00,000',
  //     //'out': '2,50,000',
  //     'name': 'Investment',
  //     'amount': widget.investmentAmount,
  //     'color': Colors.greenAccent.shade100,
  //     //'reason': 'you have still ₹ 50,000 limit eligible.',
  //     //'rColor': Colors.green,
  //   },
  //   {
  //     //'date': '10/07/2023',
  //     //'Tlimit': '1,00,000',
  //     // 'out': '1,00,000',
  //     'name': 'Medical investment',
  //     'amount': '30,000',
  //     'color': Colors.amberAccent.shade100,
  //     // 'reason': 'you have no limit remain.',
  //     // 'rColor': Colors.red,
  //   },
  //   {
  //     // 'date': '15/07/2023',
  //     // 'Tlimit': '80,000',
  //     // 'out': '90,000',
  //     'name': 'Loan',
  //     'amount': '50,000',
  //     'color': Colors.blueAccent.shade100,
  //     // 'reason': 'you have still ₹ 10,000 limit eligible.',
  //     // 'rColor': Colors.green,
  //   },
  //   {
  //     // 'date': '15/07/2023',
  //     // 'Tlimit': '40,000',
  //     // 'out': '40,000',
  //     'name': 'Political investment',
  //     'amount': '50,000',
  //     'color': Colors.amber.shade100,
  //     // 'reason': 'you have no limit remain.',
  //     // 'rColor': Colors.red,
  //   },
  //   {
  //     // 'date': '15/07/2023',
  //     // 'Tlimit': '5,000',
  //     // 'out': '20,000',
  //     'name': 'Donation to Scientific Research & Rural Development.',
  //     'amount': '50,000',
  //     'color': Colors.redAccent.shade100,
  //     // 'reason': 'you have still ₹ 15,000 limit eligible.',
  //     // 'rColor': Colors.green,
  //   },
  //   {
  //     // 'date': '15/07/2023',
  //     // 'Tlimit': '5,000',
  //     // 'out': '20,000',
  //     'name': 'Others Royalty',
  //     'amount': '50,000',
  //     'color': Colors.redAccent.shade100,
  //     // 'reason': 'you have still ₹ 15,000 limit eligible.',
  //     // 'rColor': Colors.green,
  //   },
  //   {
  //     // 'date': '15/07/2023',
  //     // 'Tlimit': '5,000',
  //     // 'out': '20,000',
  //     'name': 'Disability',
  //     'amount': '50,000',
  //     'color': Colors.redAccent.shade100,
  //     // 'reason': 'you have still ₹ 15,000 limit eligible.',
  //     // 'rColor': Colors.green,
  //   },
  // ];

  Future _finalSubmit() async {
    //await _fetchUserDeclaration();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(AppUrl.finalSubmit);
    var request = new http.MultipartRequest('POST', uri);
    request.fields['doc_no'] = widget.docNumber;
    request.headers.addAll(
        {'Authorization': 'Bearer ${sharedPreferences.getString('token')}'});
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
      });
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
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _data = [
      {
        //'date': '04/07/2023',
        //'Tlimit': '2,00,000',
        //'out': '2,50,000',
        'name': 'Investment',
        'amount': widget.investmentAmount,
        'color': Colors.greenAccent.shade100,
        //'reason': 'you have still ₹ 50,000 limit eligible.',
        //'rColor': Colors.green,
      },
      {
        //'date': '10/07/2023',
        //'Tlimit': '1,00,000',
        // 'out': '1,00,000',
        'name': 'Medical investment',
        'amount': widget.medicalAmount,
        'color': Colors.amberAccent.shade100,
        // 'reason': 'you have no limit remain.',
        // 'rColor': Colors.red,
      },
      {
        // 'date': '15/07/2023',
        // 'Tlimit': '80,000',
        // 'out': '90,000',
        'name': 'Loan',
        'amount': widget.loanAmount,
        'color': Colors.blueAccent.shade100,
        // 'reason': 'you have still ₹ 10,000 limit eligible.',
        // 'rColor': Colors.green,
      },
      {
        // 'date': '15/07/2023',
        // 'Tlimit': '40,000',
        // 'out': '40,000',
        'name': 'Political investment',
        'amount': widget.politicalAmount,
        'color': Colors.amber.shade100,
        // 'reason': 'you have no limit remain.',
        // 'rColor': Colors.red,
      },
      {
        // 'date': '15/07/2023',
        // 'Tlimit': '5,000',
        // 'out': '20,000',
        'name': 'Donation to Scientific Research & Rural Development.',
        'amount': widget.donationAmount,
        'color': Colors.redAccent.shade100,
        // 'reason': 'you have still ₹ 15,000 limit eligible.',
        // 'rColor': Colors.green,
      },
      {
        // 'date': '15/07/2023',
        // 'Tlimit': '5,000',
        // 'out': '20,000',
        'name': 'Others Royalty',
        'amount': widget.othersAmount,
        'color': Colors.redAccent.shade100,
        // 'reason': 'you have still ₹ 15,000 limit eligible.',
        // 'rColor': Colors.green,
      },
      {
        // 'date': '15/07/2023',
        // 'Tlimit': '5,000',
        // 'out': '20,000',
        'name': 'Disability',
        'amount': widget.disabledAmount,
        'color': Colors.redAccent.shade100,
        // 'reason': 'you have still ₹ 15,000 limit eligible.',
        // 'rColor': Colors.green,
      },
    ];
    print('object');
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            (widget.status == '1') ? Colors.grey : Colors.amberAccent,
        onPressed: (widget.status == '1')
            ? null
            : () {
                showGeneralDialog(
                  barrierDismissible: true,
                  barrierLabel: '',
                  barrierColor: Colors.black38,
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (ctx, anim1, anim2) => CupertinoAlertDialog(
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '* Please check before confirm.',
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '* The request can\'t be amended after your final submission.',
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(115, 231, 231, 231),
                                ),
                                child: Text(
                                  'agree',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: (isLoading)
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                ),
                                onPressed: (isLoading == true)
                                    ? () {
                                        Flushbar(
                                          duration: const Duration(seconds: 4),
                                          backgroundColor: Colors.black,
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          icon: const Icon(Icons.check,
                                              color: Colors.white),
                                          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                                          // title: 'Login Successful',
                                          message:
                                              'Sorry, submit cannot more than once!',
                                          barBlur: 20,
                                        ).show(context);
                                      }
                                    : () async {
                                        await _finalSubmit();

                                        //Navigator.pop(context);
                                      },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  transitionBuilder: (ctx, x, y, child) => BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 4 * x.value, sigmaY: 4 * x.value),
                    child: FadeTransition(
                      opacity: x,
                      child: child,
                    ),
                  ),
                  context: context,
                );
              },
        child: const Icon(Icons.send),
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
              'TDS List',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.15,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total gross:  ',
                              style: Theme.of(context).textTheme.bodyText2,
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
                              '8,00,000',
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
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Deduction:  ',
                              style: Theme.of(context).textTheme.bodyText2,
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
                              widget.deduction,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: const Color.fromARGB(255, 71, 70, 70),
                          height: SizeVariables.getHeight(context) * 0.0015,
                          width: SizeVariables.getWidth(context) * 0.45,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Taxable Amount:  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            Text(
                              '₹ 5,00,000',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: SizeVariables.getWidth(context) * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'As per the old resume your',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                          Text(
                            'TDS - ₹ 80,000',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 70),
              itemCount: _data.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: SizeVariables.getHeight(context) * 0.12,
                  child: Row(
                    children: [
                      Container(
                        width: SizeVariables.getWidth(context) * 0.3,
                        decoration: BoxDecoration(
                          color: _data[index]['color'],
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹ ${_data[index]['amount']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                              ),
                              // Text(
                              //   'Out of',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodyText2!
                              //       .copyWith(
                              //         color: Colors.black,
                              //         fontSize: 12,
                              //       ),
                              // ),
                              // Text(
                              //   '₹ ${_data[index]['out']}',
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .bodyText2!
                              //       .copyWith(
                              //         color: Colors.black,
                              //         fontSize: 10,
                              //       ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ContainerNew(
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _data[index]['name'],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Text(
                                //   _data[index]['reason'],
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyText1!
                                //       .copyWith(
                                //         color: _data[index]['rColor'],
                                //         fontSize: 16,
                                //       ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
