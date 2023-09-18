import 'package:flutter/material.dart';

import '../../../res/components/buttonStyle.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';

class EdittaskContainer extends StatefulWidget {
  // const EdittaskContainer({Key? key}) : super(key: key);

  @override
  State<EdittaskContainer> createState() => _EdittaskContainerState();
}

class _EdittaskContainerState extends State<EdittaskContainer> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String add1 = '';

  var addYears1 = "19 Apr, 2022";
  List<String> addyear1 = [
    "19 Apr, 2022",
    "19 May, 2022",
    "19 jun, 2022",
    "19 Jul, 2022",
    "19 Aug, 2022"
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
                          addYears1 = value!;
                          setState(() {});
                        },
                        value: addYears1,
                        items: addyear1.map((item) {
                          return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
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
                    'Edit Task',
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
                            return 'Please enter Task Edit';
                          } else {
                            add1 = value;
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
                    onPressed: () {},
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
