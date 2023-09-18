import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:intl/intl.dart';
import '../../../res/components/alert_dialog.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../res/components/containerStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/toDoViewModel.dart';

class EdittaskContainer extends StatefulWidget {
  // const EdittaskContainer({Key? key}) : super(key: key);
  @override
  State<EdittaskContainer> createState() => _EdittaskContainerState();
}

class _EdittaskContainerState extends State<EdittaskContainer> {
  TextEditingController edittext = new TextEditingController();
  TextEditingController afrom_date = new TextEditingController();
  TextEditingController ato_date = new TextEditingController();
  TextEditingController assigned = new TextEditingController();
  TextEditingController notes = new TextEditingController();

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    edittext.text =
        "task description where you add some \nnotes comments according to your \nneeds.";
    return Column(
      children: [
        ContainerStyle(
          height: SizeVariables.getHeight(context) * 0.4,
          child: Padding(
            padding:
                EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.05),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02,
                      right: SizeVariables.getWidth(context) * 0.61),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Update the file',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeVariables.getWidth(context) * 0.26),
                  child: Container(
                    height: 100,
                    child: TextFormField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      controller: edittext,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                              colorScheme: ColorScheme.dark(
                                                primary: Color(0xffF59F23),
                                                surface: Colors.black,
                                                onSurface: Colors.white,
                                              ),
                                              dialogBackgroundColor:
                                                  Color.fromARGB(
                                                      255, 91, 91, 91),
                                            ),
                                            child: child!,
                                          ),
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  afrom_date.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
                                });
                                // print('DATE START: $_dateTimeStart');
                              });
                            },
                            child: Container(
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              onTap: () {
                                showDatePicker(
                                        builder: (context, child) => Theme(
                                              data: ThemeData().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                  primary: Color(0xffF59F23),
                                                  surface: Colors.black,
                                                  onSurface: Colors.white,
                                                ),
                                                dialogBackgroundColor:
                                                    Color.fromARGB(
                                                        255, 91, 91, 91),
                                              ),
                                              child: child!,
                                            ),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2015),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)))
                                    .then((value) {
                                  setState(() {
                                    // _dateTimeStart = value;
                                    afrom_date.text = dateFormat.format(
                                        DateTime.parse(value.toString()));
                                  });
                                  // print('DATE START: $_dateTimeStart');
                                });
                              },
                              readOnly: true,
                              controller: afrom_date,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 167, 164, 164)),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 194, 191, 191)),
                                ),
                                // border: InputBorder.none,
                                labelText: 'Due date',
                                // hintText: "From",
                                // hintStyle: Theme.of(context)
                                //     .textTheme
                                //     .bodyText2!
                                //     .copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                              style: Theme.of(context).textTheme.bodyText2,
                              showCursor: true,
                              cursorColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Icon(
                              Icons.repeat,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            onTap: () {},
                            // readOnly: true,
                            controller: ato_date,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Repeat task',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            showCursor: true,
                            cursorColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: Icon(
                                Icons.message_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              onTap: () {},
                              // readOnly: true,
                              controller: assigned,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 167, 164, 164)),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 194, 191, 191)),
                                ),
                                // border: InputBorder.none,
                                labelText: 'Assigned',
                                // hintText: "From",
                                // hintStyle: Theme.of(context)
                                //     .textTheme
                                //     .bodyText2!
                                //     .copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                              style: Theme.of(context).textTheme.bodyText2,
                              showCursor: true,
                              cursorColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Icon(
                              Icons.assignment,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            onTap: () {},
                            // readOnly: true,
                            controller: notes,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Notes',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            showCursor: true,
                            cursorColor: Colors.white,
                          ),
                        ),
                      ],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                  right: SizeVariables.getWidth(context) * 0.05),
              child: AnimatedButton(
                height: 45,
                width: 100,
                text: 'Submit',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.LEFT_TO_RIGHT,
                textStyle: TextStyle(fontSize: 13),
                backgroundColor: Colors.black,
                borderColor: Colors.white,
                borderRadius: 8,
                borderWidth: 2,
                onPress: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> _openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 87, 83, 83),

          // title: Text("data"),
          content: TextField(
            maxLines: 5,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Add",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: add,
            ),
          ],
        ),
      );
  void add() {
    Navigator.of(context).pop();
  }
}
