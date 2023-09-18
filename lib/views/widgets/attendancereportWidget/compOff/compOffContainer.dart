import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../viewModel/leaveRemainingViewModel.dart';
import '../../../../viewModel/leaveViewModel.dart';
import 'package:provider/provider.dart';

class CompOffContainer extends StatefulWidget {
  String date;
  // const CompOffContainer({Key? key}) : super(key: key);

  @override
  State<CompOffContainer> createState() => _CompOffContainerState();

  CompOffContainer(this.date);
}

class _CompOffContainerState extends State<CompOffContainer> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
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
  bool isSame = false;
  bool _isCheck = false;
  bool _isCheck1 = false;
  bool _isCheck2 = false;
  bool _isCheck3 = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _dateTimeStart =
          DateTime.parse(dateFormat.format(DateTime.parse(widget.date)));
      _dateTimeEnd =
          DateTime.parse(dateFormat.format(DateTime.parse(widget.date)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveRemainingViewModel>(context).leaveTypes;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Container(
          // color: Colors.red,
          child: ContainerStyle(
            height: height > 750
                ? 52.h
                : height < 650
                    ? 65.h
                    : 62.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
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
                            onTap: () {},
                            child: Container(
                              height: SizeVariables.getHeight(context) * 0.045,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02,
                                  right:
                                      SizeVariables.getWidth(context) * 0.01),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          dateFormat.format(
                                              DateTime.parse(widget.date)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ],
                                  ),
                                  SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.015),
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(Icons.calendar_month,
                                          color:
                                              Theme.of(context).canvasColor)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.08,
                          ),
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
                            onTap: () {},
                            child: Container(
                              height: SizeVariables.getHeight(context) * 0.045,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02,
                                  right:
                                      SizeVariables.getWidth(context) * 0.01),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          dateFormat.format(
                                              DateTime.parse(widget.date)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ],
                                  ),
                                  SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.015),
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(Icons.calendar_month,
                                          color:
                                              Theme.of(context).canvasColor)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.08,
                          ),
                          _selectedItem == 4 || _dateTimeStart == _dateTimeEnd
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
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: SizeVariables.getWidth(context) * 0.67),
                        child: Text(
                          'Reason',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: SizeVariables.getWidth(context) * 0.025,
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
                                            color: Colors.grey.withOpacity(0.5),
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
                              padding: const EdgeInsets.all(8),
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
                                style: Theme.of(context).textTheme.bodyText1,
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
                    if (_textController.text == '' || _textController == null) {
                      Flushbar(
                              duration: const Duration(seconds: 4),
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              borderRadius: BorderRadius.circular(10),
                              leftBarIndicatorColor: Colors.red,
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                              message: 'Please Enter Reason Date')
                          .show(context);
                    } else {
                      FocusScope.of(context).unfocus();

                      setState(() {
                        isSelected = true;
                      });

                      Map<String, dynamic> data = {
                        'start_date':
                            dateFormat.format(DateTime.parse(widget.date)),
                        'end_date':
                            dateFormat.format(DateTime.parse(widget.date))
                      };

                      print('LEAAAAAVE: $data');

                      Provider.of<LeaveViewModel>(context, listen: false)
                          .postCompOffRequest(context, data)
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
