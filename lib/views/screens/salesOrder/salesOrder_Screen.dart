import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../custom_page_route.dart';
import 'addSales_Screen.dart';
import 'tab/all_screen.dart';
import 'tab/openSO_Screen.dart';
import 'tab/pendingSO_Screen.dart';

class SalesOrder_Screen extends StatelessWidget {
  const SalesOrder_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              CustomPageRoute(
                child: const Add_salesOder_Screen(),
                direction: AxisDirection.up,
              ),
            );
          },
          backgroundColor: Colors.amberAccent,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context)
                .appBarTheme
                .systemOverlayStyle
                ?.statusBarColor,
          ),
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  "assets/icons/back button.svg",
                ),
              ),
              const SizedBox(width: 5),
              FittedBox(
                child: Text(
                  'Order List',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 24,
                      ),
                ),
              ),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Open SO'),
              FittedBox(
                fit: BoxFit.contain,
                child: Tab(text: 'Pending SO'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            All_Screen(),
            OpenSO_Tab(),
            PendingSO_Tab(),
          ],
        ),
      ),
    );
  }
}
