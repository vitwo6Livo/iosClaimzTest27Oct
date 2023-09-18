import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FlightScreen extends StatefulWidget {
  // const FlightScreen({Key? key}) : super(key: key);
  final Map<dynamic, dynamic> args;
  FlightScreen(this.args);

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.args.toString());
    // final route = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // var file = route['file'];
    //
    // print('FILE NAME: $file');

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromARGB(206, 27, 26, 26),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: SizeVariables.getHeight(context) * 0.05,
                  left: SizeVariables.getWidth(context) * 0.04,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: Colors.white),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'From',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                // SizedBox(height: 20,),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Rupsi',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                // SizedBox(height: 20,),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '(RUP)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                FittedBox(
                                    fit: BoxFit.contain,
                                    child: SvgPicture.asset(
                                        "assets/clamizFrom/plane icon.svg")),
                              ],
                            ),
                            Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'To',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                // SizedBox(height: 20,),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Kolkata',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                // SizedBox(height: 20,),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '(CCU)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Depart',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Return',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                FittedBox(
                                    fit: BoxFit.contain,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 16,
                                      ),
                                      onPressed: () {},
                                      color: Colors.black,
                                    )),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '20/08/2022',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                FittedBox(
                                    fit: BoxFit.contain,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 16,
                                      ),
                                      onPressed: () {},
                                      color: Colors.black,
                                    )),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '26/08/2022',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.015,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      SizeVariables.getWidth(context) * 0.027),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Passenger Name :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Joy Shil',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      SizeVariables.getWidth(context) * 0.027),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'GST (Customer) :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '19AABCCZ0038M1Z2',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      SizeVariables.getWidth(context) * 0.027),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Service Provider :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  ' Inter Glob Aviation Limited',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      SizeVariables.getWidth(context) * 0.027),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'SAC Code :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '996425',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      SizeVariables.getWidth(context) * 0.027),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'GST (Service Provider) :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '19AABCI2726B1ZZ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeVariables.getWidth(context) * 0.3),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Air Travel Charges',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Total(inc tax)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Total: 500',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'IGST: 0',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'CGST: 125',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                '5250',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeVariables.getWidth(context) * 0.3),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Airport Charges',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      SizeVariables.getWidth(context) * 0.02),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Total(inc tax)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Total: 942',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'IGST: 0',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'CGST: 0',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                '942',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      SizeVariables.getWidth(context) * 0.043),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Grand Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      SizeVariables.getWidth(context) * 0.07),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '6192',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.03,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.03),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Claim Amount',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.04),
                              child: Container(
                                height:
                                    SizeVariables.getHeight(context) * 0.033,
                                width: SizeVariables.getWidth(context) * 0.23,
                                child: TextField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.05),
                              child: InkWell(
                                onTap: () {},
                                child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: SvgPicture.asset(
                                        "assets/clamizFrom/upload.svg")),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.04),
                        Container(
                          height: SizeVariables.getHeight(context) * 0.015,
                          width: SizeVariables.getHeight(context) * 0.02,
                          child: FittedBox(
                            // fit: BoxFit.contain,
                            child: Text(
                              'You’re claiming XYZ less/more than the invoice amount.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
