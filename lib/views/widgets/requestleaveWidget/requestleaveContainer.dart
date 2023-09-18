import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/theme_provider.dart';
import '../../../viewModel/leaveListViewModel.dart';
import '../../../viewModel/leaveRemainingViewModel.dart';
import '../../../viewModel/leaveTypeViewModel.dart';
import '../../../viewModel/leaveViewModel.dart';
import '../../../res/components/buttonStyle.dart';
import 'package:provider/provider.dart';

class RequestleaveContainer extends StatefulWidget {
  int fromRegularisation;
  var date;
  String subject;
  String description;
  int leaveId;
  // const RequestleaveContainer({Key? key}) : super(key: key);

  @override
  State<RequestleaveContainer> createState() => _RequestleaveContainerState();

  RequestleaveContainer(this.fromRegularisation, this.date, this.subject,
      this.description, this.leaveId);
}

class _RequestleaveContainerState extends State<RequestleaveContainer> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String subject = '';
  String add = '';
  DateTime? _dateTimeStart;
  DateTime? _dateTimeEnd;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  var _selectedItem;
  bool isSelected = false;
  final TextEditingController _textController = TextEditingController();

  List<String> leaveDuration = ['Half Day', 'Full Day'];
  var selectedItem;
  var selectedItem2;
  var selectedItem3;

  bool isSame = false;
  bool _isCheck = false;
  bool _isCheck1 = false;
  bool _isCheck2 = false;
  bool _isCheck3 = false;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<LeaveRemainingViewModel>(context, listen: false)
        .getLeaveReasons()
        .then((_) {
      setState(() {
        isLoading = false;
      });

      if (widget.fromRegularisation == 2) {
        setState(() {
          _dateTimeStart =
              DateTime.parse(dateFormat.format(DateTime.parse(widget.date)));
          _dateTimeEnd =
              DateTime.parse(dateFormat.format(DateTime.parse(widget.date)));
        });
      } else if (widget.fromRegularisation == 1) {
        _dateTimeStart =
            DateTime.parse(dateFormat.format(DateTime.parse(widget.date[0])));
        _dateTimeEnd =
            DateTime.parse(dateFormat.format(DateTime.parse(widget.date.last)));
        selectedItem3 = widget.subject == '' ? selectedItem3 : widget.subject;
        add = widget.description;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveRemainingViewModel>(context).leaveTypes;
    final reason = Provider.of<LeaveRemainingViewModel>(context).leaveReasons;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                // color: Colors.red,
                child: ContainerStyle(
                  height: height > 750
                      ? 56.h
                      : height < 650
                          ? 69.h
                          : 66.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: SizeVariables.getHeight(context) * 0.05,
                      //   child: ListView(
                      //     scrollDirection: Axis.horizontal,
                      //     children: [
                      //       Checkbox(
                      //         fillColor: (themeProvider.darkTheme)
                      //             ? MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.white;
                      //               })
                      //             : MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.black;
                      //               }),
                      //         activeColor: Colors.white,
                      //         value: _isCheck,
                      //         checkColor: Colors.amber,
                      //         onChanged: (check) {
                      //           setState(() {
                      //             _isCheck = check!;
                      //           });
                      //           print('IS CHECK: $_isCheck');
                      //         },
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 'Casual Leave: ',
                      //                 style: Theme.of(context).textTheme.bodyText1,
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 '3',
                      //                 style: Theme.of(context).textTheme.bodyText2,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: SizeVariables.getWidth(context)*0.05,
                      //       ),
                      //       Checkbox(
                      //         fillColor: (themeProvider.darkTheme)
                      //             ? MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.white;
                      //               })
                      //             : MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.black;
                      //               }),
                      //         activeColor: Colors.white,
                      //         value: _isCheck1,
                      //         checkColor: Colors.amber,
                      //         onChanged: (check) {
                      //           setState(() {
                      //             _isCheck1 = check!;
                      //           });
                      //           print('IS CHECK: $_isCheck1');
                      //         },
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 'Sick Leave: ',
                      //                 style: Theme.of(context).textTheme.bodyText1,
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 '3',
                      //                 style: Theme.of(context).textTheme.bodyText2,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: SizeVariables.getWidth(context)*0.05,
                      //       ),
                      //       Checkbox(
                      //         fillColor: (themeProvider.darkTheme)
                      //             ? MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.white;
                      //               })
                      //             : MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.black;
                      //               }),
                      //         activeColor: Colors.white,
                      //         value: _isCheck2,
                      //         checkColor: Colors.amber,
                      //         onChanged: (check) {
                      //           setState(() {
                      //             _isCheck2 = check!;
                      //           });
                      //           print('IS CHECK: $_isCheck2');
                      //         },
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 'Priviledge Leave: ',
                      //                 style: Theme.of(context).textTheme.bodyText1,
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 '6',
                      //                 style: Theme.of(context).textTheme.bodyText2,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: SizeVariables.getWidth(context)*0.05,
                      //       ),
                      //       Checkbox(
                      //         fillColor: (themeProvider.darkTheme)
                      //             ? MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.white;
                      //               })
                      //             : MaterialStateProperty.resolveWith<Color>(
                      //                 (states) {
                      //                 if (states.contains(MaterialState.disabled)) {
                      //                   return Colors.black;
                      //                 }
                      //                 return Colors.black;
                      //               }),
                      //         activeColor: Colors.white,
                      //         value: _isCheck3,
                      //         checkColor: Colors.amber,
                      //         onChanged: (check) {
                      //           setState(() {
                      //             _isCheck3 = check!;
                      //           });
                      //           print('IS CHECK: $_isCheck3');
                      //         },
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 'Compoff Balance: ',
                      //                 style: Theme.of(context).textTheme.bodyText1,
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      //                 '0',
                      //                 style: Theme.of(context).textTheme.bodyText2,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Container(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                dropdownColor:
                                    Theme.of(context).colorScheme.secondary,
                                value: _selectedItem,
                                hint: Text(
                                  'Select Type',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                items: provider
                                    .map((item) => DropdownMenuItem(
                                          value: item['id'],
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item['leave_types'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!,
                                              ),
                                              Text(
                                                item['number'].toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!,
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (item) {
                                  setState(() {
                                    _selectedItem = item;
                                  });
                                  print('Selected Station: $item');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04,
                          // top: SizeVariables.getHeight(context) * 0.02,
                          right: SizeVariables.getWidth(context) * 0.04,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'From',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     left: SizeVariables.getWidth(context) * 0.35,
                            //   ),
                            //   child: FittedBox(
                            //     fit: BoxFit.contain,
                            //     child: Text(
                            //       'Duration',
                            //       style: Theme.of(context).textTheme.bodyText2,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeVariables.getHeight(context) * 0.01),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.03),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: widget.fromRegularisation == 2
                                      ? () {}
                                      : () => showDatePicker(
                                                  builder: (context, child) =>
                                                      Theme(
                                                        data: ThemeData()
                                                            .copyWith(
                                                          colorScheme:
                                                              const ColorScheme
                                                                  .dark(
                                                            primary: Color(
                                                                0xffF59F23),
                                                            surface:
                                                                Colors.black,
                                                            onSurface:
                                                                Colors.white,
                                                          ),
                                                          dialogBackgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  91,
                                                                  91,
                                                                  91),
                                                        ),
                                                        child: child!,
                                                      ),
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 365)))
                                              .then((value) {
                                            setState(() {
                                              _dateTimeStart = value;
                                            });
                                            print(
                                                'DATE START: $_dateTimeStart');
                                          }),
                                  child: Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.045,
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.02,
                                        right: SizeVariables.getWidth(context) *
                                            0.01),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            widget.fromRegularisation == 2
                                                ? Text(
                                                    dateFormat.format(
                                                        DateTime.parse(
                                                            widget.date)),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1)
                                                : Text(
                                                    _dateTimeStart == null
                                                        ? 'Select Date'
                                                        : '${dateFormat.format(DateTime.parse(_dateTimeStart.toString()))}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.015),
                                        InkWell(
                                            onTap: widget.fromRegularisation ==
                                                    2
                                                ? () {}
                                                : () => showDatePicker(
                                                            builder:
                                                                (context,
                                                                        child) =>
                                                                    Theme(
                                                                      data: ThemeData()
                                                                          .copyWith(
                                                                        colorScheme:
                                                                            const ColorScheme.dark(
                                                                          primary:
                                                                              Color(0xffF59F23),
                                                                          surface:
                                                                              Colors.black,
                                                                          onSurface:
                                                                              Colors.white,
                                                                        ),
                                                                        dialogBackgroundColor: Color.fromARGB(
                                                                            255,
                                                                            91,
                                                                            91,
                                                                            91),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    ),
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate: DateTime
                                                                    .now()
                                                                .add(const Duration(
                                                                    days: 365)))
                                                        .then((value) {
                                                      setState(() {
                                                        _dateTimeStart = value;
                                                      });
                                                      print(
                                                          'DATE START: $_dateTimeStart');
                                                    }),
                                            child: Icon(Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .canvasColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.08,
                                ),

                                _selectedItem == 4
                                    ? Container()
                                    : Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            dropdownColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            value: selectedItem,
                                            hint: Text(
                                              'Select Duration',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            items: leaveDuration
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!,
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (item) {
                                              setState(() {
                                                selectedItem = item;
                                              });
                                              print(
                                                  'Selected Station: $selectedItem');
                                            },
                                          ),
                                        ),
                                      ),
                                // InkWell(
                                //   onTap: widget.fromRegularisation == true
                                //       ? () {}
                                //       : () => showDatePicker(
                                //                   builder: (context, child) => Theme(
                                //                         data: ThemeData().copyWith(
                                //                           colorScheme:
                                //                               const ColorScheme.dark(
                                //                             primary:
                                //                                 Color(0xffF59F23),
                                //                             surface: Colors.black,
                                //                             onSurface: Colors.white,
                                //                           ),
                                //                           dialogBackgroundColor:
                                //                               Color.fromARGB(
                                //                                   255, 91, 91, 91),
                                //                         ),
                                //                         child: child!,
                                //                       ),
                                //                   context: context,
                                //                   initialDate: DateTime.now(),
                                //                   firstDate: DateTime.now(),
                                //                   lastDate: DateTime.now()
                                //                       .add(const Duration(days: 365)))
                                //               .then((value) {
                                //             setState(() {
                                //               _dateTimeEnd = value;
                                //             });
                                //             print('DATE TIME: $_dateTimeEnd');
                                //           }),
                                //   child: Container(
                                //     height: SizeVariables.getHeight(context) * 0.045,
                                //     padding: EdgeInsets.only(
                                //         left: SizeVariables.getWidth(context) * 0.02,
                                //         right:
                                //             SizeVariables.getWidth(context) * 0.01),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       border: Border.all(
                                //         color: Colors.grey,
                                //         width: 3,
                                //       ),
                                //     ),
                                //     child: Row(
                                //       children: [
                                //         Column(
                                //           mainAxisAlignment: MainAxisAlignment.center,
                                //           children: [
                                //             widget.fromRegularisation == true
                                //                 ? Text(
                                //                     dateFormat.format(
                                //                         DateTime.parse(widget.date)),
                                //                     style: Theme.of(context)
                                //                         .textTheme
                                //                         .bodyText1)
                                //                 : Text(
                                //                     _dateTimeEnd == null
                                //                         ? 'Select Date'
                                //                         : dateFormat.format(
                                //                             DateTime.parse(
                                //                                 _dateTimeEnd
                                //                                     .toString())),
                                //                     style: Theme.of(context)
                                //                         .textTheme
                                //                         .bodyText1,
                                //                   )
                                //           ],
                                //         ),
                                //         SizedBox(
                                //             width: SizeVariables.getWidth(context) *
                                //                 0.015),
                                //         InkWell(
                                //             onTap: widget.fromRegularisation == true
                                //                 ? () {}
                                //                 : () => showDatePicker(
                                //                             builder:
                                //                                 (context, child) =>
                                //                                     Theme(
                                //                                       data: ThemeData()
                                //                                           .copyWith(
                                //                                         colorScheme:
                                //                                             const ColorScheme
                                //                                                 .dark(
                                //                                           primary: Color(
                                //                                               0xffF59F23),
                                //                                           surface: Colors
                                //                                               .black,
                                //                                           onSurface:
                                //                                               Colors
                                //                                                   .white,
                                //                                         ),
                                //                                         dialogBackgroundColor:
                                //                                             Color.fromARGB(
                                //                                                 255,
                                //                                                 91,
                                //                                                 91,
                                //                                                 91),
                                //                                       ),
                                //                                       child: child!,
                                //                                     ),
                                //                             context: context,
                                //                             initialDate:
                                //                                 DateTime.now(),
                                //                             firstDate: DateTime.now(),
                                //                             lastDate: DateTime.now()
                                //                                 .add(const Duration(
                                //                                     days: 365)))
                                //                         .then((value) {
                                //                       setState(() {
                                //                         _dateTimeEnd = value;
                                //                       });
                                //                       print(
                                //                           'DATE TIME: $_dateTimeEnd');
                                //                     }),
                                //             child: Icon(Icons.calendar_month,
                                //                 color:
                                //                     Theme.of(context).accentColor)),
                                //       ],
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04,
                          // top: SizeVariables.getHeight(context) * 0.02,
                          right: SizeVariables.getWidth(context) * 0.04,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'To',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //     left: SizeVariables.getWidth(context) * 0.35,
                            //   ),
                            //   child: FittedBox(
                            //     fit: BoxFit.contain,
                            //     child: Text(
                            //       'Duration',
                            //       style: Theme.of(context).textTheme.bodyText2,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.03),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: widget.fromRegularisation == 2
                                      ? () {}
                                      : () => showDatePicker(
                                                  builder: (context, child) =>
                                                      Theme(
                                                        data: ThemeData()
                                                            .copyWith(
                                                          colorScheme:
                                                              const ColorScheme
                                                                  .dark(
                                                            primary: Color(
                                                                0xffF59F23),
                                                            surface:
                                                                Colors.black,
                                                            onSurface:
                                                                Colors.white,
                                                          ),
                                                          dialogBackgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  91,
                                                                  91,
                                                                  91),
                                                        ),
                                                        child: child!,
                                                      ),
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 365)))
                                              .then((value) {
                                            setState(() {
                                              _dateTimeEnd = value;
                                            });
                                          }),
                                  child: Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.045,
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.02,
                                        right: SizeVariables.getWidth(context) *
                                            0.01),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 3,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            widget.fromRegularisation == 2
                                                ? Text(
                                                    dateFormat.format(
                                                        DateTime.parse(
                                                            widget.date)),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1)
                                                : Text(
                                                    _dateTimeEnd == null
                                                        ? 'Select Date'
                                                        : '${dateFormat.format(DateTime.parse(_dateTimeEnd.toString()))}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1,
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.015),
                                        InkWell(
                                            onTap: widget.fromRegularisation ==
                                                    2
                                                ? () {}
                                                : () => showDatePicker(
                                                            builder:
                                                                (context,
                                                                        child) =>
                                                                    Theme(
                                                                      data: ThemeData()
                                                                          .copyWith(
                                                                        colorScheme:
                                                                            const ColorScheme.dark(
                                                                          primary:
                                                                              Color(0xffF59F23),
                                                                          surface:
                                                                              Colors.black,
                                                                          onSurface:
                                                                              Colors.white,
                                                                        ),
                                                                        dialogBackgroundColor: Color.fromARGB(
                                                                            255,
                                                                            91,
                                                                            91,
                                                                            91),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    ),
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate: DateTime
                                                                    .now()
                                                                .add(const Duration(
                                                                    days: 365)))
                                                        .then((value) {
                                                      setState(() {
                                                        _dateTimeEnd = value;
                                                      });
                                                    }),
                                            child: Icon(Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .canvasColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.08,
                                ),
                                _selectedItem == 4 ||
                                        _dateTimeStart == _dateTimeEnd
                                    ? Container()
                                    : Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            dropdownColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            value: selectedItem2,
                                            hint: Text(
                                              'Select Duration',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            items: leaveDuration
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!,
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (item) {
                                              setState(() {
                                                selectedItem2 = item;
                                              });
                                              print(
                                                  'Selected Station: $selectedItem2');
                                            },
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor:
                                  Theme.of(context).colorScheme.secondary,
                              value: selectedItem3,
                              hint: const Text(
                                'Reason',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              items: reason
                                  .map((item) => DropdownMenuItem(
                                      value: item['reason'],
                                      child: Text(
                                        item['reason'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
                                      )
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       item['leave_types'],
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .bodyText1!,
                                      //     ),
                                      //     Text(
                                      //       item['number'].toString(),
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .bodyText1!,
                                      //     )
                                      //   ],
                                      // ),
                                      ))
                                  .toList(),
                              onChanged: (item) {
                                setState(() {
                                  selectedItem3 = item;
                                });
                                print('Selected Station: $item');
                                print('Selected Subject: $selectedItem3');
                              },
                            ),
                          ),
                          Form(
                            key: _key,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      SizeVariables.getWidth(context) * 0.025,
                                  left: SizeVariables.getWidth(context) * 0.025,
                                  top: SizeVariables.getWidth(context) * 0.04),
                              child: Container(
                                decoration: (themeProvider.darkTheme)
                                    ? BoxDecoration()
                                    : BoxDecoration(
                                        // border: Border.all(
                                        //     color: Colors.amber, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: (themeProvider.darkTheme)
                                            ? []
                                            : [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 7,
                                                  //offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                      ),
                                child: ContainerStyle(
                                  // margin: const EdgeInsets.only(right: 25),
                                  height: height > 750
                                      ? 15.h
                                      : height < 650
                                          ? 23.h
                                          : 20.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.025, // add new design
                                    ),
                                    child: TextFormField(
                                      autofocus: false,
                                      controller: _textController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        // border: OutlineInputBorder(
                                        //   borderSide: BorderSide(color: Colors.grey),
                                        // ),
                                        // fillColor: Colors.grey,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 18,
                                          ),
                                      maxLines: 15,
                                      validator: (value) {
                                        if (value!.isEmpty || value == '') {
                                          return 'Please enter Reason';
                                        } else {
                                          add = value;
                                          return null;
                                        }
                                      },
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
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              isSelected
                  ? const CircularProgressIndicator()
                  : Container(
                      child: AnimatedButton(
                        height: 50,
                        width: 150,
                        text: 'Submit',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: (themeProvider.darkTheme)
                                ? Colors.white
                                : Colors.black),
                        backgroundColor: (themeProvider.darkTheme)
                            ? Colors.black
                            : Colors.amberAccent,
                        borderColor: (themeProvider.darkTheme)
                            ? Colors.white
                            : Colors.amberAccent,
                        borderRadius: 8,
                        borderWidth: 2,
                        onPress: () {
                          if (_dateTimeStart == null) {
                            Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    borderRadius: BorderRadius.circular(10),
                                    leftBarIndicatorColor: Colors.red,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                    message: 'Please Select Date')
                                .show(context);
                          } else if (_selectedItem != 4 &&
                              selectedItem == null) {
                            Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    borderRadius: BorderRadius.circular(10),
                                    leftBarIndicatorColor: Colors.red,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                    message: 'Please Select Duration')
                                .show(context);
                          } else if (_dateTimeEnd == null) {
                            Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    borderRadius: BorderRadius.circular(10),
                                    leftBarIndicatorColor: Colors.red,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                    message: 'Please Select To Date')
                                .show(context);
                          } else if (_selectedItem != 4 &&
                              _dateTimeStart != _dateTimeEnd &&
                              selectedItem2 == null) {
                            Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    borderRadius: BorderRadius.circular(10),
                                    leftBarIndicatorColor: Colors.red,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                    message: 'Please Select Duration')
                                .show(context);
                          } else if (_selectedItem == null) {
                            Flushbar(
                                    duration: const Duration(seconds: 4),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    borderRadius: BorderRadius.circular(10),
                                    leftBarIndicatorColor: Colors.red,
                                    icon: const Icon(Icons.error,
                                        color: Colors.white),
                                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                    message: 'Please Select Type')
                                .show(context);
                          } else if (_key.currentState!.validate()) {
                            FocusScope.of(context).unfocus();

                            setState(() {
                              isSelected = true;
                            });

                            Map<String, dynamic> data = _selectedItem == 4
                                ? {
                                    'start_date': widget.fromRegularisation == 2
                                        ? dateFormat
                                            .format(DateTime.parse(widget.date))
                                        : dateFormat
                                            .format(_dateTimeStart!)
                                            .toString(),
                                    'end_date': widget.fromRegularisation == 2
                                        ? dateFormat
                                            .format(DateTime.parse(widget.date))
                                        : dateFormat
                                            .format(_dateTimeEnd!)
                                            .toString()
                                  }
                                : {
                                    'leave_type': _selectedItem,
                                    'start_date': widget.fromRegularisation == 2
                                        ? dateFormat
                                            .format(DateTime.parse(widget.date))
                                        : dateFormat
                                            .format(_dateTimeStart!)
                                            .toString(),
                                    'end_date': widget.fromRegularisation == 2
                                        ? dateFormat
                                            .format(DateTime.parse(widget.date))
                                        : dateFormat
                                            .format(_dateTimeEnd!)
                                            .toString(),
                                    'subject': selectedItem3,
                                    'description': add,
                                    'start_half_day': selectedItem == 'Half Day'
                                        ? 'halfday'
                                        : 'fullday',
                                    'end_half_day':
                                        _dateTimeStart == _dateTimeEnd
                                            ? selectedItem == 'Half Day'
                                                ? 'halfday'
                                                : 'fullday'
                                            : selectedItem2 == 'Half Day'
                                                ? 'halfday'
                                                : 'fullday'
                                  };

                            print('LEAAAAAVE: $data');

                            widget.fromRegularisation == 1
                                ? Provider.of<LeaveListViewModel>(context,
                                        listen: false)
                                    .editLeave(widget.leaveId, context)
                                : _selectedItem == 4
                                    ? Provider.of<LeaveViewModel>(context,
                                            listen: false)
                                        .postCompOffRequest(context, data)
                                        .then((value) {
                                        setState(() {
                                          isSelected = false;
                                          _textController.clear();
                                          _dateTimeStart = null;
                                          _dateTimeEnd = null;
                                        });
                                      })
                                    // print('DATA: $data')
                                    : Provider.of<LeaveViewModel>(context,
                                            listen: false)
                                        .postLeaveRequests(data, context)
                                        .then((value) {
                                        setState(() {
                                          isSelected = false;
                                          _textController.clear();
                                          _dateTimeStart = null;
                                          _dateTimeEnd = null;
                                        });
                                      });

                            // List<String> date = [
                            //   dateFormat.format(_dateTimeStart!).toString(),
                            //   dateFormat.format(_dateTimeEnd!).toString()
                            // ];
                            // Map<String, dynamic> data = _selectedItem == 4
                            //     ? {
                            //         'start_date': widget.fromRegularisation == true
                            //             ? dateFormat
                            //                 .format(DateTime.parse(widget.date))
                            //             : dateFormat
                            //                 .format(_dateTimeStart!)
                            //                 .toString(),
                            //         'end_date': widget.fromRegularisation == true
                            //             ? dateFormat
                            //                 .format(DateTime.parse(widget.date))
                            //             : dateFormat.format(_dateTimeEnd!).toString()
                            //       }
                            //     : {
                            //         'leave_type': _selectedItem,
                            //         'start_date': widget.fromRegularisation == true
                            //             ? dateFormat
                            //                 .format(DateTime.parse(widget.date))
                            //             : dateFormat
                            //                 .format(_dateTimeStart!)
                            //                 .toString(),
                            //         'end_date': widget.fromRegularisation == true
                            //             ? dateFormat
                            //                 .format(DateTime.parse(widget.date))
                            //             : dateFormat.format(_dateTimeEnd!).toString(),
                            //         'description': add
                            //       };
                            // if (kDebugMode) {
                            //   print('DATA: $data');
                            // }

                            // print('DATA: $data');
                          }
                        },
                      ),
                    ),
            ],
          );
  }
}
