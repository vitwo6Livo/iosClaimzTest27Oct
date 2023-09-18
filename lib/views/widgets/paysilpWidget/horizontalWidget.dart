import 'dart:io';
import 'dart:ui';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:claimz/views/screens/paySlipShimmer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../viewModel/paySlipViewModel.dart';
import '../../../res/appUrl.dart';
import '../../screens/paySlipShimmer.dart';
import 'package:provider/provider.dart';

class HorizontalWidget extends StatefulWidget {
  // const HorizontalWidget({Key? key}) : super(key: key);

  @override
  State<HorizontalWidget> createState() => _HorizontalWidgetState();
}

class _HorizontalWidgetState extends State<HorizontalWidget> {
  DateTime _dateTime = DateTime(DateTime.now().year);
  DateFormat dateFormat = DateFormat('yyyy');
  var response;
  dynamic jsonResponse;
  double earnings = 0.0;
  double deductions = 0.0;
  double salary = 0.0;
  var incentive;
  double taxes = 0.0;
  var esi;
  var resp;
  bool isLoading = true;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String? selectedMonth;

  var myYears = "2022";
  List<String> year = ["2022", "2021", "2020", "2019", "2018"];

  Future<void> getData() async {
    final data = Provider.of<PaySlipViewModel>(context, listen: false);
    Map<String, dynamic> _payslipInput = {
      'year': int.parse(DateFormat('yyyy').format(DateTime.now())),
      'month': DateFormat('MMMM').format(DateTime.now()).toString()
    };
    resp = await data.getPaySlipDetails(_payslipInput);
    print('resp: $resp');
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData().then((value) {
        setState(() {
          isLoading = false;
          selectedMonth = DateFormat('MMMM').format(DateTime.now()).toString();
          print('Default $selectedMonth');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final provider = Provider.of<PaySlipViewModel>(context).paySlipDetails;
    final monthlyCtc = Provider.of<PaySlipViewModel>(context).monthlyCtc;
    final basic = Provider.of<PaySlipViewModel>(context).basic;
    final hra = Provider.of<PaySlipViewModel>(context).hra;
    final epf = Provider.of<PaySlipViewModel>(context).epf;
    final salary = Provider.of<PaySlipViewModel>(context).salary;
    final earnings = Provider.of<PaySlipViewModel>(context).earnings;
    final deduction = Provider.of<PaySlipViewModel>(context).deductions;
    final paySlipData = Provider.of<PaySlipViewModel>(context);
    var myMonth = DateFormat('MMMM').format(DateTime.now());
    dynamic response;

    return isLoading
        ? PaySlipShimmer()
        // CircularProgressIndicator()
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.025,
                  right: SizeVariables.getWidth(context) * 0.025,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      SizeVariables.getWidth(context) * 0.05),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 181, 179, 179)
                              .withOpacity(0.1),
                          border: const Border(
                              bottom: BorderSide(width: 0.06),
                              top: BorderSide(width: 0.06),
                              right: BorderSide(width: 0.06),
                              left: BorderSide(width: 0.06))),
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.045,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 3,
                                        ),
                                      ),
                                      child: DropdownButton<String>(
                                          underline: Container(),
                                          iconSize: 30,
                                          icon: Icon(
                                            Icons.expand_more,
                                            color:
                                                Theme.of(context).canvasColor,
                                          ),
                                          dropdownColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          onChanged: (value) async {
                                            setState(() {
                                              selectedMonth = value;
                                            });
                                            Map<String, dynamic> _payslipInput =
                                                {
                                              'year':
                                                  dateFormat.format(_dateTime),
                                              'month': selectedMonth
                                            };
                                            response = await paySlipData
                                                .getPaySlipDetails(
                                                    _payslipInput);
                                            print('response: $response');
                                            print(
                                                'response.data : ${response['data']}');

                                            //print('paySlipInput: $_payslipInput');

                                            print(
                                                'VALUEEEEEEEEE $selectedMonth');
                                            setState(() {
                                              resp = response;
                                            });
                                          },
                                          value: selectedMonth,
                                          items: months
                                              .map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .canvasColor),
                                                    ),
                                                  ))
                                              .toList()),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Select Year'),
                                            content: Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.2,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.2,
                                              child: YearPicker(
                                                  firstDate: DateTime(
                                                      DateTime.now().year - 10),
                                                  lastDate: DateTime(
                                                      DateTime.now().year),
                                                  initialDate: DateTime.now(),
                                                  selectedDate: _dateTime,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _dateTime = value;
                                                    });
                                                    print(
                                                        'Year Selected: ${dateFormat.format(_dateTime)}');
                                                    Navigator.of(context).pop();
                                                  }),
                                            ),
                                          )),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        SizeVariables.getWidth(context) * 0.05),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 20, sigmaY: 20),
                                      child: Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.25,
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.045,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                            color: (themeProvider.darkTheme)
                                                ? const Color.fromARGB(
                                                        255, 181, 179, 179)
                                                    .withOpacity(0.1)
                                                : Colors.amberAccent,
                                            // Colors.red,
                                            border: const Border(
                                                bottom: BorderSide(width: 0.06),
                                                top: BorderSide(width: 0.06),
                                                right: BorderSide(width: 0.06),
                                                left: BorderSide(width: 0.06))),
                                        child: Center(
                                          child: Text(
                                            _dateTime == null
                                                ? 'Select Years'
                                                : '${dateFormat.format(_dateTime)}',
                                            // style: Theme.of(context).textTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //DateRangePicker(),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.02),
                          Container(
                            width: double.infinity,
                            height: SizeVariables.getHeight(context) * 0.1,
                            // color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Net Pay',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).canvasColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    // color: Colors.blue,
                                    child: Row(
                                      children: [
                                        Text('₹',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                    color:
                                                        const Color(0xffF59F23),
                                                    fontSize: 50)),
                                        SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.02),
                                        (resp['data'].isEmpty)
                                            ? Text(
                                                '0',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .canvasColor,
                                                        fontSize: 50),
                                              )
                                            : Text(
                                                salary
                                                    .toStringAsFixed(2)
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .canvasColor,
                                                        fontSize: 50),
                                              )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // child: ,
                          ),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.001),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         resp['data'].isEmpty
                          //             ? '(----)'
                          //             : '(${NumberToWordsEnglish.convert(salary)})',
                          //         style: Theme.of(context).textTheme.bodyText1),
                          //   ],
                          // ),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.01),
                          Container(
                            width: double.infinity,
                            height: SizeVariables.getHeight(context) * 0.05,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.4,
                                  height:
                                      SizeVariables.getHeight(context) * 0.05,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Gross Pay',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Colors.grey,
                                              )),
                                      (resp['data'].isEmpty)
                                          ? Container(
                                              height: 15,
                                              width: 100,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text('0',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color:
                                                                Colors.grey)),
                                              ),
                                            )
                                          : Container(
                                              height: 15,
                                              width: 100,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                    '₹${(deduction + earnings).toStringAsFixed(2).toString()}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color:
                                                                Colors.grey)),
                                              ),
                                            )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.02),
                          InkWell(
                            onTap: resp['data'].isEmpty
                                ? () {}
                                : () => openFile(
                                    url:
                                        'https://console.claimz.in/api/api/download-pdf/${provider['data'][0]['payslip_unique_id'].toString()}',
                                    fileName:
                                        '${selectedMonth}_$_dateTime.pdf'),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  SizeVariables.getWidth(context) * 0.05),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      SizeVariables.getHeight(context) * 0.06,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: resp['data'].isEmpty
                                          ? (themeProvider.darkTheme)
                                              ? Colors.grey
                                              : Colors.amberAccent
                                          : const Color.fromARGB(
                                              255, 174, 143, 98),
                                      border: const Border(
                                          bottom: BorderSide(width: 0.06),
                                          top: BorderSide(width: 0.06),
                                          right: BorderSide(width: 0.06),
                                          left: BorderSide(width: 0.06))),
                                  child: const Center(
                                    child: Text('Download'
                                        // style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeVariables.getHeight(context) * 0.02),
              Container(
                margin: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.025,
                    right: SizeVariables.getWidth(context) * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Detailed Breakdown'),
                    Container(
                      // width: SizeVariables.getWidth(context) * 0.22,
                      // color: Colors.red,
                      margin: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.12),
                      child: Row(
                        children: [
                          const Text('Amount'),
                          SizedBox(
                              width: SizeVariables.getWidth(context) * 0.02),
                          const Text('YTD')
                        ],
                      ),
                    )
                    // Icon(Icons.expand_more, color: Colors.white)
                  ],
                ),
              ),
              SizedBox(height: SizeVariables.getHeight(context) * 0.02),
              Container(
                  // color: Colors.amber,
                  height: SizeVariables.getHeight(context) * 0.4,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.025,
                    right: SizeVariables.getWidth(context) * 0.025,
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: SizeVariables.getHeight(context) * 0.01,
                      horizontal: SizeVariables.getWidth(context) * 0.04),
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          SizeVariables.getWidth(context) * 0.02),
                      color: const Color.fromARGB(255, 181, 179, 179)
                          .withOpacity(0.1),
                      border: Border.all(color: Colors.white, width: 1)),
                  // child: ListView(
                  //   children: [card(), card(), card(), card(), card(), card()],
                  // ),
                  child: (resp['data'].isEmpty)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(child: Lottie.asset('assets/json/payslipEmpty.json')),
                              Container(
                                width: 150,
                                height: 150,
                                margin: EdgeInsets.only(
                                    bottom: SizeVariables.getHeight(context) *
                                        0.05),
                                // color: Colors.green,
                                child: Lottie.asset(
                                    'assets/json/payslipEmpty.json'),
                              ),
                              SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.02),
                              const Text(
                                  'No Payslip Found For The Selected Period')
                            ],
                          ),
                        )
                      : ListView.separated(
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(
                                    bottom: SizeVariables.getHeight(context) *
                                        0.02),
                                // color: Colors.amber,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        // provider['data'][index]
                                        //         ['component_amount'] == '' ? '0.0' : double.parse(provider['data'][index]
                                        //         ['component_amount'])
                                        //     .toStringAsFixed(2)
                                        //     .toString(),
                                        provider['data'][index]
                                                ['salary_component'] ??
                                            'NA',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: provider['data'][index]
                                                            ['type'] ==
                                                        'deduction'
                                                    ? const Color.fromARGB(
                                                        255, 228, 106, 97)
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(
                                            provider['data'][index]['type'] ==
                                                    'deduction'
                                                ? '-(₹${double.parse(provider['data'][index]['component_amount'] == '' ? '0.0' : provider['data'][index]['component_amount']).toStringAsFixed(2).toString()})'
                                                : '₹${double.parse(provider['data'][index]['component_amount'] == '' ? '0.0' : provider['data'][index]['component_amount']).toStringAsFixed(2).toString()}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: provider['data']
                                                                    [index]
                                                                ['type'] ==
                                                            'deduction'
                                                        ? const Color.fromARGB(
                                                            255, 228, 106, 97)
                                                        : Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        const Text('|',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.15,
                                          // color: Colors.red,
                                          child: Text(
                                              double.parse(provider['data']
                                                      [index]['ytd'])
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: provider['data']
                                                                      [index]
                                                                  ['type'] ==
                                                              'deduction'
                                                          ? const Color.fromARGB(
                                                              255, 228, 106, 97)
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) => Container(
                                width: double.infinity,
                                height:
                                    SizeVariables.getHeight(context) * 0.001,
                                margin: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.05,
                                    right:
                                        SizeVariables.getWidth(context) * 0.05,
                                    bottom: SizeVariables.getHeight(context) *
                                        0.02),
                                color: Colors.white,
                                // child: Container(
                                //   color: Colors.white,
                                // ),
                              ),
                          itemCount: provider['data'].length)),
            ],
          );
  }

  Future openFile({required String url, required String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;

    print('Path: ${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String fileName) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$fileName');

    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${localStorage.getString('token')}'
              },
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
      // return null;
    }
  }
}
