// ignore_for_file: file_names, camel_case_types, unnecessary_null_comparison, prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../provider/theme_provider.dart';
import '../../../viewModel/paySlipViewModel.dart';
import '../../config/mediaQuery.dart';
import '../../screens/paySlipShimmer.dart';
import 'package:http/http.dart' as http;

class PaySlip_NewWidget extends StatefulWidget {
  const PaySlip_NewWidget({super.key});

  @override
  State<PaySlip_NewWidget> createState() => _PaySlip_NewWidgetState();
}

class _PaySlip_NewWidgetState extends State<PaySlip_NewWidget> {
  DateTime _dateTime = DateTime(DateTime.now().year);
  DateFormat dateFormat = DateFormat('yyyy');
  var response;
  var responseDeduction;
  dynamic jsonResponse;
  double earningsTotal = 0.0;
  double deductions = 0.0;
  double salary = 0.0;
  var incentive;
  double taxes = 0.0;
  var esi;
  var resp;
  var respDe;
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

  @override
  void initState() {
    super.initState();

    Provider.of<PaySlipViewModel>(context, listen: false).getPaySlipEarning({
      'year': int.parse(DateFormat('yyyy').format(DateTime.now())),
      'month': DateFormat('MMMM').format(DateTime.now()).toString()
    }).then((value) {
      setState(() {
        isLoading = false;
        selectedMonth = DateFormat('MMMM').format(DateTime.now()).toString();
        print('Default $selectedMonth');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final paySlipAllDetails =
        Provider.of<PaySlipViewModel>(context).paySlipAllDetails;
    final earningsTotal = Provider.of<PaySlipViewModel>(context).earningsTotal;
    final ytdEarningsTotal =
        Provider.of<PaySlipViewModel>(context).ytdEarningTotal;
    final paySlipData = Provider.of<PaySlipViewModel>(context);
    final deductionTotal =
        Provider.of<PaySlipViewModel>(context).deductionTotal;
    final ytdDeductionTotal =
        Provider.of<PaySlipViewModel>(context).ytdDeduuctionTotal;
    final netPay = Provider.of<PaySlipViewModel>(context).netPay;
    dynamic response;
    return isLoading
        ? PaySlipShimmer()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Gross Earning:  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                              Text(
                                '₹',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.amber,
                                    ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                earningsTotal.toStringAsFixed(2).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Deductions: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                              Text(
                                '₹',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.amber,
                                    ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                deductionTotal.toStringAsFixed(2).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Paid Days: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Color(0xfffF59F23),
                                        ),
                                  ),
                                  Text(
                                    paySlipAllDetails['paid_days'].toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '|',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(width: 5),
                              Row(
                                children: [
                                  Text(
                                    'Lop Days: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Color(0xfffF59F23),
                                        ),
                                  ),
                                  Text(
                                    paySlipAllDetails['lop'].toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 25,
                            width: SizeVariables.getWidth(context) * 0.25,
                            decoration: BoxDecoration(
                              color: (themeProvider.darkTheme)
                                  ? Colors.grey.shade800
                                  : Colors.amberAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: DropdownButton<String>(
                                  elevation: 25,
                                  underline: Container(),
                                  icon: Container(),
                                  dropdownColor:
                                      Theme.of(context).colorScheme.secondary,
                                  onChanged: (value) async {
                                    setState(() {
                                      selectedMonth = value;
                                    });
                                    Map<String, dynamic> _payslipInput = {
                                      'year': dateFormat.format(_dateTime),
                                      'month': selectedMonth
                                    };
                                    response = await paySlipData
                                        .getPaySlipEarning(_payslipInput);

                                    print('response: $response');

                                    print('VALUEEEEEEEEE $selectedMonth');
                                    setState(() {
                                      resp = response;
                                    });
                                  },
                                  value: selectedMonth,
                                  items: months
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Net Pay',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 28,
                                    ),
                          ),
                          Row(
                            children: [
                              Text(
                                '₹',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Colors.amber,
                                    ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                netPay.toStringAsFixed(2).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.grey,
                                title: const Text('Select Year'),
                                content: Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.2,
                                  width: SizeVariables.getWidth(context) * 0.2,
                                  child: YearPicker(
                                      firstDate:
                                          DateTime(DateTime.now().year - 10),
                                      lastDate: DateTime(DateTime.now().year),
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
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  SizeVariables.getWidth(context) * 0.05),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: Container(
                                  width: SizeVariables.getWidth(context) * 0.25,
                                  height:
                                      SizeVariables.getHeight(context) * 0.035,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: (themeProvider.darkTheme)
                                          ? Colors.grey.shade800
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Table(
                    border: TableBorder.all(
                      color: (themeProvider.darkTheme)
                          ? const Color.fromARGB(137, 138, 137, 137)
                          : const Color.fromARGB(97, 220, 218, 218),
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                'Detail Breakdown',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Amount',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'YTD',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 180,
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.grey,
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.9,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: paySlipAllDetails['earning'].isEmpty
                          ? Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(child: Lottie.asset('assets/json/payslipEmpty.json')),
                                Container(
                                  width: 200,
                                  height: 140,
                                  child: Lottie.asset(
                                      'assets/json/payslipEmpty.json'),
                                ),
                                Text(
                                  'No Payslip Found For The Selected Period',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            )
                          : ListView.builder(
                              itemCount: paySlipAllDetails['earning'].length,
                              itemBuilder: (context, index) => Table(
                                border: TableBorder.all(
                                  color: (themeProvider.darkTheme)
                                      ? const Color.fromARGB(255, 50, 50, 50)
                                      : const Color.fromARGB(
                                          179, 230, 229, 229),
                                  width: 0,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Text(
                                            paySlipAllDetails['earning'][index]
                                                    ['salary_component'] ??
                                                'NA',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            paySlipAllDetails['earning'][index]
                                                    ['component_amount'] ??
                                                'NA',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            paySlipAllDetails['earning'][index]
                                                    ['ytd'] ??
                                                'NA',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Table(
                    border: TableBorder.all(
                      color: (themeProvider.darkTheme)
                          ? const Color.fromARGB(255, 108, 82, 2)
                          : const Color.fromARGB(255, 239, 230, 200),
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Text(
                                'Gross Earnings',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '₹ ${earningsTotal.toStringAsFixed(2).toString()}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '₹ ${ytdEarningsTotal.toStringAsFixed(2).toString()}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Table(
                    border: TableBorder.all(
                      color: (themeProvider.darkTheme)
                          ? const Color.fromARGB(137, 138, 137, 137)
                          : const Color.fromARGB(97, 220, 218, 218),
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                'Deductions',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Amount',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'YTD',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 95,
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.grey,
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.9,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: paySlipAllDetails['deduction'].isEmpty
                          ? Center(
                              child: Text(
                                'No deduction',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )
                          : ListView.builder(
                              itemCount: paySlipAllDetails['deduction'].length,
                              itemBuilder: (context, index) => Table(
                                border: TableBorder.all(
                                  color: (themeProvider.darkTheme)
                                      ? const Color.fromARGB(255, 50, 50, 50)
                                      : const Color.fromARGB(
                                          179, 230, 229, 229),
                                  width: 0,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 5),
                                          child: Text(
                                            paySlipAllDetails['deduction']
                                                [index]['salary_component'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            paySlipAllDetails['deduction']
                                                        [index]
                                                    ['component_amount'] ??
                                                'NA'.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            paySlipAllDetails['deduction']
                                                    [index]['ytd'] ??
                                                'NA',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(
                      color: (themeProvider.darkTheme)
                          ? const Color.fromARGB(255, 108, 82, 2)
                          : const Color.fromARGB(255, 239, 230, 200),
                      width: 1,
                    ),
                    children: [
                      TableRow(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Text(
                                'Total Deductions',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '₹ ${deductionTotal.toStringAsFixed(2).toString()}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '₹ ${ytdDeductionTotal.toStringAsFixed(2).toString()}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: (themeProvider.darkTheme)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        if (paySlipAllDetails['earning'].isEmpty) {
                          print('No Payslips Found');
                        } else {
                          openFile(
                              url:
                                  'https://console.claimz.in/api/api/download-pdf/${paySlipAllDetails['earning'][0]['payslip_unique_id']}',
                              fileName: '${selectedMonth}_$_dateTime.pdf');
                        }
                      }
                      // () => paySlipAllDetails['earning'].isEmpty
                      //     ? () {}
                      //     : () => openFile(
                      //         url:
                      //             'https://console.claimz.in/api/api/download-pdf/${paySlipAllDetails['earning'][0]['payslip_unique_id']}',
                      //         fileName: '${selectedMonth}_$_dateTime.pdf')
                      ,
                      icon: Icon(
                        Icons.download,
                        color: (themeProvider.darkTheme)
                            ? Colors.white
                            : Colors.black,
                      ),
                      label: Text(
                        'Download'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  // Future openFile({required String url, required String? fileName}) async {
  //   //This is the url that is being sent
  //   //https://console.claimz.in/api/api/download-pdf/93265014fded0aa1

  //   //This is the name of the file
  //   //April_2023-01-01 00:00:00.000

  //   print('object');
  //   print('url-----$url');
  //   print('fileName-----$fileName');
  //   final file = await _downloadFile(url, fileName!);
  //   print('file: $file');
  //   while (file == null || !(await file.exists())) {
  //     // print('File not found');
  //     // return;
  //     await Future.delayed(
  //         const Duration(seconds: 1)); // Wait for 1 second before rechecking
  //     print('Waiting for file to be available...');
  //   }

  //   print('Path: ${file.path}');

  //   final openFileResponse = await OpenFile.open(file.path);

  //   print('File Opened: $openFileResponse');
  // }

  // Future<File?> _downloadFile(String url, String fileName) async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   final appStorage = await getExternalStorageDirectory();
  //   // final appStorage = await DownloadsPathProvider.downloadsDirectory;
  //   final file = File('${appStorage!.path}/$fileName');

  //   final downloadDirectory = Directory('${appStorage.path}/Download');
  //   if (!downloadDirectory.existsSync()) {
  //     downloadDirectory.createSync(recursive: true);
  //   }

  //   final PermissionStatus permissionStatus =
  //       await Permission.storage.request();
  //   if (permissionStatus != PermissionStatus.granted) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       behavior: SnackBarBehavior.floating,
  //       content: Text(
  //           'You need to grant access to your external storage for the download to complete'),
  //       backgroundColor: Colors.red,
  //     )); // Permission denied, handle accordingly
  //   }

  //   final filePath = '${downloadDirectory.path}/$fileName';

  //   try {
  //     // final response = await Dio().download(url, file.path);

  //     final response = await http.get(Uri.parse(url), headers: {
  //       'Authorization': 'Bearer ${localStorage.getString('token')}',
  //       'Content-Type': 'application/json'
  //     });

  //     print('JSON RESPONSE: ${json.decode(response.body)}');

  //     if (response.statusCode == 200) {
  //       await file.writeAsBytes(response.bodyBytes);
  //       print('Downloaded Path: $filePath');

  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         behavior: SnackBarBehavior.floating,
  //         content: Text('File Downloaded at: ${file.path}'),
  //         backgroundColor: Colors.red,
  //       ));
  //       // return File(filePath);
  //       return file;
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         behavior: SnackBarBehavior.floating,
  //         content: Text('Something went wrong'),
  //         backgroundColor: Colors.red,
  //       ));
  //       print('JSON ERROR RESPONSE: ${json.decode(response.body)}');

  //       print('Download failed. Status code: ${response.statusCode}');
  //       return null;
  //     }
  //   }
  //   catch (e) {
  //     print('JSON RESPONSE DOWNLOAD ERROR: $e');

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       behavior: SnackBarBehavior.floating,
  //       content: Text(e.toString()),
  //       backgroundColor: Colors.red,
  //     ));
  //     print('Error during download: $e');
  //     return null;
  //   }
  // }

  Future openFile({required String url, required String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;

    print('Path: ${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String fileName) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // final appStorage = await getApplicationDocumentsDirectory();
    final appStorage = await getTemporaryDirectory();
    final file = File('${appStorage.path}/$fileName');

    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              headers: {
                // 'Content-Type': 'application/json',
                'Authorization': 'Bearer ${localStorage.getString('token')}'
              },
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      print('Download Successfull');
      return file;
    } catch (e) {
      return null;
      // return null;
    }
  }
}

// print('Download Entered........');

// final appStorage = await getApplicationDocumentsDirectory();
// final file = File('${appStorage.path}/$fileName');

// try {
//   final response = await Dio().get(url,
//       options: Options(
//           responseType: ResponseType.bytes,
//           headers: {
//             'Authorization': 'Bearer ${localStorage.getString('token')}',
//             'Content-Type': 'application/json',
//           },
//           followRedirects: false,
//           receiveTimeout: 0));

//   print('Download Complete: ${response.data}');

//   final raf = file.openSync(mode: FileMode.write);
//   raf.writeFromSync(response.data);
//   await raf.close();

//   return file;
// } catch (e) {
//   print('Download Failed');

//   return null;
//   // return null;
// }
