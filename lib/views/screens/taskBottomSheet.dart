import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../provider/theme_provider.dart';
import '../../res/appUrl.dart';
import '../../res/components/containerStyle.dart';
import '../../viewModel/reportingTreeViewModel.dart';
import '../../viewModel/toDoViewModel/todaysTask.dart';
import '../config/mediaQuery.dart';

class ModalBottomSheet extends StatefulWidget {
  ModalBottomSheetState createState() => ModalBottomSheetState();
}

class ModalBottomSheetState extends State<ModalBottomSheet> {
  int? _radioValue = 0;
  int? _managerValue = 0;
  int _selectionTab = 0;
  String assignedName = '';
  String assignedId = '';
  int? role;
  int? userId;
  String? _selection1;
  DateTime? _dateTime;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? input;
  TextEditingController taskController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController _taskTitle = TextEditingController();
  int? diff;
  bool isLoading = true;
  int _selection = 0;
  GlobalKey<FormState> _key1 = GlobalKey<FormState>();
  String title = '';
  String body = '';
  bool workSelected = false;
  bool personalSelected = false;
  bool completedLoading = true;
  bool hierarchyLoader = true;
  bool isClicked = false;

  @override
  void initState() {
    initialise().then((_) {
      if (role == 0) {
        setState(() {
          isLoading = false;
        });
      } else {
        Provider.of<ReportingTreeViewModel>(context, listen: false)
            .getReportingTree(context, userId!)
            .then((_) {
          setState(() {
            isLoading = false;
          });
        });
      }
    });

    super.initState();
  }

