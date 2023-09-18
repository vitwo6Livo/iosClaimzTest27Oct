import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/viewModel/userHolidays/userHolidayViewModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../provider/theme_provider.dart';
import '../../../config/mediaQuery.dart';

class OptionalHoliday extends StatefulWidget {
  OptionalHolidayState createState() => OptionalHolidayState();

  List<Map<String, dynamic>> optionalHolidays;

  OptionalHoliday(this.optionalHolidays);
}

class OptionalHolidayState extends State<OptionalHoliday> {
  List<bool> isClicked = [];
  List<Map<String, dynamic>> selectedHolidays = [];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final limit = Provider.of<UserHolidayViewModel>(context).limit;

    // TODO: implement build
    return Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              flex: 10,
              child: Container(
                // color: Colors.red,
                width: double.infinity,
                child: ListView.builder(
                    itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.03,
                            // right: SizeVariables.getWidth(context) * 0.01
                          ),
                          margin: EdgeInsets.only(
                              bottom: SizeVariables.getHeight(context) * 0.02),
                          width: double.infinity,
                          height: SizeVariables.getHeight(context) * 0.1,
                          decoration: BoxDecoration(
                              // color: Colors.amber,

                              borderRadius: BorderRadius.circular(
                                  SizeVariables.getHeight(context) * 0.02),
                              border: Border.all(
                                  color: (themeProvider.darkTheme)
                                      ? Colors.grey
                                      : Colors.white,
                                  width: 2)),
                          child: Row(
                            children: [
                              // Center(child: Icon(Icons.circle, color: Colors.white)),
                              Center(
                                  child: Checkbox(
                                value: widget.optionalHolidays[index][
                                    'isChecked'], // You can set the initial value here
                                onChanged: (newValue) {
                                  // Handle checkbox change here
                                  // You can update the state to manage the checked state.
                                  setState(() {
                                    widget.optionalHolidays[index]
                                        ['isChecked'] = newValue;
                                    widget.optionalHolidays[index]
                                                ['isChecked'] ==
                                            true
                                        ? isClicked.add(true)
                                        : isClicked.removeAt(index);

                                    widget.optionalHolidays[index]
                                                ['isChecked'] ==
                                            true
                                        ? selectedHolidays.add({
                                            'holiday_id':
                                                widget.optionalHolidays[index]
                                                    ['holiday_id'],
                                            'holiday_date':
                                                widget.optionalHolidays[index]
                                                    ['holiday_date']
                                          })
                                        : selectedHolidays.removeAt(index);

                                    print(
                                        'Selected Holidays: $selectedHolidays');

                                    print('isClicked List: $isClicked');
                                    print('isClicked: $newValue');
                                  });

                                  // Provider.of<UserHolidayViewModel>(context, listen: false).postHoliday(selectedHolidays, context).then((value) {
                                  //   setState(() {
                                  //     selectedHolidays = [];
                                  //     isClicked = [];
                                  //   });
                                  // });
                                },
                              )

                                  // CircleAvatar(
                                  //   backgroundColor: Colors.white,
                                  //   radius: SizeVariables.getWidth(context) * 0.02,
                                  // ),
                                  ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.05,
                                      right: SizeVariables.getWidth(context) *
                                          0.05),
                                  height: double.infinity,
                                  // color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.optionalHolidays[index]
                                              ['holiday'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      Text(
                                          '${DateFormat('EEE').format(DateTime.parse(
                                            widget.optionalHolidays[index]
                                                ['holiday_date'],
                                          ))}, ${widget.optionalHolidays[index]['holiday_date']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.grey))
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        SizeVariables.getHeight(context) *
                                            0.02),
                                    bottomRight: Radius.circular(
                                        SizeVariables.getHeight(context) *
                                            0.02)),
                                child: Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.057,
                                  width: SizeVariables.getWidth(context) * 0.2,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.optionalHolidays[index]
                                        ['image'],
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundImage: imageProvider,
                                      radius: 60,
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: const CircleAvatar(
                                        radius: 60,
                                      ),
                                    ),
                                  ),
                                  // Lottie.asset('assets/json/gandhiji.json'),
                                ),
                              )
                            ],
                          ),
                        ),
                    itemCount: widget.optionalHolidays.length),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // height: SizeVariables.getHeight(context) * 0.05,
                // color: Colors.amber,
                child: Center(
                    child: isClicked.isEmpty
                        ? Column(
                            children: [
                              const Text('Apply',
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.02),
                              Text(
                                  'You can opt for a maximum of $limit optional holiday(s)',
                                  style: const TextStyle(color: Colors.white))
                            ],
                          )
                        : Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    // selectedHolidays.clear();
                                    // isClicked.clear();

                                    for (var holiday
                                        in widget.optionalHolidays) {
                                      holiday['isChecked'] = false;
                                    }

                                    Provider.of<UserHolidayViewModel>(context,
                                            listen: false)
                                        .postHoliday(
                                            {'holidays': selectedHolidays},
                                            context).then((value) {
                                      setState(() {
                                        // Clear the selectedHolidays and isClicked again if needed
                                        selectedHolidays.clear();
                                        isClicked.clear();
                                      });
                                    });
                                  },
                                  child: const Text('Apply',
                                      style: TextStyle(color: Colors.amber))),
                              SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.02),
                              Text(
                                  'You can opt for a maximum of $limit optional holiday(s)',
                                  style: const TextStyle(color: Colors.white))
                            ],
                          )),
              ),
            )
          ],
        ));
  }
}
