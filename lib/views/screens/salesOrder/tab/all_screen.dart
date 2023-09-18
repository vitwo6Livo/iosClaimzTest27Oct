// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../../config/mediaQuery.dart';
import '../widget/salesContainerStyle.dart';

class All_Screen extends StatefulWidget {
  const All_Screen({super.key});

  @override
  State<All_Screen> createState() => _All_ScreenState();
}

class _All_ScreenState extends State<All_Screen> {
  List<Map<String, dynamic>> allData = [
    {
      'cName': 'Joy shil pvt. ltd',
      'sNumber': 'SO2307003',
      'cPO': 'PO989898',
      'dDate': '2023-07-05',
      'color': const Color(0xfff5cc29c),
      'tItem': '9',
      'ststus': 'Open',
      'sColor': const Color(0xfff0b7736),
    },
    {
      'cName': 'HAPPIEST MINDS TECHNOLOGIES LIMITED',
      'sNumber': 'SO2306009',
      'cPO': 'POITC34567765456',
      'dDate': '2023-06-23',
      'color': const Color(0xfff5cc29c),
      'tItem': '4',
      'ststus': 'Open',
      'sColor': const Color(0xfff0b7736),
    },
    {
      'cName': 'ABC TECHNOLOGIES LIMITED',
      'sNumber': 'SO645546',
      'cPO': 'POI64664653',
      'dDate': '2023-06-23',
      'color': const Color(0xfff6c757d),
      'tItem': '1',
      'ststus': 'CLOSED',
      'sColor': Colors.white,
    },
    {
      'cName': 'Tata Consultancy Services Limited',
      'sNumber': 'SO2306003',
      'cPO': 'PO2306011',
      'dDate': '2023-06-02',
      'color': const Color(0xfffb9a76e),
      'tItem': '1',
      'ststus': 'PENDING',
      'sColor': const Color(0xfff7c711e),
    },
    {
      'cName': 'HAPPIEST MINDS TECHNOLOGIES LIMITED',
      'sNumber': 'SO2306009',
      'cPO': 'POITC34567765456',
      'dDate': '2023-06-23',
      'color': const Color(0xfff5cc29c),
      'tItem': '4',
      'ststus': 'Open',
      'sColor': const Color(0xfff0b7736),
    },
    {
      'cName': 'ABC TECHNOLOGIES LIMITED',
      'sNumber': 'SO645546',
      'cPO': 'POI64664653',
      'dDate': '2023-06-23',
      'color': const Color(0xfff6c757d),
      'tItem': '1',
      'ststus': 'CLOSED',
      'sColor': Colors.white,
    },
    {
      'cName': 'Tata Consultancy Services Limited',
      'sNumber': 'SO2306003',
      'cPO': 'PO2306011',
      'dDate': '2023-06-02',
      'color': const Color(0xfffb9a76e),
      'tItem': '1',
      'ststus': 'PENDING',
      'sColor': const Color(0xfff7c711e),
    },
    {
      'cName': 'Tata Consultancy Services Limited',
      'sNumber': 'SO2306003',
      'cPO': 'PO2306011',
      'dDate': '2023-06-02',
      'color': const Color(0xfffb9a76e),
      'tItem': '1',
      'ststus': 'PENDING',
      'sColor': const Color(0xfff7c711e),
    },
    {
      'cName': 'ABC TECHNOLOGIES LIMITED',
      'sNumber': 'SO645546',
      'cPO': 'POI64664653',
      'dDate': '2023-06-23',
      'color': const Color(0xfff6c757d),
      'tItem': '1',
      'ststus': 'CLOSED',
      'sColor': Colors.white,
    },
    {
      'cName': 'HAPPIEST MINDS TECHNOLOGIES LIMITED',
      'sNumber': 'SO2306009',
      'cPO': 'POITC34567765456',
      'dDate': '2023-06-23',
      'color': const Color(0xfff5cc29c),
      'tItem': '4',
      'ststus': 'Open',
      'sColor': const Color(0xfff0b7736),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allData.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SalesContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeVariables.getWidth(context) * 0.48,
                      child: Text(
                        allData[index]['cName'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Text(
                      allData[index]['dDate'],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeVariables.getWidth(context) * 0.48,
                      child: Text(
                        allData[index]['cPO'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Text(
                      allData[index]['sNumber'],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          allData[index]['tItem'],
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: allData[index]['color'],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Text(
                          allData[index]['ststus'],
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: allData[index]['sColor'],
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