  Future<void> initialise() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      role = localStorage.getInt('role');
      userId = localStorage.getInt('userId');
    });

    // print('Role: $role');
  }

  Future<void> _selectedOption(String type, StateSetter state) async {
    // setState(() {
    //   _selection1 = type;
    // });
    if (type == 'work') {
      state(() {
        workSelected = true;
        personalSelected == false;
        _selection1 = type;
        print('WORKKKK');
        print('Work Selected: $workSelected');
        print('Personal Selected: $personalSelected');
      });
    }
    if (type == 'personal') {
      state(() {
        workSelected = false;
        personalSelected = true;
        _selection1 = type;
        print('PERSONAAAALLL');
        print('Work Selected: $workSelected');
        print('Personal Selected: $personalSelected');
      });
    }

    print('Selected OPTIOOOOOON: $_selection1');
  }

  employeeModalSheet(BuildContext context) {
    bool isEmployeeLoading = true;
    var providerTwo =
        Provider.of<ReportingTreeViewModel>(context, listen: false).all;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Container(
                  height: SizeVariables.getHeight(context) * 0.9,
                  padding:
                      EdgeInsets.all(SizeVariables.getWidth(context) * 0.01),
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: providerTwo.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        providerTwo[index]['user']['emp_name'] == null ||
                                providerTwo[index]['user']['company_id'] ==
                                    null ||
                                providerTwo[index]['user']['id'] == null ||
                                providerTwo[index]['user']['department_name'] ==
                                    null
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    assignedName =
                                        providerTwo[index]['user']['emp_name'];
                                    assignedId = providerTwo[index]['user']
                                            ['id']
                                        .toString();
                                  });
                                  print('ASSIGNED NAME: $assignedName');
                                  print('ASSIGNED ID: $assignedId');

                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: providerTwo[index]['user']
                                                  ['profile_photo'] ==
                                              null
                                          ? CircleAvatar(
                                              radius: SizeVariables.getWidth(
                                                      context) *
                                                  0.08,
                                              backgroundColor: Colors.green,
                                              backgroundImage: const AssetImage(
                                                'assets/img/profilePic.jpg',
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  '${AppUrl.baseUrl}/profile_photo/${providerTwo[index]['user']['profile_photo']}',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                radius: SizeVariables.getWidth(
                                                        context) *
                                                    0.08,
                                                backgroundColor: Colors.green,
                                                backgroundImage: imageProvider,
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor:
                                                    const Color.fromARGB(
                                                        255, 120, 120, 120),
                                                child: CircleAvatar(
                                                  radius:
                                                      SizeVariables.getWidth(
                                                              context) *
                                                          0.08,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      CircleAvatar(
                                                radius: SizeVariables.getWidth(
                                                        context) *
                                                    0.08,
                                                backgroundColor: Colors.green,
                                                backgroundImage:
                                                    const AssetImage(
                                                  'assets/img/profilePic.jpg',
                                                ),
                                              ),
                                            ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          providerTwo[index]['user']
                                              ['emp_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                        Text(
                                          providerTwo[index]['user']
                                              ['department_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 10.sp,
                                                color: Colors.grey,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: role == 0
            ? SizeVariables.getHeight(context) * 0.55
            : SizeVariables.getHeight(context) * 0.7,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            role == 0
                ? Container(
                    height: SizeVariables.getHeight(context) * 0.05,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0))),
                    child: Container(
                      height: 30,
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            fillColor: (themeProvider.darkTheme)
                                ? MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.black;
                                    }
                                    return Colors.white;
                                  })
                                : MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.black;
                                    }
                                    return Colors.black;
                                  }),
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              setState(() {
                                _radioValue = 0;
                              });
                              // ignore: avoid_print, prefer_interpolation_to_compose_strings
                              print("radiofirst" +
                                  value.toString() +
                                  "radiovalue" +
                                  _radioValue.toString());
                            },
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.work_outline,
                                color: Theme.of(context).canvasColor,
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.007,
                              ),
                              const Text(
                                'Work',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Radio(
                            fillColor: (themeProvider.darkTheme)
                                ? MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.black;
                                    }
                                    return Colors.white;
                                  })
                                : MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.black;
                                    }
                                    return Colors.black;
                                  }),
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: (value) {
                              setState(() {
                                _radioValue = 1;
                              });
                              // ignore: prefer_interpolation_to_compose_strings
                              print("radiosecond " +
                                  value.toString() +
                                  "radiovalue " +
                                  _radioValue.toString());
                            },
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Theme.of(context).canvasColor,
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.007,
                              ),
                              const Text(
                                'Personal',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: SizeVariables.getHeight(context) * 0.17,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      // color: Colors.amber,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.amberAccent.shade200,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: _radioValue == 0
                                            ? InkWell(
                                                onTap: () {
                                                  Provider.of<ReportingTreeViewModel>(
                                                          context,
                                                          listen: false)
                                                      .getReportingTree(
                                                          context, userId!)
                                                      .then(
                                                        (_) =>
                                                            employeeModalSheet(
                                                                context),
                                                      );
                                                },
                                                child: CircleAvatar(
                                                  radius:
                                                      SizeVariables.getWidth(
                                                              context) *
                                                          0,
                                                  backgroundImage:
                                                      const AssetImage(
                                                    'assets/img/profilePic.jpg',
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                child: Center(
                                                  child: Lottie.asset(
                                                    'assets/json/ToDo.json',
                                                    height: 150,
                                                    width: 150,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  _radioValue == 1
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Container(
                                            child: assignedName == '' ||
                                                    assignedName == null
                                                ? InkWell(
                                                    onTap: () {
                                                      Provider.of<ReportingTreeViewModel>(
                                                              context,
                                                              listen: false)
                                                          .getReportingTree(
                                                              context, userId!)
                                                          .then(
                                                            (_) =>
                                                                employeeModalSheet(
                                                                    context),
                                                          );
                                                    },
                                                    child: Text(
                                                      'Assign to ',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      Provider.of<ReportingTreeViewModel>(
                                                              context,
                                                              listen: false)
                                                          .getReportingTree(
                                                              context, userId!)
                                                          .then(
                                                            (_) =>
                                                                employeeModalSheet(
                                                                    context),
                                                          );
                                                    },
                                                    child: Text(
                                                      assignedName,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                RadioListTile(
                                  selected: false,
                                  value: 0,
                                  groupValue: _radioValue,
                                  title: Text(
                                    'Work',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _radioValue = 0;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                                RadioListTile(
                                  selected: false,
                                  value: 1,
                                  groupValue: _radioValue,
                                  title: Text(
                                    'Personal',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _radioValue = 1;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Form(
              key: _key1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                    ),
                    width: 75,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Task Name',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: SizeVariables.getWidth(context) * 0.025,
                      left: SizeVariables.getWidth(context) * 0.025,
                      top: SizeVariables.getWidth(context) * 0.02,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: (themeProvider.darkTheme)
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                ),
                              ],
                      ),
                      child: ContainerStyle(
                        height: MediaQuery.of(context).size.height > 750
                            ? 5.5.h
                            : MediaQuery.of(context).size.height < 650
                                ? 4.h
                                : 5.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            autofocus: false,
                            controller: _taskTitle,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                    ),
                            // maxLines: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                    ),
                    width: 70,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Description',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: SizeVariables.getWidth(context) * 0.025,
                      left: SizeVariables.getWidth(context) * 0.025,
                      top: SizeVariables.getWidth(context) * 0.02,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: (themeProvider.darkTheme)
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                ),
                              ],
                      ),
                      child: ContainerStyle(
                        height: MediaQuery.of(context).size.height > 750
                            ? 16.h
                            : MediaQuery.of(context).size.height < 650
                                ? 19.h
                                : 16.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            autofocus: false,
                            controller: taskController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16),
                            maxLines: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 4, top: 4, bottom: 4, left: 10),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: _selection == 0
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                          ),
                        ),
                        primary: _selection == 0
                            ? const Color.fromARGB(255, 117, 99, 44)
                            : null,
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.15,
                        child: Center(
                          child: Text(
                            'Today',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selection = 0;
                        });
                        print('SELECTION: $_selection');
                      },
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: _selection == 1
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                          ),
                        ),
                        primary: _selection == 1
                            ? const Color.fromARGB(255, 117, 99, 44)
                            : null,
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.17,
                        child: Center(
                          child: Text(
                            'Yesterday',
                            style: Theme.of(context).textTheme.bodyText1,
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
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: _selection == 2
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                          ),
                        ),
                        primary: _selection == 2
                            ? const Color.fromARGB(255, 117, 99, 44)
                            : null,
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.17,
                        child: Center(
                          child: Text(
                            _dateTime == null
                                ? 'Custom'
                                : DateFormat('dd-MMM-yyyy').format(
                                    DateTime.parse(
                                      _dateTime.toString(),
                                    ),
                                  ),
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _selection = 2;
                        });
                        showDatePicker(
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xffF59F23),
                                surface: Colors.black,
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor:
                                  const Color.fromARGB(255, 91, 91, 91),
                            ),
                            child: child!,
                          ),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        ).then((date) {
                          setState(() {
                            _dateTime = date;
                            diff = DateTime.parse(_dateTime.toString())
                                    .difference(
                                      DateTime.parse(
                                        DateTime.now().toString(),
                                      ),
                                    )
                                    .inDays +
                                1;
                          });
                          if (kDebugMode) {
                            print('DIFFERENCE: $diff');
                            print('DATE TIMEEEEEE: $_dateTime');
                          }
                        });
                        print('SELECTION: $_selection');
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // color: Colors.pink,
                  width: SizeVariables.getWidth(context) * 0.35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(168, 123, 121, 121),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (_taskTitle.text == '') {
                        Flushbar(
                          duration: const Duration(seconds: 4),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.error, color: Colors.white),
                          leftBarIndicatorColor: Colors.red,
                          message: 'Please Enter Title',
                          barBlur: 20,
                        ).show(context);
                      } else if (taskController.text == '') {
                        Flushbar(
                          duration: const Duration(seconds: 4),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.error, color: Colors.white),
                          leftBarIndicatorColor: Colors.red,
                          message: 'Please Enter Description',
                          barBlur: 20,
                        ).show(context);
                      } else {
                        Map<String, dynamic> _data = {
                          'category': _radioValue == 0 ? 'work' : 'personal',
                          'task_title': _taskTitle.text,
                          'task_name': taskController.text,
                          'task_date': _dateTime == null
                              ? dateFormat.format(
                                  DateTime.parse(
                                    DateTime.now().toString(),
                                  ),
                                )
                              : dateFormat.format(_dateTime!).toString(),
                          'emp_id': assignedId
                        };

                        print('Task Assign DATAAAAAA: $_data');

                        FocusScope.of(context).unfocus();

                        _managerValue == 0
                            ? Provider.of<TodaysTaskList>(context,
                                    listen: false)
                                .postTodaysTask(
                                    _data,
                                    diff == null || _dateTime == null
                                        ? 0
                                        : DateTime.parse(_dateTime.toString())
                                                    .difference(
                                                      DateTime.parse(
                                                        DateTime.now()
                                                            .toString(),
                                                      ),
                                                    )
                                                    .inDays <
                                                0
                                            ? -1
                                            : diff!,
                                    context)
                                .then(
                                (value) {
                                  setState(
                                    () {
                                      _taskTitle.clear();
                                      taskController.clear();
                                      _dateTime = null;
                                      isLoading = false;
                                    },
                                  );
                                },
                              )
                            : Provider.of<TodaysTaskList>(context,
                                    listen: false)
                                .assignTask(_data, context)
                                .then(
                                (value) {
                                  setState(
                                    () {
                                      _taskTitle.clear();
                                      taskController.clear();
                                      _dateTime = null;
                                      isLoading = false;
                                    },
                                  );
                                },
                              );
                      }
                    },
                    child: Text(
                      'ADD',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: const Color(0xffF59F23),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
