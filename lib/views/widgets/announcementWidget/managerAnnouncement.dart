import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/viewModel/postAnnouncementViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/theme_provider.dart';
import '../../../res/components/containerStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';
import 'bottomSheet.dart';

class ManagerAnnouncementScreen extends StatefulWidget {
  ManagerAnnouncementScreenState createState() =>
      ManagerAnnouncementScreenState();
}

class ManagerAnnouncementScreenState extends State<ManagerAnnouncementScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String title = '';
  String announcment = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  bool isLoading = true;
  // var _selectedItem;
  List<DepartmentItem> _selectedItem = [];
  List<String> items = [];
  List<dynamic> itemId = [];
  bool _selectedDepartment = false;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<PostAnnouncementViewModel>(context, listen: false)
        .getAllDepartments()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void _departmentBottomheet(dynamic departmentData) {
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

    void _stateUpdate(bool? value) {
      setState(() {});
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      // builder: (ctx) => BottomSheetDepartment(departmentData),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            child: ListView.builder(
              itemCount: departmentData.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: departmentData[index]['isClicked'],
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          departmentData[index]['isClicked'] = value!;
                          items.add(departmentData[index]['department_name']);
                          itemId.add(departmentData[index]['id']);
                        });
                        // Navigator.of(context).pop();
                        print('Selected Departments: $items');
                      },
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        print('joooooooooooooooooooooooooooooooooooooo');
                      },
                      child: Text(
                        departmentData[index]['department_name'],
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final departments =
        Provider.of<PostAnnouncementViewModel>(context).departments;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Container(
              padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.008,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(RouteNames.announcementscreen);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacementNamed(RouteNames.announcementscreen);
                      // Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.announcementscreen, (route) => false);
                      Navigator.popAndPushNamed(
                          context, RouteNames.announcementscreen);
                      // Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.navbar, (route) => false);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/back button.svg",
                    ),
                  ),
                  SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                  Container(
                    width: width > 450
                        ? 50.w
                        : width < 350
                            ? 63.w
                            : 60.w,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Make An Announcement',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ContainerStyle(
                    height: height > 750
                        ? 46.h
                        : height < 650
                            ? 55.h
                            : 52.h,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                          right: SizeVariables.getWidth(context) * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(height: SizeVariables.getHeight(context) * 0.01),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => _departmentBottomheet(departments),
                                child: Container(
                                  width: SizeVariables.getWidth(context) * 0.56,
                                  child: Text(
                                    items.isEmpty
                                        ? 'Select Who Can View Announcement'
                                        : items.join(', '),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => _departmentBottomheet(departments),
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                  // size: 16,
                                ),
                              ),
                            ],
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       child: DropdownButtonHideUnderline(
                          //         child: DropdownButton<List<DepartmentItem>>(
                          //           dropdownColor:
                          //               const Color.fromARGB(255, 49, 47, 47),
                          //           value: _selectedItem,
                          //           hint: Text(
                          //             'Select Who Can View Announcement',
                          //             style:
                          //                 Theme.of(context).textTheme.bodyText1,
                          //           ),
                          //           items: departments.map((item) {
                          //             return DropdownMenuItem<
                          //                 List<DepartmentItem>>(
                          //               value: _selectedItem != null &&
                          //                       _selectedItem.contains(item)
                          //                   ? _selectedItem
                          //                   : [...?_selectedItem, item],
                          //               // _selectedItem.contains(item)
                          //               //     ? _selectedItem
                          //               //     : [..._selectedItem, item],
                          //               child: CheckboxListTile(
                          //                 title: Text(item.departmentName),
                          //                 value: _selectedItem.contains(item),
                          //                 onChanged: (bool? value) {
                          //                   setState(() {
                          //                     // item.isSelected = value ?? false;
                          //                     if (value!) {
                          //                       _selectedItem.add(item);
                          //                     } else {
                          //                       _selectedItem.remove(item);
                          //                     }
                          //                   });
                          //                 },
                          //                 controlAffinity:
                          //                     ListTileControlAffinity.leading,
                          //               ),
                          //             );
                          //           }).toList(),
                          //           onChanged: (selectedItems) {
                          //             setState(() {
                          //               _selectedItem = selectedItems!;
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02,
                          ),
                          Form(
                            key: _key,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: SizeVariables.getWidth(context) *
                                            0.67),
                                    child: Text(
                                      'Announcement Title',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeVariables.getWidth(context) *
                                          0.025,
                                      left: SizeVariables.getWidth(context) *
                                          0.025,
                                      top: SizeVariables.getWidth(context) *
                                          0.04),
                                  child: ContainerStyle(
                                    // margin: const EdgeInsets.only(right: 25),
                                    height:
                                        SizeVariables.getHeight(context) * 0.05,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(35),
                                        ],
                                        autofocus: false,
                                        controller: _titleController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          // border: OutlineInputBorder(
                                          //   borderSide: BorderSide(color: Colors.grey),
                                          // ),
                                          // fillColor: Colors.grey,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value!.isEmpty || value == '') {
                                            return 'Please enter Reason';
                                          } else {
                                            title = value;
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.05),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: SizeVariables.getWidth(context) *
                                            0.67),
                                    child: Text(
                                      'Announcement',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeVariables.getWidth(context) *
                                          0.025,
                                      left: SizeVariables.getWidth(context) *
                                          0.025,
                                      top: SizeVariables.getWidth(context) *
                                          0.04),
                                  child: ContainerStyle(
                                    // margin: const EdgeInsets.only(right: 25),
                                    height: height > 750
                                        ? 16.h
                                        : height < 650
                                            ? 19.h
                                            : 16.h,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        maxLines: 5,
                                        validator: (value) {
                                          if (value!.isEmpty || value == '') {
                                            return 'Please enter Reason';
                                          } else {
                                            announcment = value;
                                            return null;
                                          }
                                        },
                                      ),
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
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    child: AnimatedButton(
                      height: 45,
                      width: 160,
                      text: 'Post Announcment',
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
                        if (_selectedItem == null) {
                          Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  leftBarIndicatorColor: Colors.red,
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                  message:
                                      'Please Select Department to Post Announcement To')
                              .show(context);
                        } else if (_titleController.text == '') {
                          Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  leftBarIndicatorColor: Colors.red,
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                  message: 'Announcement Must Have A Title')
                              .show(context);
                        } else if (_textController.text == '') {
                          Flushbar(
                                  duration: const Duration(seconds: 4),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  borderRadius: BorderRadius.circular(10),
                                  icon: const Icon(Icons.error,
                                      color: Colors.white),
                                  leftBarIndicatorColor: Colors.red,
                                  // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                  message:
                                      'Announcement Must Have A Description')
                              .show(context);
                        } else {
                          Map<String, dynamic> data = {
                            'department_id': itemId,
                            'announcement_title': _titleController.text,
                            'announcement': _textController.text
                          };

                          FocusManager.instance.primaryFocus?.unfocus();

                          print('Test Announcment: $data');

                          Provider.of<PostAnnouncementViewModel>(context,
                                  listen: false)
                              .postAnnouncement(
                                  context,
                                  data,
                                  DateFormat('MMMM')
                                      .format(DateTime.now())
                                      .toString(),
                                  DateFormat('yyyy')
                                      .format(DateTime.now())
                                      .toString())
                              .then((value) {
                            setState(() {
                              _titleController.clear();
                              _textController.clear();
                              _selectedItem == null;
                            });
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
