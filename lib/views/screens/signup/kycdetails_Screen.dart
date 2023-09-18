import 'package:claimz/views/screens/signup/widget/loading_pie.dart';
import 'package:flutter/material.dart';
import '../../config/mediaQuery.dart';
import 'kycWidget/bankDetails.dart';
import 'kycWidget/documentsWidget.dart';
import 'kycWidget/kycWidget.dart';
import 'kycWidget/lastCompany.dart';
import 'kycWidget/personalDetails.dart';

class Kycdetails_Screen extends StatefulWidget {
  final String name;

  Kycdetails_Screen(this.name);

  @override
  State<Kycdetails_Screen> createState() => _Kycdetails_ScreenState();
}

class _Kycdetails_ScreenState extends State<Kycdetails_Screen> {
  int _selection = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.08,
          right: SizeVariables.getWidth(context) * 0.08,
          top: SizeVariables.getHeight(context) * 0.008,
        ),
        child: ListView(
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Wel',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 37,
                            ),
                      ),
                      Text(
                        'come !',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 37,
                              color: Color(0xfffFEC107),
                            ),
                      ),
                    ],
                  ),
                  // PieChartScreen(),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  widget.name.split(' ')[0],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 22,
                      ),
                ),
                Text(
                  widget.name.split(' ').last,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 22,
                        color: Color(0xfffFEC107),
                      ),
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.03,
            ),
            Container(
              height: SizeVariables.getHeight(context) * 0.05,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // Container(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       right: 4,
                  //       top: 4,
                  //       bottom: 4,
                  //     ),
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20),
                  //           side: const BorderSide(
                  //             width: 2,
                  //             color: Color.fromARGB(255, 121, 120, 120),
                  //           ),
                  //         ),
                  //         primary: _selection == 0
                  //             ? Color(0xfffFEC107)
                  //             : Color(0xfffD9D9D9).withAlpha(60),
                  //       ),
                  //       child: Container(
                  //         width: SizeVariables.getWidth(context) * 0.2,
                  //         child: Center(
                  //           child: FittedBox(
                  //             fit: BoxFit.contain,
                  //             child: Text(
                  //               'Personal',
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyText1!
                  //                   .copyWith(
                  //                     fontSize: 16,
                  //                   ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           _selection = 0;
                  //         });
                  //         print('SELECTION: $_selection');
                  //       },
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 121, 120, 120),
                            ),
                          ),
                          primary: _selection == 1
                              ? Color(0xfffFEC107)
                              : Color(0xfffD9D9D9).withAlpha(60),
                        ),
                        child: Container(
                          width: SizeVariables.getWidth(context) * 0.2,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'KYC',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 1;
                          });
                          print('SELECTION: $_selection');
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 121, 120, 120),
                            ),
                          ),
                          primary: _selection == 2
                              ? Color(0xfffFEC107)
                              : Color(0xfffD9D9D9).withAlpha(60),
                        ),
                        child: Container(
                          width: SizeVariables.getWidth(context) * 0.2,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Bank',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 2;
                          });
                          print('SELECTION: $_selection');
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 121, 120, 120),
                            ),
                          ),
                          primary: _selection == 3
                              ? Color(0xfffFEC107)
                              : Color(0xfffD9D9D9).withAlpha(60),
                        ),
                        child: Container(
                          width: SizeVariables.getWidth(context) * 0.2,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Documents',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 3;
                          });
                          print('SELECTION: $_selection');
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 121, 120, 120),
                            ),
                          ),
                          primary: _selection == 4
                              ? Color(0xfffFEC107)
                              : Color(0xfffD9D9D9).withAlpha(60),
                        ),
                        child: Container(
                          width: SizeVariables.getWidth(context) * 0.2,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Last Company',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selection = 4;
                          });
                          print('SELECTION: $_selection');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.01,
            ),
            Container(
              child: Column(
                children: [
                  _selection == 0
                      ? PersonalDetails()
                      : _selection == 1
                          ? kycWidget(widget.name)
                          : _selection == 2
                              ? BankDetails()
                              : _selection == 3
                                  ? DocumentsWidget()
                                  : _selection == 4
                                      ? LastCompany(_selection)
                                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
