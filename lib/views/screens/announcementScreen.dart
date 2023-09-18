import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/claimsStatusViewModel.dart';
import '../config/mediaQuery.dart';
import '../widgets/announcementWidget/announcementContainer.dart';
import '../../viewModel/announcementViewModel.dart';
import '../widgets/announcementWidget/announcementShimmer.dart';
import 'package:intl/intl.dart';

class AnnouncementScreen extends StatefulWidget {
  // const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  bool isLoading = true;
  List<dynamic> query = [];
  List<dynamic> data = [];
  final _controller = TextEditingController();
  int? role;
  DateTime? _selected;
  var myMonth = DateFormat('MMMM').format(DateTime.now());
  var myYears = DateFormat('yyyy').format(DateTime.now());

  List<String> month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> year = ["2022", "2021", "2020", "2019", "2018"];

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AnnouncementViewModel>(context, listen: false)
        .getAllAnouncements(
            DateFormat('MMMM').format(DateTime.now()).toString(),
            DateFormat('yyyy').format(DateTime.now()).toString())
        .then((_) {
      setState(() {
        isLoading = false;
        data = Provider.of<AnnouncementViewModel>(context, listen: false)
            .announcementFilter;
        query = data;
      });
    });
    initialise();
    super.initState();
  }

  void initialise() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    role = localStorage.getInt('role');
  }

  searchByQuery(String search) {
    setState(() {
      query = data
          .where((element) =>
              element['emp_name']
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              element['announcement_title']
                  .toLowerCase()
                  .contains(search.toLowerCase()))
          .toList();
      // query = data
      //     .where((element) => element['announcement_title']
      //         .toLowerCase()
      //         .contains(search.toLowerCase()))
      //     .toList();
    });
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final provider =
        Provider.of<AnnouncementViewModel>(context).announcementFilter;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: role == 1
            ? FloatingActionButton(
                backgroundColor:
                    (themeProvider.darkTheme) ? Colors.grey : Colors.amber,
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.postAnnouncement);
                },
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColorLight,
                ),
              )
            : null,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          toolbarHeight: SizeVariables.getHeight(context) * 0.15,
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: SizeVariables.getHeight(context) * 0.04,
                ),
                // height: SizeVariables.getHeight(context) * 0.1,
                // color: Colors.green,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CustomBottomNavigation(2)));
                            Provider.of<AnnouncementViewModel>(context,
                                    listen: false)
                                .getAllAnouncements(
                                    DateFormat('MMMM')
                                        .format(DateTime.now())
                                        .toString(),
                                    DateFormat('yyyy')
                                        .format(DateTime.now())
                                        .toString());
                            Provider.of<ClaimzStatusViewModel>(context,
                                    listen: false)
                                .getClaimzStatuss();
                          },
                          child: SvgPicture.asset(
                            "assets/icons/back button.svg",
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.02),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.4,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Announcements',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.amber,
                      width: SizeVariables.getWidth(context) * 0.3,
                      height: SizeVariables.getHeight(context) * 0.05,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: DateRangePicker(
                          onPressed: pickDateRange,
                          end: end,
                          start: start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                width: double.infinity,
                // color: Colors.red,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.02,
                          right: SizeVariables.getWidth(context) * 0.04,
                          bottom: SizeVariables.getHeight(context) * 0.04),
                      child: Container(
                        // color: Colors.amber,
                        width: SizeVariables.getWidth(context) * 0.8,
                        height: SizeVariables.getHeight(context) * 0.065,

                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              // spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Icon(
                                Icons.search_outlined,
                                color: Colors.grey,
                                size: 22,
                              ),
                            ),
                            Flexible(
                              flex: 9,
                              fit: FlexFit.tight,
                              child: TextField(
                                controller: _controller,
                                onChanged: (value) => searchByQuery(value),
                                autofocus: false,
                                cursorColor: Colors.grey,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search By Name or Title',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: isLoading
            ? AnnouncementShimmer()
            : provider.isEmpty
                ? Center(
                    child: Text('No Announcements',
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                : Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.025,
                      right: SizeVariables.getWidth(context) * 0.025,
                      // top: SizeVariables.getHeight(context) * 0.02
                    ),
                    child: Column(children: [
                      // Flexible(flex: 1, fit: FlexFit.loose, child: AnnouncementHeader()),
                      // SizedBox(height: SizeVariables.getHeight(context) * 0.01),
                      // SizedBox(height: SizeVariables.getHeight(context)*0.01,),
                      Flexible(
                        flex: 20,
                        fit: FlexFit.tight,
                        child: Container(
                          // color: Colors.blue,
                          height: SizeVariables.getHeight(context) * 0.99,
                          child: AnnouncementsContainer(query),
                        ),
                      ),
                    ]),
                  ),
      ),
    );
  }

  Future pickDateRange() async {
    var myMonth;
    var myYears;
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        saveText: 'SET',
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xffF59F23),
                  surface: Colors.grey,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: Color.fromARGB(255, 91, 91, 91),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    isLoading = true;

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      myMonth = DateFormat('MMMM').format(dateRange.start);
      myYears = DateFormat('yyyy').format(dateRange.start);
      print('myMonthsss: $myMonth');
      print('myYears: $myYears');
    });

    Provider.of<AnnouncementViewModel>(context, listen: false)
        .getAllAnouncements(myMonth, myYears)
        .then((_) {
      setState(() {
        isLoading = false;
        data = Provider.of<AnnouncementViewModel>(context, listen: false)
            .announcementFilter;
        query = data;
      });
    });
    //     .then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    print('dateRange: $dateRange');

    return dateRange;
  }
}
