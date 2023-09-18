import 'dart:convert';

import 'package:claimz/models/ticket.dart';
import 'package:claimz/views/screens/profileScreen.dart';
import 'package:claimz/views/screens/ticketHistory.dart';
import 'package:claimz/views/screens/ticketScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/mediaQuery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'custom_page_route.dart';

class TicketHistoryScroll extends StatefulWidget {
  final Map<String, dynamic> profile;
  // const TicketHistoryScroll({Key? key}) : super(key: key);

  TicketHistoryScroll(this.profile);

  @override
  State<TicketHistoryScroll> createState() => _TicketHistoryScrollState();
}

class _TicketHistoryScrollState extends State<TicketHistoryScroll> {
  List<Ticket> _allticketList = [];
  List<Ticket> _pendingTickets = [];
  List<Ticket> _closedTickets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAllTickets().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<dynamic> _getAllTickets() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var response = await http.post(
      Uri.parse('http://claimz.vitwo.in/api/get-ticket'),
      headers: {
        'Authorization': 'Bearer ${localStorage.getString('token')}',
      },
    );
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      //print('responseBody: $responseBody');
      //print('responseBody[data] : ${responseBody['data']}');
      List ticketList = responseBody['data'];
      if (ticketList.isEmpty || ticketList.length == 0) {
        setState(() {
          _allticketList = [];
        });
      } else {
        setState(() {
          _allticketList = ticketList
              .map(
                (item) => Ticket(
                  description: item['description'],
                  id: item['ticket_unique_id'],
                  status: item['status'],
                  title: item['title'],
                  createDate: item['create_date'],
                  createdDate: item['created_at'],
                  doneDate: item['done_date'],
                  ongoingDate: item['ongoing_date'],
                  priority: item['priority'],
                ),
              )
              .toList();
          _closedTickets = _allticketList
              .where((element) => element.doneDate != null)
              .toList();
          _pendingTickets = _allticketList
              .where((element) => element.doneDate == null)
              .toList();
        });
      }
      //print(ticketList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                  child: TicketScreen(widget.profile),
                  direction: AxisDirection.up));
            },
            backgroundColor: Colors.amberAccent,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 0,
            title: Container(
              // height: 400,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(widget.profile)));
                          },
                          child: SvgPicture.asset(
                            "assets/icons/back button.svg",
                          ),
                        ),
                        SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.4,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Ticket History',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
                indicatorColor: Theme.of(context).colorScheme.onPrimary,
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Closed'),
                ]),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: [
                    TicketHistroy(_pendingTickets),
                    TicketHistroy(_closedTickets),
                  ],
                ),
        ),
      ),
    );
  }
}
