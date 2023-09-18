import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chip_list/chip_list.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/appUrl.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
import 'package:claimz/views/screens/taskCompleteScreen.dart';
import 'package:claimz/views/widgets/tasklistWidget/taskContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/toDoViewModel.dart';
import '../../viewModel/toDoViewModel/tasksViewModel.dart';
import '../../viewModel/toDoViewModel/todaysTask.dart';
import '../config/mediaQuery.dart';
import '../widgets/taskListWidget/taskHeader.dart';
import '../../viewModel/toDoViewModel/tasksViewModel.dart';

class TaskList extends StatefulWidget {
  // const TaskList({Key? key}) : super(key: key);
  final bool flag;

  @override
  State<TaskList> createState() => _TaskListState();

  TaskList(this.flag);
}

class _TaskListState extends State<TaskList> {
  int? role;
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

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = false;
    });
    super.initState();
    Map data = {
      "month": "",
      "type": "",
      "year": "",
      "user_id": "",
      "all": "1" //self
    };
  }

  // @override
  // void initState() {
  //   // TODO: implement initState.
  //   tasksViewModel.getPreviousTask();
  //   tasksViewModel.getTodaysTask();
  //   tasksViewModel.getUpcomingTask();
  //   tasksViewModel.getCompletedTask();
  //   super.initState();
  // }
  String selected_mode = '';
  int _mode_of_travel = 0;
  final List<String> clipstyle = [
    'Work',
    'Personal',
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final toDoList =
        Provider.of<TodaysTaskList>(context, listen: true).getToDoList;

    final workCurrent = Provider.of<TodaysTaskList>(context).workCurrent;
    final workPrevious = Provider.of<TodaysTaskList>(context).workPrevious;
    final workUpcoming = Provider.of<TodaysTaskList>(context).workUpcoming;

    final personalCurrent =
        Provider.of<TodaysTaskList>(context).personalCurrent;
    final personalPrevious =
        Provider.of<TodaysTaskList>(context).personalPrevious;
    final personalUpcoming =
        Provider.of<TodaysTaskList>(context).personalUpcoming;

    var floatingActionButton;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: Container(
        margin:
            EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.06),
        child: RippleAnimation(
          repeat: true,
          color: (themeProvider.darkTheme)
              ? Colors.grey
              : Theme.of(context).colorScheme.onPrimary,
          minRadius: 33,
          ripplesCount: 2,
          child: FloatingActionButton(
            backgroundColor: (themeProvider.darkTheme)
                ? Color.fromARGB(255, 70, 69, 69)
                : Theme.of(context).colorScheme.onPrimary,
            onPressed: () => openDialog(context),
            child: Icon(
              Icons.add,
              color: (themeProvider.darkTheme) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: ListView(
          children: [
            Container(
              // height: SizeVariables.getHeight(context) * 0.07,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02,
                        left: SizeVariables.getWidth(context) * 0.01),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Task List',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _selection == 0
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                      ),
                      child: Text(
                        'All',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _selection = 0;
                          Map data = {
                            "month": "",
                            "type": "",
                            "year": "",
                            "user_id": "",
                            "all": "1" //self
                          };
                        });
                        print('SELECTION: $_selection');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _selection == 1
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                      ),
                      child: Text(
                        'Work',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _selection = 1;
                          Map data = {
                            "month": "",
                            "type": "domestic",
                            "year": "",
                            "user_id": "",
                            "all": "1" //self
                          };
                        });
                        print('SELECTION: $_selection');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: _selection == 2
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                      ),
                      child: Text(
                        'Personal',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _selection = 2;
                          Map data = {
                            "month": "",
                            "type": "international",
                            "year": "",
                            "user_id": "",
                            "all": "1" //self
                          };
                        });
                        print('SELECTION: $_selection');
                      },
                    ),
                  ),
                )
              ],
            ),
            // TaskContainer(),
            Column(
              children: [
                Container(
                  // height: SizeVariables.getHeight(context)*0.7,
                  // color: Colors.red,
                  child: Accordion(
                    // maxOpenSections: 2,
                    headerBackgroundColor: (themeProvider.darkTheme)
                        ? Colors.black38
                        : Theme.of(context).colorScheme.onPrimary,
                    headerBackgroundColorOpened: (themeProvider.darkTheme)
                        ? Colors.black54
                        : Theme.of(context).colorScheme.onPrimary,
                    scaleWhenAnimating: true,
                    openAndCloseAnimation: true,
                    headerPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                    sectionClosingHapticFeedback: SectionHapticFeedback.light,
                    // ignore: sort_child_properties_last
                    children: [
                      AccordionSection(
                        isOpen: true,
                        // leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
                        header: Text('Pending',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2! //Tanay---I have added the bang operator
                                .copyWith(color: Colors.white)),
                        // contentBorderColor:Colors.amber,
                        // headerBackgroundColorOpened: Colors.amber,
                        content: Container(
                          // color: Colors.green,
                          height: _selection == 0
                              ? toDoList['previous'].length > 3
                                  ? SizeVariables.getHeight(context) * 0.4
                                  : null
                              : _selection == 1
                                  ? workPrevious.length > 3
                                      ? SizeVariables.getHeight(context) * 0.4
                                      : null
                                  : personalPrevious.length > 3
                                      ? SizeVariables.getHeight(context) * 0.4
                                      : null,
                          child: _selection == 0 && toDoList['previous'].isEmpty
                              ? const Center(
                                  child: Text('No Pending Tasks'),
                                )
                              : _selection == 1 && workPrevious.isEmpty
                                  ? const Center(
                                      child: Text('No Pending Work Tasks'),
                                    )
                                  : _selection == 2 && personalPrevious.isEmpty
                                      ? const Center(
                                          child:
                                              Text('No Pending Personal Tasks'),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            margin: EdgeInsets.only(
                                                bottom: SizeVariables.getHeight(
                                                        context) *
                                                    0.02),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      // Future.delayed(
                                                      //     const Duration(seconds: 8), () => Navigator.of(context).pop());
                                                      return CupertinoAlertDialog(
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                'Task Name ',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.03,
                                                              ),
                                                              child: Text(
                                                                _selection == 0
                                                                    ? toDoList['previous'][index]
                                                                            [
                                                                            'task_title'] ??
                                                                        'No Title'
                                                                    : _selection ==
                                                                            1
                                                                        ? workPrevious[index]['task_title'] ??
                                                                            'No Title'
                                                                        : personalPrevious[index]['task_title'] ??
                                                                            'No Title',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.015,
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                'Description ',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.03,
                                                              ),
                                                              child: Text(
                                                                _selection == 0
                                                                    ? toDoList['previous'][index]
                                                                            [
                                                                            'task_name'] ??
                                                                        'No Description'
                                                                    : _selection ==
                                                                            1
                                                                        ? workPrevious[index]['task_name'] ??
                                                                            'No Description'
                                                                        : personalPrevious[index]['task_name'] ??
                                                                            'No Description',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.015,
                                                            ),
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      'Date: ',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.02,
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      _selection ==
                                                                              0
                                                                          ? toDoList['previous'][index]
                                                                              [
                                                                              'task_date']
                                                                          : _selection == 1
                                                                              ? workPrevious[index]['task_date']
                                                                              : personalPrevious[index]['task_date'],
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // SizedBox(
                                                            //   height: SizeVariables
                                                            //           .getHeight(
                                                            //               context) *
                                                            //       0.02,
                                                            // ),
                                                            // Container(
                                                            //   child: Row(
                                                            //     children: [
                                                            //       Container(
                                                            //         child: Text(
                                                            //           'Assigned by: ',
                                                            //           style: Theme.of(
                                                            //                   context)
                                                            //               .textTheme
                                                            //               .bodyText2!
                                                            //               .copyWith(
                                                            //                   color: Colors.black),
                                                            //         ),
                                                            //       ),
                                                            //       SizedBox(
                                                            //         width: SizeVariables.getWidth(
                                                            //                 context) *
                                                            //             0.02,
                                                            //       ),
                                                            //       Container(
                                                            //         child: Text(
                                                            //           'Shaikh Salim Akhtar ',
                                                            //           style: Theme.of(
                                                            //                   context)
                                                            //               .textTheme
                                                            //               .bodyText1!
                                                            //               .copyWith(
                                                            //                   color: Colors.black),
                                                            //         ),
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          // TextButton(
                                                          //     onPressed: () {
                                                          //       Navigator.pop(context);
                                                          //     },
                                                          //     child: Text(
                                                          //       'Yes',
                                                          //       style: Theme.of(context)
                                                          //           .textTheme
                                                          //           .bodyText1!
                                                          //           .copyWith(color: Colors.black),
                                                          //     )),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context); //close Dialog
                                                            },
                                                            child: Text(
                                                              'Close',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    });
                                                // Navigator.pushNamed(context,
                                                //     RouteNames.taskedit);
                                              },
                                              child: ContainerStyle(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.08,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.03,
                                                        // top: SizeVariables.getHeight(context)*0.03,
                                                      ),
                                                      child: RoundCheckBox(
                                                        onTap: (selected) {
                                                          Map<String, dynamic>
                                                              _data = {
                                                            'id': _selection ==
                                                                    0
                                                                ? toDoList['previous']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'task_id']
                                                                    .toString()
                                                                : _selection ==
                                                                        1
                                                                    ? workPrevious[index]
                                                                            [
                                                                            'task_id']
                                                                        .toString()
                                                                    : personalPrevious[index]
                                                                            [
                                                                            'task_id']
                                                                        .toString()
                                                          };
                                                          Future.delayed(const Duration(seconds: 1)).then(
                                                              (value) => Provider.of<
                                                                          TodaysTaskList>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .changeTaskStatus(
                                                                      'previous',
                                                                      _selection,
                                                                      _data,
                                                                      context)
                                                              //     .then(
                                                              //         (value) {
                                                              //   setState(
                                                              //       () {
                                                              //     _selection ==
                                                              //             0
                                                              //         ? toDoList['previous']
                                                              //             .removeAt(index)
                                                              //         : _selection == 1
                                                              //             ? workPrevious.removeAt(index)
                                                              //             : personalPrevious.removeAt(index);
                                                              //   });
                                                              // })
                                                              );

                                                          // ChangeNotifierProvider<
                                                          //     PreviousTaskList>(
                                                          //   create: (context) =>
                                                          //       previousTaskList,
                                                          // );
                                                          // previousTaskList.getPreviousList();
                                                        },
                                                        size: 23,
                                                        // uncheckedColor: Colors.yellow,
                                                        checkedColor:
                                                            Colors.grey,
                                                        uncheckedColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.025,
                                                        top: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.04,
                                                      ),
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              // fit: BoxFit.contain,
                                                              child: Text(
                                                                  _selection ==
                                                                          0
                                                                      ? toDoList['previous'][index]
                                                                              [
                                                                              'task_title'] ??
                                                                          'No Title'
                                                                      : _selection ==
                                                                              1
                                                                          ? workPrevious[index]['task_title'] ??
                                                                              'No Title'
                                                                          : personalPrevious[index]['task_title'] ??
                                                                              'No Title',
                                                                  // value
                                                                  //     .previousModelList
                                                                  //     .data!
                                                                  //     .today![index]
                                                                  //     .taskName
                                                                  //     .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                  right: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.25),
                                                              child: Text(
                                                                _selection == 0
                                                                    ? toDoList['previous']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'task_date']
                                                                    : _selection ==
                                                                            1
                                                                        ? workPrevious[index]
                                                                            [
                                                                            'task_date']
                                                                        : personalPrevious[index]
                                                                            [
                                                                            'task_date'],
                                                                // value
                                                                //     .previousModelList
                                                                //     .data!
                                                                //     .today![index]
                                                                //     .taskDate
                                                                //     .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          itemCount: _selection == 0
                                              ? toDoList['previous'].length
                                              : _selection == 1
                                                  ? workPrevious.length
                                                  : personalPrevious.length,
                                          // value.previousModelList.data!
                                          //     .today!.length,
                                        ),
                        ),
                      ),
                      AccordionSection(
                        isOpen: false,
                        // leftIcon: const Icon(Icons.food_bank, color: Colors.white),
                        header: Text('Current',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white)),
                        content: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    SizeVariables.getHeight(context) * 0.02),
                            // height: SizeVariables.getHeight(context) * 0.4,
                            child: Container(
                              height: _selection == 0
                                  ? toDoList['today'].length > 3
                                      ? SizeVariables.getHeight(context) * 0.4
                                      : null
                                  : _selection == 1
                                      ? workCurrent.length > 3
                                          ? SizeVariables.getHeight(context) *
                                              0.4
                                          : null
                                      : personalCurrent.length > 3
                                          ? SizeVariables.getHeight(context) *
                                              0.4
                                          : null,
                              child:
                                  _selection == 0 && toDoList['today'].isEmpty
                                      ? const Center(
                                          child: Text('No Current Tasks'),
                                        )
                                      : _selection == 1 && workCurrent.isEmpty
                                          ? const Center(
                                              child: Text(
                                                  'No Current Tasks in Work'),
                                            )
                                          : _selection == 2 &&
                                                  personalCurrent.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                      'No Current Tasks in Personal'),
                                                )
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.02),
                                                            child: InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      // Future.delayed(
                                                                      //     const Duration(seconds: 8), () => Navigator.of(context).pop());
                                                                      return CupertinoAlertDialog(
                                                                        content:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(
                                                                                'Task Name ',
                                                                                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.only(
                                                                                left: SizeVariables.getWidth(context) * 0.03,
                                                                              ),
                                                                              child: Text(
                                                                                _selection == 0
                                                                                    ? toDoList['today'][index]['task_title'] ?? 'No Title'
                                                                                    : _selection == 1
                                                                                        ? workCurrent[index]['task_title'] ?? 'No Title'
                                                                                        : personalCurrent[index]['task_title'] ?? 'No Title',
                                                                                // overflow: TextOverflow.ellipsis,
                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                      color: Colors.black,
                                                                                      fontSize: 16,
                                                                                    ),
                                                                                textAlign: TextAlign.start,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: SizeVariables.getHeight(context) * 0.015,
                                                                            ),
                                                                            Container(
                                                                              child: Text(
                                                                                'Description ',
                                                                                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.only(
                                                                                left: SizeVariables.getWidth(context) * 0.03,
                                                                              ),
                                                                              child: Text(
                                                                                _selection == 0
                                                                                    ? toDoList['today'][index]['task_name'] ?? 'No Description'
                                                                                    : _selection == 1
                                                                                        ? workCurrent[index]['task_name'] ?? 'No Description'
                                                                                        : personalCurrent[index]['task_name'] ?? 'No Description',
                                                                                // overflow: TextOverflow.ellipsis,
                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black, fontSize: 16),
                                                                                textAlign: TextAlign.start,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: SizeVariables.getHeight(context) * 0.015,
                                                                            ),
                                                                            Container(
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    child: Text(
                                                                                      'Date: ',
                                                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: SizeVariables.getWidth(context) * 0.02,
                                                                                  ),
                                                                                  Container(
                                                                                    child: Text(
                                                                                      _selection == 0
                                                                                          ? toDoList['today'][index]['task_date']
                                                                                          : _selection == 1
                                                                                              ? workCurrent[index]['task_date']
                                                                                              : personalCurrent[index]['task_date'],
                                                                                      // overflow: TextOverflow.ellipsis,
                                                                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            // SizedBox(
                                                                            //   height: SizeVariables
                                                                            //           .getHeight(
                                                                            //               context) *
                                                                            //       0.02,
                                                                            // ),
                                                                            // Container(
                                                                            //   child: Row(
                                                                            //     children: [
                                                                            //       Container(
                                                                            //         child: Text(
                                                                            //           'Assigned by: ',
                                                                            //           style: Theme.of(
                                                                            //                   context)
                                                                            //               .textTheme
                                                                            //               .bodyText2!
                                                                            //               .copyWith(
                                                                            //                   color: Colors.black),
                                                                            //         ),
                                                                            //       ),
                                                                            //       SizedBox(
                                                                            //         width: SizeVariables.getWidth(
                                                                            //                 context) *
                                                                            //             0.02,
                                                                            //       ),
                                                                            //       Container(
                                                                            //         child: Text(
                                                                            //           'Shaikh Salim Akhtar ',
                                                                            //           style: Theme.of(
                                                                            //                   context)
                                                                            //               .textTheme
                                                                            //               .bodyText1!
                                                                            //               .copyWith(
                                                                            //                   color: Colors.black),
                                                                            //         ),
                                                                            //       ),
                                                                            //     ],
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                        actions: <Widget>[
                                                                          // TextButton(
                                                                          //     onPressed: () {
                                                                          //       Navigator.pop(context);
                                                                          //     },
                                                                          //     child: Text(
                                                                          //       'Yes',
                                                                          //       style: Theme.of(context)
                                                                          //           .textTheme
                                                                          //           .bodyText1!
                                                                          //           .copyWith(color: Colors.black),
                                                                          //     )),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context); //close Dialog
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              'Close',
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child:
                                                                  ContainerStyle(
                                                                height: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.08,
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: SizeVariables.getWidth(context) *
                                                                            0.03,
                                                                        // top: SizeVariables.getHeight(context)*0.03,
                                                                      ),
                                                                      child:
                                                                          RoundCheckBox(
                                                                        onTap:
                                                                            (selected) {
                                                                          Map<String, dynamic>
                                                                              _data =
                                                                              {
                                                                            'id': _selection == 0
                                                                                ? toDoList['today'][index]['task_id'].toString()
                                                                                : _selection == 1
                                                                                    ? workCurrent[index]['task_id'].toString()
                                                                                    : personalCurrent[index]['task_id'].toString()
                                                                          };

                                                                          print(
                                                                              'Current Task: $_data');

                                                                          Future.delayed(const Duration(seconds: 1)).then(
                                                                              (value) => Provider.of<TodaysTaskList>(context, listen: false).changeTaskStatus('current', _selection, _data, context)
                                                                              // .then((value) {
                                                                              //   setState(() {
                                                                              //     _selection == 0
                                                                              //         ? toDoList['today'].removeAt(index)
                                                                              //         : _selection == 1
                                                                              //             ? workCurrent.removeAt(index)
                                                                              //             : personalCurrent.removeAt(index);
                                                                              //   });
                                                                              // })
                                                                              );

                                                                          // Provider.of<ToDoViewModel>(
                                                                          //         context,
                                                                          //         listen: false)
                                                                          //     .postToDoList(_data);
                                                                          // todaysTaskList.getTodayList();
                                                                        },
                                                                        size:
                                                                            23,
                                                                        checkedColor:
                                                                            Colors.grey,
                                                                        uncheckedColor:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: SizeVariables.getHeight(context) * 0.02,
                                                                              top: SizeVariables.getHeight(context) * 0.028),
                                                                          child:
                                                                              FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              // value
                                                                              //     .todayModelList
                                                                              //     .data!
                                                                              //     .today![
                                                                              //         index]
                                                                              //     .taskName
                                                                              //     .toString(),
                                                                              _selection == 0
                                                                                  ? toDoList['today'][index]['task_title'] ?? 'No Title'
                                                                                  : _selection == 1
                                                                                      ? workCurrent[index]['task_title'] ?? 'No Title'
                                                                                      : personalCurrent[index]['task_title'] ?? 'No Title',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: Theme.of(context).textTheme.bodyText1!,
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
                                                  itemCount: _selection == 0
                                                      ? toDoList['today'].length
                                                      : _selection == 1
                                                          ? workCurrent.length
                                                          : personalCurrent
                                                              .length
                                                  // value.todayModelList.data!
                                                  //     .today!.length
                                                  ),
                            )),
                      ),
                      AccordionSection(
                        isOpen: false,
                        // leftIcon: const Icon(Icons.contact_page, color: Colors.white),
                        header: Text('Upcoming',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white)),

                        content: Container(
                          height: _selection == 0
                              ? toDoList['upcoming'].length > 3
                                  ? SizeVariables.getHeight(context) * 0.4
                                  : null
                              : _selection == 1
                                  ? workUpcoming.length > 3
                                      ? SizeVariables.getHeight(context) * 0.4
                                      : null
                                  : personalUpcoming.length > 3
                                      ? SizeVariables.getHeight(context) * 0.4
                                      : null,
                          child: _selection == 0 && toDoList['upcoming'].isEmpty
                              ? const Center(
                                  child: Text('No Upcoming Tasks'),
                                )
                              : _selection == 1 && workUpcoming.isEmpty
                                  ? const Center(
                                      child: Text('No Upcoming Tasks in Work'),
                                    )
                                  : _selection == 2 && personalUpcoming.isEmpty
                                      ? const Center(
                                          child: Text(
                                              'No Upcoming Tasks in Personal'),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (context, index) => Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.02),
                                                    child: InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              // Future.delayed(
                                                              //     const Duration(seconds: 8), () => Navigator.of(context).pop());
                                                              return CupertinoAlertDialog(
                                                                content: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        'Task Name ',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(
                                                                                color: Colors.black,
                                                                                fontSize: 12),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: SizeVariables.getWidth(context) *
                                                                            0.03,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        _selection ==
                                                                                0
                                                                            ? toDoList['upcoming'][index]['task_title'] ??
                                                                                'No Title'
                                                                            : _selection == 1
                                                                                ? workUpcoming[index]['task_title'] ?? 'No Title'
                                                                                : personalUpcoming[index]['task_title'] ?? 'No Title',
                                                                        // overflow:
                                                                        //     TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                              color: Colors.black,
                                                                              fontSize: 16,
                                                                            ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.015,
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        'Description ',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2!
                                                                            .copyWith(
                                                                                color: Colors.black,
                                                                                fontSize: 12),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: SizeVariables.getWidth(context) *
                                                                            0.03,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        _selection ==
                                                                                0
                                                                            ? toDoList['upcoming'][index]['task_name'] ??
                                                                                'No Description'
                                                                            : _selection == 1
                                                                                ? workUpcoming[index]['task_name'] ?? 'No Description'
                                                                                : personalUpcoming[index]['task_name'] ?? 'No Description',
                                                                        // overflow:
                                                                        //     TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                                color: Colors.black,
                                                                                fontSize: 16),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.015,
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                Text(
                                                                              'Date: ',
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                SizeVariables.getWidth(context) * 0.02,
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                Text(
                                                                              _selection == 0
                                                                                  ? toDoList['upcoming'][index]['task_date']
                                                                                  : _selection == 1
                                                                                      ? workUpcoming[index]['task_date']
                                                                                      : personalUpcoming[index]['task_date'],
                                                                              // overflow: TextOverflow.ellipsis,
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    // SizedBox(
                                                                    //   height: SizeVariables
                                                                    //           .getHeight(
                                                                    //               context) *
                                                                    //       0.02,
                                                                    // ),
                                                                    // Container(
                                                                    //   child: Row(
                                                                    //     children: [
                                                                    //       Container(
                                                                    //         child: Text(
                                                                    //           'Assigned by: ',
                                                                    //           style: Theme.of(
                                                                    //                   context)
                                                                    //               .textTheme
                                                                    //               .bodyText2!
                                                                    //               .copyWith(
                                                                    //                   color: Colors.black),
                                                                    //         ),
                                                                    //       ),
                                                                    //       SizedBox(
                                                                    //         width: SizeVariables.getWidth(
                                                                    //                 context) *
                                                                    //             0.02,
                                                                    //       ),
                                                                    //       Container(
                                                                    //         child: Text(
                                                                    //           'Shaikh Salim Akhtar ',
                                                                    //           style: Theme.of(
                                                                    //                   context)
                                                                    //               .textTheme
                                                                    //               .bodyText1!
                                                                    //               .copyWith(
                                                                    //                   color: Colors.black),
                                                                    //         ),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  // TextButton(
                                                                  //     onPressed: () {
                                                                  //       Navigator.pop(context);
                                                                  //     },
                                                                  //     child: Text(
                                                                  //       'Yes',
                                                                  //       style: Theme.of(context)
                                                                  //           .textTheme
                                                                  //           .bodyText1!
                                                                  //           .copyWith(color: Colors.black),
                                                                  //     )),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context); //close Dialog
                                                                    },
                                                                    child: Text(
                                                                      'Close',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: ContainerStyle(
                                                        height: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.08,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.03,
                                                                // top: SizeVariables.getHeight(context)*0.03,
                                                              ),
                                                              child:
                                                                  RoundCheckBox(
                                                                onTap:
                                                                    (selected) {
                                                                  Map<String,
                                                                          dynamic>
                                                                      _data = {
                                                                    'id': _selection ==
                                                                            0
                                                                        ? toDoList['upcoming'][index]['task_id']
                                                                            .toString()
                                                                        : _selection ==
                                                                                1
                                                                            ? workUpcoming[index]['task_id'].toString()
                                                                            : personalUpcoming[index]['task_id'].toString()
                                                                  };

                                                                  print(
                                                                      'SELECTIONNNNNN: $_selection');

                                                                  Future.delayed(const Duration(seconds: 1)).then(
                                                                      (value) => Provider.of<TodaysTaskList>(context, listen: false).changeTaskStatus(
                                                                          'upcoming',
                                                                          _selection,
                                                                          _data,
                                                                          context)
                                                                      //     .then(
                                                                      //         (value) {
                                                                      //   setState(
                                                                      //       () {
                                                                      //     _selection == 0
                                                                      //         ? toDoList['upcoming'].removeAt(index)
                                                                      //         : _selection == 1
                                                                      //             ? workUpcoming.removeAt(index)
                                                                      //             : personalUpcoming.removeAt(index);
                                                                      //   });
                                                                      // })
                                                                      );

                                                                  // Provider.of<ToDoViewModel>(context,
                                                                  //         listen: false)
                                                                  //     .postToDoList(_data);
                                                                },
                                                                size: 23,
                                                                checkedColor:
                                                                    Colors.grey,
                                                                uncheckedColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.025,
                                                                top: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.02,
                                                              ),
                                                              child: Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        // value.nextModelList.data!
                                                                        //     .today![index].taskName
                                                                        //     .toString(),
                                                                        _selection ==
                                                                                0
                                                                            ? toDoList['upcoming'][index]['task_title'] ??
                                                                                'No Title'
                                                                            : _selection == 1
                                                                                ? workUpcoming[index]['task_title'] ?? 'No Title'
                                                                                : personalUpcoming[index]['task_title'] ?? 'No Title',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!,
                                                                      ),
                                                                    ),
                                                                    FittedBox(
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      child:
                                                                          Text(
                                                                        _selection ==
                                                                                0
                                                                            ? toDoList['upcoming'][index]['task_date']
                                                                            : _selection == 1
                                                                                ? workUpcoming[index]['task_date']
                                                                                : personalUpcoming[index]['task_date'],

                                                                        // value.nextModelList.data!
                                                                        //     .today![index].taskDate
                                                                        //     .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.amber),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          itemCount: _selection == 0
                                              ? toDoList['upcoming'].length
                                              : _selection == 1
                                                  ? workUpcoming.length
                                                  : personalUpcoming.length
                                          // value.nextModelList.data!.today!.length,
                                          ),
                        ),
                      ),
                    ],
                    contentBackgroundColor:
                        Theme.of(context).colorScheme.secondary,
                    //headerBackgroundColor: Colors.black,
                    contentBorderColor: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.only(right: SizeVariables.getWidth(context) * 0.6),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  primary: Colors.black,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, RouteNames.taskcomplete,);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TaskComplete()));
                },
                child: Container(
                  width: SizeVariables.getWidth(context) * 0.26,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Completed List",
                      style: TextStyle(
                        //color: Colors.blue,
                        fontSize: 16,
                        //fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     backgroundColor: Colors.black,
    //     title: Row(
    //       children: [
    //         widget.flag == true
    //             ? InkWell(
    //                 onTap: () => Navigator.of(context).pop(),
    //                 child: SvgPicture.asset(
    //                   "assets/icons/back button.svg",
    //                 ),
    //               )
    //             : Container(),
    //         SizedBox(width: SizeVariables.getWidth(context) * 0.02),
    //         const Text('Task List', style: TextStyle(fontSize: 25))
    //       ],
    //     ),
    //   ),
    //   backgroundColor: Colors.black,
    //   floatingActionButton: Container(
    //     margin:
    //         EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.08),
    //     child: RippleAnimation(
    //       repeat: true,
    //       color: Colors.grey,
    //       minRadius: 33,
    //       ripplesCount: 2,
    //       child: FloatingActionButton(
    //         backgroundColor: Color.fromARGB(255, 70, 69, 69),
    //         onPressed: openDialog,
    //         child: Icon(Icons.add),
    //       ),
    //     ),
    //   ),
    //   body: isLoading
    //       ? const Center(
    //           child: CircularProgressIndicator(),
    //         )
    //       : Container(
    //           padding: EdgeInsets.only(
    //             left: SizeVariables.getWidth(context) * 0.025,
    //             right: SizeVariables.getWidth(context) * 0.025,
    //           ),
    //           // color: Colors.red,
    //           child: ListView(
    //             children: [
    //               // TaskHeader(),
    //               // SizedBox(
    //               //   height: SizeVariables.getHeight(context) * 0.03,
    //               // ),
    //               // TaskContainer(),
    //               Column(
    //                 children: [
    //                   Container(
    //                     // height: SizeVariables.getHeight(context)*0.7,
    //                     // color: Colors.red,
    //                     child: Accordion(
    //                       // maxOpenSections: 2,
    //                       headerBackgroundColorOpened: Colors.black54,
    //                       scaleWhenAnimating: true,
    //                       openAndCloseAnimation: true,
    //                       headerPadding: const EdgeInsets.symmetric(
    //                           vertical: 7, horizontal: 15),
    //                       sectionOpeningHapticFeedback:
    //                           SectionHapticFeedback.heavy,
    //                       sectionClosingHapticFeedback:
    //                           SectionHapticFeedback.light,
    //                       // ignore: sort_child_properties_last
    //                       children: [
    //                         AccordionSection(
    //                           isOpen: true,
    //                           // leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
    //                           header: Text('Pending',
    //                               style: Theme.of(context).textTheme.bodyText2),
    //                           // contentBorderColor:Colors.amber,
    //                           // headerBackgroundColorOpened: Colors.amber,
    //                           content: Container(
    //                             // color: Colors.green,
    //                             height: toDoList['previous'].length > 3
    //                                 ? SizeVariables.getHeight(context) * 0.4
    //                                 : null,
    //                             child: toDoList['previous'].isEmpty
    //                                 ? const Center(
    //                                     child: Text('No Pending Tasks'),
    //                                   )
    //                                 : ListView.builder(
    //                                     shrinkWrap: true,
    //                                     itemBuilder: (context, index) =>
    //                                         Container(
    //                                       margin: EdgeInsets.only(
    //                                           bottom: SizeVariables.getHeight(
    //                                                   context) *
    //                                               0.02),
    //                                       child: ContainerStyle(
    //                                         height: SizeVariables.getHeight(
    //                                                 context) *
    //                                             0.08,
    //                                         child: Row(
    //                                           children: [
    //                                             Padding(
    //                                               padding: EdgeInsets.only(
    //                                                 left:
    //                                                     SizeVariables.getWidth(
    //                                                             context) *
    //                                                         0.03,
    //                                                 // top: SizeVariables.getHeight(context)*0.03,
    //                                               ),
    //                                               child: RoundCheckBox(
    //                                                 onTap: (selected) {
    //                                                   Map<String, dynamic>
    //                                                       _data = {
    //                                                     'id':
    //                                                         toDoList['previous']
    //                                                                     [index]
    //                                                                 ['task_id']
    //                                                             .toString()
    //                                                   };
    //                                                   Future.delayed(
    //                                                           const Duration(
    //                                                               seconds: 1))
    //                                                       .then((value) =>
    //                                                           Provider.of<TasksViewModel>(
    //                                                                   context,
    //                                                                   listen:
    //                                                                       false)
    //                                                               .changeTaskStatus(
    //                                                                   _data,
    //                                                                   context)
    //                                                               .then(
    //                                                                   (value) {
    //                                                             setState(() {
    //                                                               toDoList[
    //                                                                       'previous']
    //                                                                   .removeAt(
    //                                                                       index);
    //                                                             });
    //                                                           }));

    //                                                   // ChangeNotifierProvider<
    //                                                   //     PreviousTaskList>(
    //                                                   //   create: (context) =>
    //                                                   //       previousTaskList,
    //                                                   // );
    //                                                   // previousTaskList.getPreviousList();
    //                                                 },
    //                                                 size: 23,
    //                                                 // uncheckedColor: Colors.yellow,
    //                                                 checkedColor: Colors.grey,
    //                                               ),
    //                                             ),
    //                                             Padding(
    //                                               padding: EdgeInsets.only(
    //                                                 left:
    //                                                     SizeVariables.getWidth(
    //                                                             context) *
    //                                                         0.025,
    //                                                 top: SizeVariables.getWidth(
    //                                                         context) *
    //                                                     0.04,
    //                                               ),
    //                                               child: Container(
    //                                                 child: Column(
    //                                                   crossAxisAlignment:
    //                                                       CrossAxisAlignment
    //                                                           .start,
    //                                                   children: [
    //                                                     Container(
    //                                                       // fit: BoxFit.contain,
    //                                                       child: Text(
    //                                                         toDoList['previous']
    //                                                                 [index]
    //                                                             ['task_name'],
    //                                                         // value
    //                                                         //     .previousModelList
    //                                                         //     .data!
    //                                                         //     .today![index]
    //                                                         //     .taskName
    //                                                         //     .toString(),
    //                                                         overflow:
    //                                                             TextOverflow
    //                                                                 .ellipsis,
    //                                                         style: Theme.of(
    //                                                                 context)
    //                                                             .textTheme
    //                                                             .bodyText1,
    //                                                       ),
    //                                                     ),
    //                                                     Container(
    //                                                       padding: EdgeInsets.only(
    //                                                           right: SizeVariables
    //                                                                   .getWidth(
    //                                                                       context) *
    //                                                               0.25),
    //                                                       child: Text(
    //                                                         toDoList['previous']
    //                                                                 [index]
    //                                                             ['task_date'],
    //                                                         // value
    //                                                         //     .previousModelList
    //                                                         //     .data!
    //                                                         //     .today![index]
    //                                                         //     .taskDate
    //                                                         //     .toString(),
    //                                                         style:
    //                                                             const TextStyle(
    //                                                                 color: Colors
    //                                                                     .red),
    //                                                       ),
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     itemCount: toDoList['previous'].length,
    //                                     // value.previousModelList.data!
    //                                     //     .today!.length,
    //                                   ),
    //                           ),
    //                         ),
    //                         AccordionSection(
    //                           isOpen: false,
    //                           // leftIcon: const Icon(Icons.food_bank, color: Colors.white),
    //                           header: Text('Current',
    //                               style: Theme.of(context).textTheme.bodyText2),
    //                           content: Container(
    //                               margin: EdgeInsets.only(
    //                                   bottom: SizeVariables.getHeight(context) *
    //                                       0.02),
    //                               // height: SizeVariables.getHeight(context) * 0.4,
    //                               child: Container(
    //                                 height: toDoList['today'].length > 3
    //                                     ? SizeVariables.getHeight(context) * 0.4
    //                                     : null,
    //                                 child: toDoList['today'].isEmpty
    //                                     ? const Center(
    //                                         child: Text('No Current Tasks'),
    //                                       )
    //                                     : ListView.builder(
    //                                         shrinkWrap: true,
    //                                         itemBuilder:
    //                                             (context, index) => Container(
    //                                                   margin: EdgeInsets.only(
    //                                                       bottom: SizeVariables
    //                                                               .getHeight(
    //                                                                   context) *
    //                                                           0.02),
    //                                                   child: ContainerStyle(
    //                                                     height: SizeVariables
    //                                                             .getHeight(
    //                                                                 context) *
    //                                                         0.08,
    //                                                     child: Row(
    //                                                       children: [
    //                                                         Padding(
    //                                                           padding:
    //                                                               EdgeInsets
    //                                                                   .only(
    //                                                             left: SizeVariables
    //                                                                     .getWidth(
    //                                                                         context) *
    //                                                                 0.03,
    //                                                             // top: SizeVariables.getHeight(context)*0.03,
    //                                                           ),
    //                                                           child:
    //                                                               RoundCheckBox(
    //                                                             onTap:
    //                                                                 (selected) {
    //                                                               Map<String,
    //                                                                       dynamic>
    //                                                                   _data = {
    //                                                                 'id': toDoList['today'][index]
    //                                                                         [
    //                                                                         'task_id']
    //                                                                     .toString()
    //                                                               };

    //                                                               print(
    //                                                                   'Current Task: $_data');

    //                                                               Future.delayed(const Duration(seconds: 1)).then((value) =>
    //                                                                   Provider.of<TasksViewModel>(
    //                                                                           context,
    //                                                                           listen:
    //                                                                               false)
    //                                                                       .changeTaskStatus(
    //                                                                           _data,
    //                                                                           context)
    //                                                                       .then(
    //                                                                           (value) {
    //                                                                     setState(
    //                                                                         () {
    //                                                                       toDoList['today']
    //                                                                           .removeAt(index);
    //                                                                     });
    //                                                                   }));

    //                                                               // Provider.of<ToDoViewModel>(
    //                                                               //         context,
    //                                                               //         listen: false)
    //                                                               //     .postToDoList(_data);
    //                                                               // todaysTaskList.getTodayList();
    //                                                             },
    //                                                             size: 23,
    //                                                             // uncheckedColor: Colors.yellow,
    //                                                             checkedColor:
    //                                                                 Colors.grey,
    //                                                           ),
    //                                                         ),
    //                                                         Column(
    //                                                           children: [
    //                                                             Padding(
    //                                                               padding: EdgeInsets.only(
    //                                                                   left: SizeVariables.getHeight(
    //                                                                           context) *
    //                                                                       0.02,
    //                                                                   top: SizeVariables.getHeight(
    //                                                                           context) *
    //                                                                       0.028),
    //                                                               child:
    //                                                                   FittedBox(
    //                                                                 fit: BoxFit
    //                                                                     .contain,
    //                                                                 child: Text(
    //                                                                   // value
    //                                                                   //     .todayModelList
    //                                                                   //     .data!
    //                                                                   //     .today![
    //                                                                   //         index]
    //                                                                   //     .taskName
    //                                                                   //     .toString(),
    //                                                                   toDoList['today'][index]
    //                                                                           [
    //                                                                           'task_name']
    //                                                                       .toString(),
    //                                                                   overflow:
    //                                                                       TextOverflow
    //                                                                           .ellipsis,
    //                                                                   style: Theme.of(
    //                                                                           context)
    //                                                                       .textTheme
    //                                                                       .bodyText1,
    //                                                                 ),
    //                                                               ),
    //                                                             ),
    //                                                           ],
    //                                                         ),
    //                                                       ],
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //                                         itemCount: toDoList['today'].length
    //                                         // value.todayModelList.data!
    //                                         //     .today!.length
    //                                         ),
    //                               )),
    //                         ),
    //                         AccordionSection(
    //                           isOpen: false,
    //                           // leftIcon: const Icon(Icons.contact_page, color: Colors.white),
    //                           header: Text('Upcoming',
    //                               style: Theme.of(context).textTheme.bodyText2),

    //                           content: Container(
    //                             height: toDoList['upcoming'].length > 3
    //                                 ? SizeVariables.getHeight(context) * 0.4
    //                                 : null,
    //                             child: toDoList['upcoming'].isEmpty
    //                                 ? const Center(
    //                                     child: Text('No Upcoming Tasks'),
    //                                   )
    //                                 : ListView.builder(
    //                                     shrinkWrap: true,
    //                                     itemBuilder: (context, index) =>
    //                                         Container(
    //                                           margin: EdgeInsets.only(
    //                                               bottom:
    //                                                   SizeVariables.getHeight(
    //                                                           context) *
    //                                                       0.02),
    //                                           child: ContainerStyle(
    //                                             height: SizeVariables.getHeight(
    //                                                     context) *
    //                                                 0.08,
    //                                             child: Row(
    //                                               children: [
    //                                                 Padding(
    //                                                   padding: EdgeInsets.only(
    //                                                     left: SizeVariables
    //                                                             .getWidth(
    //                                                                 context) *
    //                                                         0.03,
    //                                                     // top: SizeVariables.getHeight(context)*0.03,
    //                                                   ),
    //                                                   child: RoundCheckBox(
    //                                                     onTap: (selected) {
    //                                                       Map<String, dynamic>
    //                                                           _data = {
    //                                                         'id': toDoList['upcoming']
    //                                                                     [index]
    //                                                                 ['task_id']
    //                                                             .toString()
    //                                                       };
    //                                                       Future.delayed(
    //                                                               const Duration(
    //                                                                   seconds:
    //                                                                       1))
    //                                                           .then((value) =>
    //                                                               Provider.of<TasksViewModel>(
    //                                                                       context,
    //                                                                       listen:
    //                                                                           false)
    //                                                                   .changeTaskStatus(
    //                                                                       _data,
    //                                                                       context)
    //                                                                   .then(
    //                                                                       (value) {
    //                                                                 setState(
    //                                                                     () {
    //                                                                   toDoList[
    //                                                                           'upcoming']
    //                                                                       .removeAt(
    //                                                                           index);
    //                                                                 });
    //                                                               }));

    //                                                       // Provider.of<ToDoViewModel>(context,
    //                                                       //         listen: false)
    //                                                       //     .postToDoList(_data);
    //                                                     },
    //                                                     size: 23,
    //                                                     // uncheckedColor: Colors.yellow,
    //                                                     checkedColor:
    //                                                         Colors.grey,
    //                                                   ),
    //                                                 ),
    //                                                 Padding(
    //                                                   padding: EdgeInsets.only(
    //                                                     left: SizeVariables
    //                                                             .getWidth(
    //                                                                 context) *
    //                                                         0.025,
    //                                                     top: SizeVariables
    //                                                             .getHeight(
    //                                                                 context) *
    //                                                         0.02,
    //                                                   ),
    //                                                   child: Container(
    //                                                     child: Column(
    //                                                       crossAxisAlignment:
    //                                                           CrossAxisAlignment
    //                                                               .start,
    //                                                       children: [
    //                                                         FittedBox(
    //                                                           fit: BoxFit
    //                                                               .contain,
    //                                                           child: Text(
    //                                                             // value.nextModelList.data!
    //                                                             //     .today![index].taskName
    //                                                             //     .toString(),
    //                                                             toDoList['upcoming']
    //                                                                     [index][
    //                                                                 'task_name'],
    //                                                             overflow:
    //                                                                 TextOverflow
    //                                                                     .ellipsis,
    //                                                             style: Theme.of(
    //                                                                     context)
    //                                                                 .textTheme
    //                                                                 .bodyText1,
    //                                                           ),
    //                                                         ),
    //                                                         FittedBox(
    //                                                           fit: BoxFit
    //                                                               .contain,
    //                                                           child: Text(
    //                                                             toDoList['upcoming']
    //                                                                     [index][
    //                                                                 'task_date'],

    //                                                             // value.nextModelList.data!
    //                                                             //     .today![index].taskDate
    //                                                             //     .toString(),
    //                                                             style: const TextStyle(
    //                                                                 color: Colors
    //                                                                     .amber),
    //                                                           ),
    //                                                         ),
    //                                                       ],
    //                                                     ),
    //                                                   ),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                         ),
    //                                     itemCount: toDoList['upcoming'].length
    //                                     // value.nextModelList.data!.today!.length,
    //                                     ),
    //                           ),
    //                         ),
    //                       ],
    //                       contentBackgroundColor: Colors.black,
    //                       headerBackgroundColor: Colors.black,
    //                       contentBorderColor: Colors.black,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                     right: SizeVariables.getWidth(context) * 0.6),
    //                 child: TextButton(
    //                   onPressed: () {
    //                     // Navigator.pushNamed(context, RouteNames.taskcomplete,);
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => TaskComplete()));
    //                   },
    //                   child: const Text(
    //                     "Completed List",
    //                     style: TextStyle(
    //                       color: Colors.blue,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.w800,
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    // );
  }

  openDialog(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        isScrollControlled: true,
        // backgroundColor: Colors.grey[800],
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        // backgroundColor: Colors.red,
        context: context,
        builder: (context) {
          // bool _show = true;
          int? _radioValue = 0;
          /* var sheetController = showBottomSheet(
        context: context,
        builder: (context) => BottomSheetWidget());*/
          void _handleRadioValueChange(value) {
            // setState(() {
            //   _radioValue = value;
            // });
            // print("first" +
            //     value.toString() +
            //     "radiovalue" +
            //     _radioValue.toString());

            print('RADIO VALUEEEEEEEE: $value');
          }

          final themeProvider = Provider.of<ThemeProvider>(context);
          return StatefulBuilder(builder: (context, setState) {
            // final height = MediaQuery.of(context).size.height;
            // final width = MediaQuery.of(context).size.width;
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _key1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: TextFormField(
                            controller: _taskTitle,
                            cursorColor: Colors.white,
                            // controller: taskController,
                            // maxLines: 5,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // border: new OutlineInputBorder(
                              //   borderSide: new BorderSide(color: Colors.amber),
                              // ),
                              label: Text(
                                "Task Name",
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              //border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.025,
                            // top: SizeVariables.getWidth(context) * 0.02,
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
                              top: SizeVariables.getWidth(context) * 0.04),
                          child: Container(
                            decoration: BoxDecoration(
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
                              height: MediaQuery.of(context).size.height > 750
                                  ? 16.h
                                  : MediaQuery.of(context).size.height < 650
                                      ? 19.h
                                      : 16.h,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: taskController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    // border: OutlineInputBorder(
                                    //   borderSide: BorderSide(color: Colors.grey),
                                    // ),
                                    // fillColor: Colors.grey,
                                  ),
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 5,
                                  validator: (value) {
                                    if (value!.isEmpty || value == '') {
                                      return 'Please enter Task';
                                    } else {
                                      body = value;
                                      return null;
                                    }
                                  },
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Container(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              _dateTime == null
                                  ? DateFormat('dd-MMM-yyyy')
                                      .format(DateTime.now())
                                  : DateFormat('dd-MMM-yyyy').format(
                                      DateTime.parse(_dateTime.toString())),
                              style: Theme.of(context).textTheme.bodyText1!,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () async {
                            showDatePicker(
                                    builder: (context, child) => Theme(
                                          data: ThemeData().copyWith(
                                            colorScheme: const ColorScheme.dark(
                                              primary: Color(0xffF59F23),
                                              surface: Colors.black,
                                              onSurface: Colors.white,
                                            ),
                                            dialogBackgroundColor:
                                                Color.fromARGB(255, 91, 91, 91),
                                          ),
                                          child: child!,
                                        ),
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)))
                                .then((date) {
                              setState(() {
                                _dateTime = date;
                                diff = DateTime.parse(_dateTime.toString())
                                        .difference(DateTime.parse(
                                            DateTime.now().toString()))
                                        .inDays +
                                    1;
                              });
                              if (kDebugMode) {
                                print('DIFFERENCE: $diff');
                                print('DATE TIMEEEEEE: $_dateTime');
                              }
                            });
                          },
                          child: Container(
                            child: const Icon(
                              Icons.calendar_month,
                              color: Color(0xffF59F23),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    // color: Colors.amber,
                    height: 30,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          fillColor: (themeProvider.darkTheme)
                              ? MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.black;
                                  }
                                  return Colors.white;
                                })
                              : MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                  if (states.contains(MaterialState.disabled)) {
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
                            print("radiofirst" +
                                value.toString() +
                                "radiovalue" +
                                _radioValue.toString());
                            _handleRadioValueChange(_radioValue);
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
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.black;
                                  }
                                  return Colors.white;
                                })
                              : MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                  if (states.contains(MaterialState.disabled)) {
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
                            print("radiosecond " +
                                value.toString() +
                                "radiovalue " +
                                _radioValue.toString());
                            _handleRadioValueChange(_radioValue);
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

                    // child: Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       height: double.infinity,
                    //       // color: Colors.green,
                    //       child: Row(
                    //         // mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           InkWell(
                    //             onTap: () => _selectedOption('work', setState),
                    //             child: Container(
                    //               width: 18,
                    //               height: 18,
                    //               padding: const EdgeInsets.all(2),
                    //               decoration: BoxDecoration(
                    //                   border: Border.all(color: Colors.white),
                    //                   shape: BoxShape.circle),
                    //               child: workSelected == false
                    //                   ? Container()
                    //                   : Container(
                    //                       width: 8,
                    //                       height: 8,
                    //                       decoration: const BoxDecoration(
                    //                           color: Colors.white,
                    //                           shape: BoxShape.circle),
                    //                     ),
                    //             ),
                    //           ),
                    //           SizedBox(
                    //               width:
                    //                   SizeVariables.getWidth(context) * 0.02),
                    //           InkWell(
                    //             onTap: () => _selectedOption('work', setState),
                    //             child: Row(
                    //               children: [
                    //                 Icon(
                    //                   Icons.work_outline,
                    //                   color: Colors.white,
                    //                 ),
                    //                 SizedBox(
                    //                     width: SizeVariables.getWidth(context) *
                    //                         0.01),
                    //                 Text(
                    //                   'Work',
                    //                   style:
                    //                       Theme.of(context).textTheme.bodyText1,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     SizedBox(width: SizeVariables.getWidth(context) * 0.04),
                    //     InkWell(
                    //       child: Container(
                    //         height: double.infinity,
                    //         // color: Colors.blue,

                    //         // child: Row(
                    //         //   children: [
                    //         //     InkWell(
                    //         //       onTap: () =>
                    //         //           _selectedOption('personal', setState),
                    //         //       child: Container(
                    //         //         width: 18,
                    //         //         height: 18,
                    //         //         padding: const EdgeInsets.all(2),
                    //         //         decoration: BoxDecoration(
                    //         //             border: Border.all(color: Colors.white),
                    //         //             shape: BoxShape.circle),
                    //         //         child: personalSelected == false
                    //         //             ? Container()
                    //         //             : Container(
                    //         //                 width: 8,
                    //         //                 height: 8,
                    //         //                 decoration: const BoxDecoration(
                    //         //                     color: Colors.white,
                    //         //                     shape: BoxShape.circle),
                    //         //               ),
                    //         //       ),
                    //         //     ),
                    //         //     SizedBox(
                    //         //         width:
                    //         //             SizeVariables.getWidth(context) * 0.02),
                    //         //     InkWell(
                    //         //       onTap: () =>
                    //         //           _selectedOption('personal', setState),
                    //         //       child: Row(
                    //         //         children: [
                    //         //           Icon(
                    //         //             Icons.person,
                    //         //             color: Colors.white,
                    //         //           ),
                    //         //           SizedBox(
                    //         //               width:
                    //         //                   SizeVariables.getWidth(context) *
                    //         //                       0.01),
                    //         //           Text(
                    //         //             'Personal',
                    //         //             style: Theme.of(context)
                    //         //                 .textTheme
                    //         //                 .bodyText1,
                    //         //           ),
                    //         //         ],
                    //         //       ),
                    //         //     ),
                    //         //   ],
                    //         // ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  const SizedBox(
                    height: 65,
                  ),
                  Container(
                    width: double.infinity,
                    child: Container(
                      width: SizeVariables.getWidth(context) * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(168, 123, 121, 121),
                            padding: EdgeInsets.all(15)),
                        onPressed: () async {
                          Map<String, dynamic> _data = {
                            'category': _radioValue == 0 ? 'work' : 'personal',
                            'task_title': _taskTitle.text,
                            'task_name': taskController.text,
                            'task_date': _dateTime == null
                                ? dateFormat.format(
                                    DateTime.parse(DateTime.now().toString()))
                                : dateFormat.format(_dateTime!).toString()
                          };

                          print(_data);

                          FocusScope.of(context).unfocus();

                          // if (_key.currentState!.validate()) {
                          //   setState(() {
                          //     isLoading = true;
                          //   });
                          Provider.of<TodaysTaskList>(context, listen: false)
                              .postTodaysTask(
                                  _data,
                                  diff == null || _dateTime == null
                                      ? 0
                                      : DateTime.parse(_dateTime.toString())
                                                  .difference(DateTime.parse(
                                                      DateTime.now()
                                                          .toString()))
                                                  .inDays <
                                              0
                                          ? -1
                                          : diff!,
                                  context)
                              .then((value) {
                            setState(() {
                              _taskTitle.clear();
                              taskController.clear();
                              _dateTime = null;
                              isLoading = false;
                            });
                          });
                        },
                        child: Text(
                          'ADD',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  // Future<dynamic> openDialog() => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         backgroundColor: Color.fromARGB(255, 87, 83, 83),
  //         content: Form(
  //           key: _key,
  //           child: TextFormField(
  //             cursorColor: Colors.white,return
  //             controller: taskController,
  //             maxLines: 5,
  //             style: Theme.of(context).textTheme.bodyText1,
  //             decoration: InputDecoration(
  //               label: Text(
  //                 "Task Add",
  //                 style: Theme.of(context)
  //                     .textTheme
  //                     .bodyText1!
  //                     .copyWith(color: Colors.white),
  //               ),
  //               labelStyle: Theme.of(context).textTheme.bodyText1,
  //               border: InputBorder.none,
  //             ),
  //             validator: (value) {
  //               if (value!.isEmpty || value == '') {
  //                 return 'Please Enter Task';
  //               } else {
  //                 input = value;
  //               }
  //             },
  //           ),
  //         ),
  //         actions: [
  //           Padding(
  //             padding: EdgeInsets.only(
  //               right: SizeVariables.getWidth(context) * 0.15,
  //             ),
  //             child: Container(
  //               child: FittedBox(
  //                 fit: BoxFit.contain,
  //                 child: Text(
  //                   _dateTime == null
  //                       ? DateFormat('dd-MMM-yyyy').format(DateTime.now())
  //                       : DateFormat('dd-MMM-yyyy')
  //                           .format(DateTime.parse(_dateTime.toString())),
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .bodyText1!
  //                       .copyWith(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(
  //                 right: SizeVariables.getWidth(context) * 0.03),
  //             child: InkWell(
  //               onTap: () async {
  //                 showDatePicker(
  //                         builder: (context, child) => Theme(
  //                               data: ThemeData().copyWith(
  //                                 colorScheme: const ColorScheme.dark(
  //                                   primary: Color(0xffF59F23),
  //                                   surface: Colors.black,
  //                                   onSurface: Colors.white,
  //                                 ),
  //                                 dialogBackgroundColor:
  //                                     Color.fromARGB(255, 91, 91, 91),
  //                               ),
  //                               child: child!,
  //                             ),
  //                         context: context,
  //                         initialDate: DateTime.now(),
  //                         firstDate: DateTime(2010),
  //                         lastDate:
  //                             DateTime.now().add(const Duration(days: 365)))
  //                     .then((date) {
  //                   setState(() {
  //                     _dateTime = date;
  //                     diff = DateTime.parse(_dateTime.toString())
  //                             .difference(
  //                                 DateTime.parse(DateTime.now().toString()))
  //                             .inDays +
  //                         1;
  //                   });
  //                   if (kDebugMode) {
  //                     print('DIFFERENCE: $diff');
  //                     print('DATE TIMEEEEEE: $_dateTime');
  //                   }
  //                 });
  //               },
  //               child: const Icon(
  //                 Icons.calendar_month,
  //                 color: Color(0xffF59F23),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                 primary: Color.fromARGB(168, 123, 121, 121),
  //               ),
  //               onPressed: () async {
  //                 Map<String, dynamic> _data = {
  //                   'task_name': taskController.text,
  //                   'task_date': _dateTime == null
  //                       ? dateFormat
  //                           .format(DateTime.parse(DateTime.now().toString()))
  //                       : dateFormat.format(_dateTime!).toString()
  //                 };

  //                 print(_data);

  //                 FocusScope.of(context).unfocus();

  //                 if (_key.currentState!.validate()) {
  //                   setState(() {
  //                     isLoading = true;
  //                   });
  //                   Provider.of<TodaysTaskList>(context, listen: false)
  //                       .postTodaysTask(
  //                           _data,
  //                           diff == null || _dateTime == null
  //                               ? 0
  //                               : DateTime.parse(_dateTime.toString())
  //                                           .difference(DateTime.parse(
  //                                               DateTime.now().toString()))
  //                                           .inDays <
  //                                       0
  //                                   ? -1
  //                                   : diff!,
  //                           context)
  //                       .then((value) {
  //                     setState(() {
  //                       taskController.clear();
  //                       _dateTime = null;
  //                       isLoading = false;
  //                     });
  //                     Navigator.of(context).pop();
  //                   });
  //                 }
  //               },
  //               child: Text('ADD',
  //                   style: Theme.of(context).textTheme.bodyText2?.copyWith(
  //                         color: Color(0xffF59F23),
  //                       )),
  //             ),
  //             decoration: BoxDecoration(
  //               color: Color.fromARGB(168, 123, 121, 121),
  //               shape: BoxShape.rectangle,
  //               borderRadius: BorderRadius.circular(10),
  //               boxShadow: const [
  //                 BoxShadow(
  //                   color: Color.fromARGB(255, 74, 74, 70),
  //                   blurRadius: 2,
  //                   offset: Offset(0, 0),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  void add() {
    Navigator.of(context).pop();
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

  void openDialogBox() {
    ClaimzHistoryViewModel searchUserData = ClaimzHistoryViewModel();
    Map data = {
      "keyword": "",
    };
    searchUserData.postSearchUser(context, data);
    TextEditingController _searchUser = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 99, 97, 97),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Assigned to',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        content: Container(
          // color: Colors.black,
          height: SizeVariables.getHeight(context) * 0.58,
          width: SizeVariables.getWidth(context) * 0.8,
          child: Column(
            children: [
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                child: TextField(
                  onSubmitted: (value) {
                    Map data = {
                      "keyword": value.toString(),
                    };
                    searchUserData.postSearchUser(context, data);
                  },
                  textInputAction: TextInputAction.search,
                  controller: _searchUser,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.grey,
                    ),
                    hintText: 'Search',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey),
                    filled: true,
                    fillColor: Color.fromARGB(255, 76, 75, 75),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              ChangeNotifierProvider<ClaimzHistoryViewModel>(
                create: (context) => searchUserData,
                child: Consumer<ClaimzHistoryViewModel>(
                  builder: (context, value, child) {
                    switch (value.searchUserRecord.status) {
                      case Status.ERROR:
                        return Center(
                          child:
                              Text(value.searchUserRecord.message.toString()),
                        );
                      // case Status.LOADING:
                      //   return Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        return Container(
                          height: SizeVariables.getHeight(context) * 0.43,
                          width: SizeVariables.getWidth(context) * 0.6,
                          // color: Colors.red,
                          child: ListView(
                            children: [
                              Container(
                                height: 400,
                                // width: SizeVariables.getWidth(context) * 0.4,
                                // color: Colors.amber,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      value.searchUserRecord.data!.data!.length,
                                  itemBuilder: (context, index) =>
                                      ContainerStyle(
                                    height:
                                        SizeVariables.getHeight(context) * 0.07,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: value
                                                              .searchUserRecord
                                                              .data!
                                                              .data![index]!
                                                              .profilePhoto ==
                                                          '${AppUrl.baseUrl}/profile_photo/' ||
                                                      value
                                                              .searchUserRecord
                                                              .data!
                                                              .data![index]!
                                                              .profilePhoto ==
                                                          null
                                                  ? CircleAvatar(
                                                      radius: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.07,
                                                      backgroundColor:
                                                          Colors.green,
                                                      backgroundImage:
                                                          const AssetImage(
                                                              'assets/img/profilePic.jpg'),
                                                      // child: const Icon(Icons.account_box, color: Colors.white),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: value
                                                          .searchUserRecord
                                                          .data!
                                                          .data![index]!
                                                          .profilePhoto,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        height: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.07,
                                                        width: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.07,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .contain)),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Container(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.06,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor:
                                                                    Colors.grey[
                                                                        400]!,
                                                                highlightColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        120,
                                                                        120,
                                                                        120),
                                                                child:
                                                                    const CircleAvatar(
                                                                  radius: 2,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  child: Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .camera_alt_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20),
                                                                  ),
                                                                ),
                                                              )),
                                                    ),
                                            ),
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                value.searchUserRecord.data!
                                                    .data![index].empName
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                    return Container();
                  },
                  // child: Container(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
