import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
import 'package:claimz/views/screens/taskBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../config/mediaQuery.dart';

class TaskList extends StatefulWidget {
  final bool flag;

  @override
  State<TaskList> createState() => _TaskListState();

  TaskList(this.flag);
}

class _TaskListState extends State<TaskList> {
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
                ? const Color.fromARGB(255, 70, 69, 69)
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: _selection == 0
                            ? Theme.of(context).colorScheme.onPrimary
                            : Color.fromARGB(255, 27, 26, 26),
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.08,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              Icon(
                                Icons.assignment_outlined,
                                color: _selection == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              Text(
                                'All',
                                style: TextStyle(
                                  color: _selection == 0
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
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

                          completedLoading = true;
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: _selection == 1
                            ? Theme.of(context).colorScheme.onPrimary
                            : Color.fromARGB(255, 27, 26, 26),
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.1,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_outline,
                                color: _selection == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              Container(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Work',
                                    style: TextStyle(
                                      color: _selection == 1
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          completedLoading = true;
                        });
                        print('SELECTION: $_selection');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: _selection == 2
                            ? Theme.of(context).colorScheme.onPrimary
                            : Color.fromARGB(255, 27, 26, 26),
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.15,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: _selection == 2
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              Container(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Personal',
                                    style: TextStyle(
                                      color: _selection == 2
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

                          completedLoading = true;
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: _selection == 3
                            ? Theme.of(context).colorScheme.onPrimary
                            : Color.fromARGB(255, 27, 26, 26),
                      ),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.2,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline_outlined,
                                color: _selection == 3
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  color: _selection == 3
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selection = 3;
                          Map data = {
                            "month": "",
                            "type": "",
                            "year": "",
                            "user_id": "",
                            "all": "1" //self
                          };
                        });
                        Provider.of<TodaysTaskList>(context, listen: false)
                            .getTodaysTasks(1)
                            .then((_) {
                          setState(() {
                            completedLoading = false;
                          });
                        });
                        print('SELECTION: $_selection');
                        // Navigator.pushNamed(context, RouteNames.taskcomplete);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.01,
            ),
            _selection == 3
                ? Container(
                    width: double.infinity,
                    height: SizeVariables.getHeight(context) * 0.7,
                    // color: Colors.red,
                    child: completedLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  // isScrollControlled: true,
                                  // useSafeArea: true,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,

                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30),
                                    ),
                                  ),
                                  builder: (ctx) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Task Name:  ${toDoList['completed'][index]['task_title'] ?? 'No Title'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 16,
                                              ),
                                        ),
                                        const SizedBox(height: 14),
                                        Text(
                                          'Description:  ${toDoList['completed'][index]['task_name'] ?? 'No Description'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 14),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Date: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                  ),
                                            ),
                                            Text(
                                              toDoList['completed'][index]
                                                  ['task_date'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Category: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 16,
                                                  ),
                                            ),
                                            Container(
                                              child: _selection == 0
                                                  ? Icon(
                                                      toDoList['previous']
                                                                      [index][
                                                                  'category'] ==
                                                              'work'
                                                          ? Icons.work_outline
                                                          : Icons
                                                              .person_outline,
                                                      color: const Color(
                                                          0xffF59F23),
                                                      size: 30)
                                                  : _selection == 1
                                                      ? const Icon(
                                                          Icons.work_outline,
                                                          color:
                                                              Color(0xffF59F23),
                                                          size: 30,
                                                        )
                                                      : _selection == 2
                                                          ? const Icon(
                                                              Icons
                                                                  .person_outline,
                                                              color: Color(
                                                                  0xffF59F23),
                                                              size: 30,
                                                            )
                                                          : null,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        role == 0
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Assign by: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  Text(
                                                    'Self',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      SizeVariables.getHeight(context) * 0.02,
                                ),
                                child: ContainerStyle(
                                  height:
                                      SizeVariables.getHeight(context) * 0.1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: SizeVariables.getWidth(
                                                        context) *
                                                    0.025,
                                                top: SizeVariables.getWidth(
                                                        context) *
                                                    0.04,
                                              ),
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      child: Text(
                                                        toDoList['completed']
                                                                    [index][
                                                                'task_title'] ??
                                                            'No Title Given',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 18,
                                                            ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          toDoList['completed']
                                                                  [index]
                                                              ['task_date'],
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    167,
                                                                    244,
                                                                    67,
                                                                    54),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                            itemCount: toDoList['completed'].length,
                          ),
                  )
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        toDoList['previous'].isEmpty
                            ? Container()
                            : Container(
                                width: SizeVariables.getHeight(context) * 0.09,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Pending",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        toDoList['previous'].isEmpty
                            ? Container()
                            : Container(
                                // color: Colors.amber,
                                // height: SizeVariables.getHeight(context) * 0.35,
                                child: ListView.builder(
                                    // physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: _selection == 0
                                        ? toDoList['previous'].length
                                        : _selection == 1
                                            ? workPrevious.length
                                            : _selection == 2
                                                ? personalPrevious.length
                                                : null,
                                    itemBuilder: (context, index) {
                                      // final item = items[index];
                                      return InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            // isScrollControlled: true,
                                            // useSafeArea: true,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,

                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(30),
                                              ),
                                            ),
                                            builder: (ctx) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Task Name:  ${_selection == 0 ? toDoList['previous'][index]['task_title'] ?? 'No Title' : _selection == 1 ? workPrevious[index]['task_title'] ?? 'No Title' : _selection == 2 ? personalPrevious[index]['task_title'] ?? 'No Title' : null}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 14),
                                                  Text(
                                                    'Description:  ${_selection == 0 ? toDoList['previous'][index]['task_name'] ?? 'No Description' : _selection == 1 ? workPrevious[index]['task_name'] ?? 'No Description' : _selection == 2 ? personalPrevious[index]['task_name'] ?? 'No Description' : null}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(fontSize: 16),
                                                  ),
                                                  const SizedBox(height: 14),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Date: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 16,
                                                            ),
                                                      ),
                                                      Text(
                                                        _selection == 0
                                                            ? toDoList['previous']
                                                                    [index]
                                                                ['task_date']
                                                            : _selection == 1
                                                                ? workPrevious[
                                                                        index][
                                                                    'task_date']
                                                                : _selection ==
                                                                        2
                                                                    ? personalPrevious[
                                                                            index]
                                                                        [
                                                                        'task_date']
                                                                    : null,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 16,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Category: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 16,
                                                            ),
                                                      ),
                                                      Container(
                                                        child: _selection == 0
                                                            ? Icon(
                                                                toDoList['previous'][index]
                                                                            [
                                                                            'category'] ==
                                                                        'work'
                                                                    ? Icons
                                                                        .work_outline
                                                                    : Icons
                                                                        .person_outline,
                                                                color: const Color(
                                                                    0xffF59F23),
                                                                size: 30)
                                                            : _selection == 1
                                                                ? const Icon(
                                                                    Icons
                                                                        .work_outline,
                                                                    color: Color(
                                                                        0xffF59F23),
                                                                    size: 30,
                                                                  )
                                                                : _selection ==
                                                                        2
                                                                    ? const Icon(
                                                                        Icons
                                                                            .person_outline,
                                                                        color: Color(
                                                                            0xffF59F23),
                                                                        size:
                                                                            30,
                                                                      )
                                                                    : null,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Over Day: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 16,
                                                            ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '- ${_selection == 0 ? DateTime.now().difference(DateTime.parse(dateFormat.format(DateTime.parse(toDoList['previous'][index]['task_date'])))).inDays : _selection == 1 ? DateTime.now().difference(DateTime.parse(dateFormat.format(DateTime.parse(workPrevious[index]['task_date'])))).inDays : _selection == 2 ? DateTime.now().difference(DateTime.parse(dateFormat.format(DateTime.parse(personalPrevious[index]['task_date'])))).inDays : null}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 20,
                                                                ),
                                                          ),
                                                          Text(
                                                            'Day\'s',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                  fontSize: 10,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12),
                                                  role == 0
                                                      ? Container()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Assign by: ',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                            ),
                                                            Text(
                                                              'Self',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Dismissible(
                                          // key: Key(workPrevious[index]
                                          //         ['task_id']
                                          //     .toString()),
                                          key: ValueKey(_selection == 0
                                              ? toDoList['previous'][index]
                                                  ['task_title']
                                              : _selection == 1
                                                  ? workPrevious[index]
                                                      ['task_title']
                                                  : personalPrevious[index]
                                                      ['task_id']),
                                          confirmDismiss: (direction) {
                                            return showDialog(
                                                context: context,
                                                builder: (context) {
                                                  // Future.delayed(
                                                  //     const Duration(seconds: 8), () => Navigator.of(context).pop());
                                                  return CupertinoAlertDialog(
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                            'Are You Sure You Want To Delete This Task?')
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context); //close Dialog
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          // Navigator.pop(
                                                          //     context); //close Dialog

                                                          // toDoList['previous'].removeWhere((element) => element['task_id'] == toDoList['previous'][index]['task_id']);

                                                          Map<String, dynamic>
                                                              data = {
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
                                                                    : _selection ==
                                                                            2
                                                                        ? personalPrevious[index]['task_id']
                                                                            .toString()
                                                                        : null
                                                          };

                                                          Provider.of<TodaysTaskList>(
                                                                  context,
                                                                  listen: false)
                                                              .deleteTask(
                                                                  data,
                                                                  _selection,
                                                                  'Pending')
                                                              .then((value) =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop());
                                                        },
                                                        child: Text(
                                                          'Yes',
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
                                          },

                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              bottom: SizeVariables.getHeight(
                                                      context) *
                                                  0.02,
                                            ),
                                            child: ContainerStyle(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.13,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
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
                                                                isChecked:
                                                                    isClicked ==
                                                                            true
                                                                        ? false
                                                                        : false,
                                                                size: 23,
                                                                // uncheckedColor: Colors.yellow,

                                                                checkedColor:
                                                                    Colors.grey,
                                                                uncheckedColor:
                                                                    Colors
                                                                        .white,

                                                                onTap: (selected) =>
                                                                    showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          CupertinoAlertDialog(
                                                                    content: Container(
                                                                        // height:
                                                                        //     SizeVariables.getHeight(context) *
                                                                        //         0.25,
                                                                        child: const Text('Are You Sure You Want To Complete This Task?', style: TextStyle(color: Colors.black))),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context); //close Dialog
                                                                          setState(
                                                                              () {
                                                                            isClicked =
                                                                                true;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'No',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            isClicked =
                                                                                false;
                                                                          });
                                                                          Map<String, dynamic>
                                                                              data =
                                                                              {
                                                                            'id': _selection == 0
                                                                                ? toDoList['previous'][index]['task_id'].toString()
                                                                                : _selection == 1
                                                                                    ? workPrevious[index]['task_id'].toString()
                                                                                    : _selection == 2
                                                                                        ? personalPrevious[index]['task_id'].toString()
                                                                                        : null
                                                                          };

                                                                          Provider.of<TodaysTaskList>(context, listen: false)
                                                                              .changeTaskStatus('Pending', _selection, data, context)
                                                                              .then((_) {
                                                                            setState(() {
                                                                              isClicked = false;
                                                                            });
                                                                          });

                                                                          Navigator.of(context)
                                                                              .pop();

                                                                          print(
                                                                              'DATAAAAAAAAAAAAA: $data');
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Yes',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
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
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Text(
                                                                        _selection ==
                                                                                0
                                                                            ? toDoList['previous'][index]['task_title']
                                                                            : _selection == 1
                                                                                ? workPrevious[index]['task_title']
                                                                                : _selection == 2
                                                                                    ? personalPrevious[index]['task_title']
                                                                                    : null,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(
                                                                              fontSize: 18,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        child:
                                                                            Text(
                                                                          _selection == 0
                                                                              ? toDoList['previous'][index]['task_date']
                                                                              : _selection == 1
                                                                                  ? workPrevious[index]['task_date']
                                                                                  : _selection == 2
                                                                                      ? personalPrevious[index]['task_date']
                                                                                      : null,
                                                                          style:
                                                                              const TextStyle(
                                                                            color: Color.fromARGB(
                                                                                167,
                                                                                244,
                                                                                67,
                                                                                54),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: SizeVariables
                                                                  .getHeight(
                                                                      context) *
                                                              0.02,
                                                        ),
                                                        child: Column(
                                                          // mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              // decoration: BoxDecoration(
                                                              //   borderRadius: BorderRadius.circular(20),
                                                              //   border: Border.all(
                                                              //     width: 2,
                                                              //     color: Color.fromARGB(
                                                              //         255, 165, 157, 157),
                                                              //   ),
                                                              // ),
                                                              child: Text(
                                                                '- ${_selection == 0 ? DateTime.now().difference(DateTime.parse(dateFormat.format(DateTime.parse(toDoList['previous'][index]['task_date'])))).inDays : _selection == 1 ? DateTime.now().difference(DateTime.parse(dateFormat.format(DateTime.parse(workPrevious[index]['task_date'])))).inDays : _selection == 2 ? DateTime.now().difference(DateTime.parse(dateFormat.format(DateTime.parse(personalPrevious[index]['task_date'])))).inDays : null}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 22,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          167,
                                                                          244,
                                                                          67,
                                                                          54),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                'Day(s)',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            right: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.05,
                                                          ),
                                                          child: _selection == 0
                                                              ? Icon(
                                                                  toDoList['previous'][index]
                                                                              [
                                                                              'category'] ==
                                                                          'work'
                                                                      ? Icons
                                                                          .work_outline
                                                                      : Icons
                                                                          .person_outline,
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  size: 30)
                                                              : _selection == 1
                                                                  ? const Icon(
                                                                      Icons
                                                                          .work_outline,
                                                                      color: Color(
                                                                          0xffF59F23),
                                                                      size: 30,
                                                                    )
                                                                  : _selection ==
                                                                          2
                                                                      ? const Icon(
                                                                          Icons
                                                                              .person_outline,
                                                                          color:
                                                                              Color(0xffF59F23),
                                                                          size:
                                                                              30,
                                                                        )
                                                                      : null),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons.arrow_back_ios,
                                                          color: Color.fromARGB(
                                                              255,
                                                              244,
                                                              111,
                                                              102),
                                                          size: 12),
                                                      Text('Swipe To Delete',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      244,
                                                                      111,
                                                                      102),
                                                              fontSize: 10)),
                                                      Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Color.fromARGB(
                                                              255,
                                                              244,
                                                              111,
                                                              102),
                                                          size: 12)
                                                    ],
                                                  )
                                                  // const Center(
                                                  //   child: Text('Swipe To Delete', style: TextStyle(color: Colors.red)),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                        toDoList['today'].isEmpty
                            ? Container()
                            : Container(
                                width: SizeVariables.getHeight(context) * 0.07,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Today",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        toDoList['today'].isEmpty
                            ? Container()
                            : Container(
                                // color: Colors.amber,
                                // height: SizeVariables.getHeight(context) * 0.35,
                                child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: _selection == 0
                                      ? toDoList['today'].length
                                      : _selection == 1
                                          ? workCurrent.length
                                          : _selection == 2
                                              ? personalCurrent.length
                                              : null,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        // isScrollControlled: true,
                                        // useSafeArea: true,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,

                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30),
                                          ),
                                        ),
                                        builder: (ctx) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Task Name:  ${_selection == 0 ? toDoList['today'][index]['task_title'] ?? 'No Title' : _selection == 1 ? workCurrent[index]['task_title'] ?? 'No Title' : _selection == 2 ? personalCurrent[index]['task_title'] ?? 'No Title' : null}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 16,
                                                    ),
                                              ),
                                              const SizedBox(height: 14),
                                              Text(
                                                'Description:  ${_selection == 0 ? toDoList['today'][index]['task_name'] ?? 'No Description' : _selection == 1 ? workCurrent[index]['task_name'] ?? 'No Description' : _selection == 2 ? personalCurrent[index]['task_name'] ?? 'No Description' : null}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 16),
                                              ),
                                              const SizedBox(height: 14),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Date: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  Text(
                                                    _selection == 0
                                                        ? toDoList['previous']
                                                            [index]['task_date']
                                                        : _selection == 1
                                                            ? workPrevious[
                                                                    index]
                                                                ['task_date']
                                                            : _selection == 2
                                                                ? personalPrevious[
                                                                        index][
                                                                    'task_date']
                                                                : null,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Category: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  Container(
                                                    child: _selection == 0
                                                        ? Icon(
                                                            toDoList['today'][
                                                                            index]
                                                                        [
                                                                        'category'] ==
                                                                    'work'
                                                                ? Icons
                                                                    .work_outline
                                                                : Icons
                                                                    .person_outline,
                                                            color: const Color(
                                                                0xffF59F23),
                                                            size: 30)
                                                        : _selection == 1
                                                            ? const Icon(
                                                                Icons
                                                                    .work_outline,
                                                                color: Color(
                                                                    0xffF59F23),
                                                                size: 30,
                                                              )
                                                            : _selection == 2
                                                                ? const Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    color: Color(
                                                                        0xffF59F23),
                                                                    size: 30,
                                                                  )
                                                                : null,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              role == 0
                                                  ? Container()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Assign by: ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                        ),
                                                        Text(
                                                          'Self',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Dismissible(
                                      key: ValueKey(_selection == 0
                                          ? toDoList['today'][index]['task_id']
                                          : _selection == 1
                                              ? workCurrent[index]['task_id']
                                              : personalCurrent[index]
                                                  ['task_id']),
                                      confirmDismiss: (direction) {
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              // Future.delayed(
                                              //     const Duration(seconds: 8), () => Navigator.of(context).pop());
                                              return CupertinoAlertDialog(
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                        'Are You Sure You Want To Delete This Task?')
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); //close Dialog
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Navigator.pop(
                                                      //     context); //close Dialog

                                                      // toDoList['previous'].removeWhere((element) => element['task_id'] == toDoList['previous'][index]['task_id']);

                                                      Map<String, dynamic>
                                                          data = {
                                                        'id': _selection == 0
                                                            ? toDoList['today']
                                                                        [index]
                                                                    ['task_id']
                                                                .toString()
                                                            : _selection == 1
                                                                ? workCurrent[
                                                                            index]
                                                                        [
                                                                        'task_id']
                                                                    .toString()
                                                                : _selection ==
                                                                        2
                                                                    ? personalCurrent[index]
                                                                            [
                                                                            'task_id']
                                                                        .toString()
                                                                    : null
                                                      };

                                                      Provider.of<TodaysTaskList>(
                                                              context,
                                                              listen: false)
                                                          .deleteTask(
                                                              data,
                                                              _selection,
                                                              'Today')
                                                          .then((value) =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop());
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              SizeVariables.getHeight(context) *
                                                  0.02,
                                        ),
                                        child: ContainerStyle(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.1,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.03,
                                                              // top: SizeVariables.getHeight(context)*0.03,
                                                            ),
                                                            child:
                                                                RoundCheckBox(
                                                              isChecked:
                                                                  isClicked ==
                                                                          true
                                                                      ? false
                                                                      : false,
                                                              size: 23,
                                                              // uncheckedColor: Colors.yellow,

                                                              checkedColor:
                                                                  Colors.grey,
                                                              uncheckedColor:
                                                                  Colors.white,

                                                              onTap:
                                                                  (selected) =>
                                                                      showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        CupertinoAlertDialog(
                                                                  content: Container(
                                                                      // height:
                                                                      //     SizeVariables.getHeight(context) *
                                                                      //         0.25,
                                                                      child: const Text('Are You Sure You Want To Complete This Task?', style: TextStyle(color: Colors.black))),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context); //close Dialog
                                                                        setState(
                                                                            () {
                                                                          isClicked =
                                                                              true;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'No',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isClicked =
                                                                              false;
                                                                        });
                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            {
                                                                          'id': _selection == 0
                                                                              ? toDoList['today'][index]['task_id'].toString()
                                                                              : _selection == 1
                                                                                  ? workCurrent[index]['task_id'].toString()
                                                                                  : _selection == 2
                                                                                      ? personalCurrent[index]['task_id'].toString()
                                                                                      : null
                                                                        };

                                                                        Provider.of<TodaysTaskList>(context, listen: false)
                                                                            .changeTaskStatus(
                                                                                'Today',
                                                                                _selection,
                                                                                data,
                                                                                context)
                                                                            .then((_) {
                                                                          setState(
                                                                              () {
                                                                            isClicked =
                                                                                false;
                                                                          });
                                                                        });

                                                                        Navigator.of(context)
                                                                            .pop();

                                                                        print(
                                                                            'DATAAAAAAAAAAAAA: $data');
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Yes',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            // RoundCheckBox(
                                                            //   onTap: (selected) {
                                                            //     Map<String, dynamic>
                                                            //         data = {
                                                            //       'id': _selection == 0
                                                            //           ? toDoList['today']
                                                            //                       [
                                                            //                       index]
                                                            //                   [
                                                            //                   'task_id']
                                                            //               .toString()
                                                            //           : _selection == 1
                                                            //               ? workCurrent[
                                                            //                           index]
                                                            //                       [
                                                            //                       'task_id']
                                                            //                   .toString()
                                                            //               : _selection ==
                                                            //                       2
                                                            //                   ? personalCurrent[index]
                                                            //                           [
                                                            //                           'task_id']
                                                            //                       .toString()
                                                            //                   : null
                                                            //     };

                                                            //     Provider.of<TodaysTaskList>(
                                                            //             context,
                                                            //             listen: false)
                                                            //         .changeTaskStatus(
                                                            //             'Today',
                                                            //             _selection,
                                                            //             data,
                                                            //             context);
                                                            //   },
                                                            //   size: 23,
                                                            //   // uncheckedColor: Colors.yellow,
                                                            //   checkedColor: Colors.grey,
                                                            //   uncheckedColor:
                                                            //       Colors.white,
                                                            // ),
                                                            ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.025,
                                                            top: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.06,
                                                          ),
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 200,
                                                                  child: Text(
                                                                    _selection ==
                                                                            0
                                                                        ? toDoList['today'][index]
                                                                            [
                                                                            'task_title']
                                                                        : _selection ==
                                                                                1
                                                                            ? workCurrent[index]['task_title']
                                                                            : _selection == 2
                                                                                ? personalCurrent[index]['task_title']
                                                                                : null,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            fontSize:
                                                                                18),
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   child: FittedBox(
                                                                //     fit: BoxFit.contain,
                                                                //     child: Text(
                                                                //       '12-29-2022',
                                                                //       style: const TextStyle(
                                                                //           color: Color.fromARGB(
                                                                //               186, 76, 175, 79)),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      right: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.05,
                                                    ),
                                                    child: _selection == 0
                                                        ? Icon(
                                                            toDoList['today'][
                                                                            index]
                                                                        [
                                                                        'category'] ==
                                                                    'work'
                                                                ? Icons
                                                                    .work_outline
                                                                : Icons
                                                                    .person_outline,
                                                            color: Color(
                                                                0xffF59F23),
                                                            size: 30)
                                                        : _selection == 1
                                                            ? const Icon(
                                                                Icons
                                                                    .work_outline,
                                                                color: Color(
                                                                    0xffF59F23),
                                                                size: 30,
                                                              )
                                                            : _selection == 2
                                                                ? const Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    color: Color(
                                                                        0xffF59F23),
                                                                    size: 30,
                                                                  )
                                                                : null,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.arrow_back_ios,
                                                      color: Color.fromARGB(
                                                          255, 244, 111, 102),
                                                      size: 12),
                                                  Text('Swipe To Delete',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              244,
                                                              111,
                                                              102),
                                                          fontSize: 10)),
                                                  Icon(Icons.arrow_forward_ios,
                                                      color: Color.fromARGB(
                                                          255, 244, 111, 102),
                                                      size: 12)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        toDoList['upcoming'].isEmpty
                            ? Container()
                            : Container(
                                width: SizeVariables.getHeight(context) * 0.11,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Upcoming",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        toDoList['upcoming'].isEmpty
                            ? Container()
                            : Container(
                                // color: Colors.amber,
                                // height: SizeVariables.getHeight(context) * 0.35,
                                child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: _selection == 0
                                      ? toDoList['upcoming'].length
                                      : _selection == 1
                                          ? workUpcoming.length
                                          : _selection == 2
                                              ? personalUpcoming.length
                                              : null,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        // isScrollControlled: true,
                                        // useSafeArea: true,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,

                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30),
                                          ),
                                        ),
                                        builder: (ctx) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 30),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Task Name:  ${_selection == 0 ? toDoList['upcoming'][index]['task_title'] ?? 'No Title' : _selection == 1 ? workUpcoming[index]['task_title'] ?? 'No Title' : _selection == 2 ? personalUpcoming[index]['task_title'] ?? 'No Title' : null}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 16,
                                                    ),
                                              ),
                                              const SizedBox(height: 14),
                                              Text(
                                                'Description:  ${_selection == 0 ? toDoList['upcoming'][index]['task_name'] ?? 'No Description' : _selection == 1 ? workUpcoming[index]['task_name'] ?? 'No Description' : _selection == 2 ? personalUpcoming[index]['task_name'] ?? 'No Description' : null}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 16),
                                              ),
                                              const SizedBox(height: 14),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Date: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  Text(
                                                    _selection == 0
                                                        ? toDoList['upcoming']
                                                            [index]['task_date']
                                                        : _selection == 1
                                                            ? workUpcoming[
                                                                    index]
                                                                ['task_date']
                                                            : _selection == 2
                                                                ? personalUpcoming[
                                                                        index][
                                                                    'task_date']
                                                                : null,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Category: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  Container(
                                                    child: _selection == 0
                                                        ? Icon(
                                                            toDoList['upcoming']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'category'] ==
                                                                    'work'
                                                                ? Icons
                                                                    .work_outline
                                                                : Icons
                                                                    .person_outline,
                                                            color: const Color(
                                                                0xffF59F23),
                                                            size: 30)
                                                        : _selection == 1
                                                            ? const Icon(
                                                                Icons
                                                                    .work_outline,
                                                                color: Color(
                                                                    0xffF59F23),
                                                                size: 30,
                                                              )
                                                            : _selection == 2
                                                                ? const Icon(
                                                                    Icons
                                                                        .person_outline,
                                                                    color: Color(
                                                                        0xffF59F23),
                                                                    size: 30,
                                                                  )
                                                                : null,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Upcoming: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '+ ${_selection == 0 ? DateTime.parse(dateFormat.format(DateTime.parse(toDoList['upcoming'][index]['task_date']))).difference(DateTime.now()).inDays + 1 : _selection == 1 ? DateTime.parse(dateFormat.format(DateTime.parse(toDoList['upcoming'][index]['task_date']))).difference(DateTime.now()).inDays + 1 : _selection == 2 ? DateTime.parse(dateFormat.format(DateTime.parse(toDoList['upcoming'][index]['task_date']))).difference(DateTime.now()).inDays + 1 : null}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              color:
                                                                  Colors.amber,
                                                              fontSize: 20,
                                                            ),
                                                      ),
                                                      Text(
                                                        'Day\'s',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              fontSize: 10,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              role == 0
                                                  ? Container()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Assign by: ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.15,
                                                              child: Text(
                                                                'Name Assign',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                              ),
                                                            ),
                                                            CircleAvatar(
                                                              radius: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.04,
                                                              backgroundImage:
                                                                  const AssetImage(
                                                                'assets/img/profilePic.jpg',
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Dismissible(
                                      key: ValueKey(_selection == 0
                                          ? toDoList['upcoming'][index]
                                              ['task_id']
                                          : _selection == 1
                                              ? workUpcoming[index]['task_id']
                                              : personalUpcoming[index]
                                                  ['task_id']),
                                      confirmDismiss: (direction) {
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              // Future.delayed(
                                              //     const Duration(seconds: 8), () => Navigator.of(context).pop());
                                              return CupertinoAlertDialog(
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                        'Are You Sure You Want To Delete This Task?')
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); //close Dialog
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Navigator.pop(
                                                      //     context); //close Dialog

                                                      // toDoList['previous'].removeWhere((element) => element['task_id'] == toDoList['previous'][index]['task_id']);

                                                      Map<String, dynamic>
                                                          data = {
                                                        'id': _selection == 0
                                                            ? toDoList['upcoming']
                                                                        [index]
                                                                    ['task_id']
                                                                .toString()
                                                            : _selection == 1
                                                                ? workUpcoming[
                                                                            index]
                                                                        [
                                                                        'task_id']
                                                                    .toString()
                                                                : _selection ==
                                                                        2
                                                                    ? personalUpcoming[index]
                                                                            [
                                                                            'task_id']
                                                                        .toString()
                                                                    : null
                                                      };

                                                      Provider.of<TodaysTaskList>(
                                                              context,
                                                              listen: false)
                                                          .deleteTask(
                                                              data,
                                                              _selection,
                                                              'Upcoming')
                                                          .then((value) =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop());
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom:
                                              SizeVariables.getHeight(context) *
                                                  0.02,
                                        ),
                                        child: ContainerStyle(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.12,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.03,
                                                              // top: SizeVariables.getHeight(context)*0.03,
                                                            ),
                                                            child:
                                                                RoundCheckBox(
                                                              isChecked:
                                                                  isClicked ==
                                                                          true
                                                                      ? false
                                                                      : false,
                                                              size: 23,
                                                              // uncheckedColor: Colors.yellow,

                                                              checkedColor:
                                                                  Colors.grey,
                                                              uncheckedColor:
                                                                  Colors.white,

                                                              onTap:
                                                                  (selected) =>
                                                                      showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        CupertinoAlertDialog(
                                                                  content: Container(
                                                                      // height:
                                                                      //     SizeVariables.getHeight(context) *
                                                                      //         0.25,
                                                                      child: const Text('Are You Sure You Want To Complete This Task?', style: TextStyle(color: Colors.black))),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context); //close Dialog
                                                                        setState(
                                                                            () {
                                                                          isClicked =
                                                                              true;
                                                                        });
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'No',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isClicked =
                                                                              false;
                                                                        });
                                                                        Map<String,
                                                                                dynamic>
                                                                            data =
                                                                            {
                                                                          'id': _selection == 0
                                                                              ? toDoList['upcoming'][index]['task_id'].toString()
                                                                              : _selection == 1
                                                                                  ? workUpcoming[index]['task_id'].toString()
                                                                                  : _selection == 2
                                                                                      ? personalUpcoming[index]['task_id'].toString()
                                                                                      : null
                                                                        };

                                                                        Provider.of<TodaysTaskList>(context, listen: false)
                                                                            .changeTaskStatus(
                                                                                'Upcoming',
                                                                                _selection,
                                                                                data,
                                                                                context)
                                                                            .then((_) {
                                                                          setState(
                                                                              () {
                                                                            isClicked =
                                                                                false;
                                                                          });
                                                                        });

                                                                        Navigator.of(context)
                                                                            .pop();

                                                                        print(
                                                                            'DATAAAAAAAAAAAAA: $data');
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'Yes',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                            // RoundCheckBox(
                                                            //   onTap: (selected) {
                                                            //     Map<String, dynamic>
                                                            //         data = {
                                                            //       'id': _selection == 0
                                                            //           ? toDoList['upcoming']
                                                            //                       [
                                                            //                       index]
                                                            //                   [
                                                            //                   'task_id']
                                                            //               .toString()
                                                            //           : _selection == 1
                                                            //               ? workUpcoming[
                                                            //                           index]
                                                            //                       [
                                                            //                       'task_id']
                                                            //                   .toString()
                                                            //               : _selection ==
                                                            //                       2
                                                            //                   ? personalUpcoming[index]
                                                            //                           [
                                                            //                           'task_id']
                                                            //                       .toString()
                                                            //                   : null
                                                            //     };

                                                            //     Provider.of<TodaysTaskList>(
                                                            //             context,
                                                            //             listen: false)
                                                            //         .changeTaskStatus(
                                                            //             'Upcoming',
                                                            //             _selection,
                                                            //             data,
                                                            //             context);
                                                            //   },
                                                            //   size: 23,
                                                            //   // uncheckedColor: Colors.yellow,
                                                            //   checkedColor: Colors.grey,
                                                            //   uncheckedColor:
                                                            //       Colors.white,
                                                            // ),
                                                            ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
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
                                                                  width: 200,
                                                                  child: Text(
                                                                    _selection ==
                                                                            0
                                                                        ? toDoList['upcoming'][index]
                                                                            [
                                                                            'task_title']
                                                                        : _selection ==
                                                                                1
                                                                            ? workUpcoming[index]['task_title']
                                                                            : _selection == 2
                                                                                ? personalUpcoming[index]['task_title']
                                                                                : null,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    child: Text(
                                                                      _selection ==
                                                                              0
                                                                          ? toDoList['upcoming'][index]
                                                                              [
                                                                              'task_date']
                                                                          : _selection == 1
                                                                              ? workUpcoming[index]['task_date']
                                                                              : _selection == 2
                                                                                  ? personalUpcoming[index]['task_date']
                                                                                  : null,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Color(
                                                                            0xffF59F23),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.02,
                                                    ),
                                                    child: Column(
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          // decoration: BoxDecoration(
                                                          //   borderRadius: BorderRadius.circular(20),
                                                          //   border: Border.all(
                                                          //     width: 2,
                                                          //     color: Color.fromARGB(
                                                          //         255, 165, 157, 157),
                                                          //   ),
                                                          // ),
                                                          child: Text(
                                                            '+ ${_selection == 0 ? DateTime.parse(dateFormat.format(DateTime.parse(toDoList['upcoming'][index]['task_date']))).difference(DateTime.now()).inDays + 1 : _selection == 1 ? DateTime.parse(dateFormat.format(DateTime.parse(toDoList['upcoming'][index]['task_date']))).difference(DateTime.now()).inDays + 1 : _selection == 2 ? DateTime.parse(dateFormat.format(DateTime.parse(toDoList['upcoming'][index]['task_date']))).difference(DateTime.now()).inDays + 1 : null}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 22,
                                                              color: Color(
                                                                  0xffF59F23),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Day(s)',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                        right: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.05,
                                                      ),
                                                      child: _selection == 0
                                                          ? Icon(
                                                              toDoList['upcoming']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'category'] ==
                                                                      'work'
                                                                  ? Icons
                                                                      .work_outline
                                                                  : Icons
                                                                      .person_outline,
                                                              color: const Color(
                                                                  0xffF59F23),
                                                              size: 30)
                                                          : _selection == 1
                                                              ? const Icon(
                                                                  Icons
                                                                      .work_outline,
                                                                  color: Color(
                                                                      0xffF59F23),
                                                                  size: 30,
                                                                )
                                                              : _selection == 2
                                                                  ? const Icon(
                                                                      Icons
                                                                          .person_outline,
                                                                      color: Color(
                                                                          0xffF59F23),
                                                                      size: 30,
                                                                    )
                                                                  : null),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.arrow_back_ios,
                                                      color: Color.fromARGB(
                                                          255, 244, 111, 102),
                                                      size: 12),
                                                  Text('Swipe To Delete',
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              244,
                                                              111,
                                                              102),
                                                          fontSize: 10)),
                                                  Icon(Icons.arrow_forward_ios,
                                                      color: Color.fromARGB(
                                                          255, 244, 111, 102),
                                                      size: 12)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  openDialog(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        context: context,
        builder: (context) {
          int? _radioValue = 0;
          int? _managerValue = 0;
          String? assignedName;

          return ModalBottomSheet();
        });
  }

  void add() {
    Navigator.of(context).pop();
  }
}
