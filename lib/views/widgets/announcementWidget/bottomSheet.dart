import 'package:flutter/material.dart';

class BottomSheetDepartment extends StatefulWidget {
  final dynamic departmentData;

  BottomSheetDepartment(this.departmentData);

  @override
  State<BottomSheetDepartment> createState() => _BottomSheetDepartmentState();
}

class _BottomSheetDepartmentState extends State<BottomSheetDepartment> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.amber;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.departmentData.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: widget.departmentData[index]['isClicked'],
                shape: CircleBorder(),
                onChanged: (bool? value) {
                  setState(() {
                    widget.departmentData[index]['isClicked'] = value!;
                  });
                },
              ),
              const SizedBox(width: 10),
              Text(
                widget.departmentData[index]['department_name'],
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
