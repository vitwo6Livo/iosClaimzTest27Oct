import 'package:flutter/material.dart';
import '../../../res/components/alert_dialog.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../res/components/containerStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/toDoViewModel.dart';

class TaskaddContainer extends StatefulWidget {
  // const TaskaddContainer({Key? key}) : super(key: key);

  @override
  State<TaskaddContainer> createState() => _TaskaddContainerState();
}

class _TaskaddContainerState extends State<TaskaddContainer> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String add = '';

  var addYears = "2022-08-26";
  List<String> addyear = [
    "2022-08-26",
    "2022-12-24",
    "2022-11-23",
    "2022-10-22",
    "2022-09-21"
  ];
  @override
  Widget build(BuildContext context) {
    return ContainerStyle(
      height: SizeVariables.getHeight(context) * 0.5,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.04,
                top: SizeVariables.getHeight(context) * 0.022),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'To',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.00001,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: SizeVariables.getWidth(context) * 0.65),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.04,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: DropdownButton<String>(
                        iconSize: 50,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        dropdownColor: Colors.black87,
                        onChanged: (value) {
                          addYears = value!;
                          setState(() {});
                        },
                        value: addYears,
                        items: addyear.map((item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Task Add',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Form(
                  key: _key,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.03,
                        top: SizeVariables.getWidth(context) * 0.04),
                    child: ContainerStyle(
                      // margin: const EdgeInsets.only(right: 25),
                      height: SizeVariables.getHeight(context) * 0.2,
                      child: TextFormField(
                        // decoration: const InputDecoration(
                        //   border: OutlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.grey),
                        //   ),
                        //   fillColor: Colors.grey,
                        // ),
                        validator: (value) {
                          if (value!.isEmpty || value == '') {
                            return 'Please enter Task Add';
                          } else {
                            add = value;
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.033,
                ),
                Center(
                  child: AppButtonStyle(
                    label: 'Submit',
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        Map<String, dynamic> _data = {
                          'task': add,
                          'task_date': addYears
                        };

                        // Provider.of<ToDoViewModel>(context, listen: false)
                        //     .addToDo(_data)
                        //     .then((value) => showDialog(
                        //         context: context,
                        //         builder: (context) => CustomDialog(
                        //               title: 'Task Added Successfully',
                        //               subtitle: '',
                        //               onOk: () => Navigator.pushNamed(
                        //                   context, RouteNames.tasklist),
                        //               onCancel: () =>
                        //                   Navigator.of(context).pop(),
                        //             )));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
