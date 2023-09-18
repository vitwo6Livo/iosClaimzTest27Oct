// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../../config/mediaQuery.dart';
import '../widget/salesContainerStyle.dart';

class OpenSO_Tab extends StatefulWidget {
  const OpenSO_Tab({super.key});

  @override
  State<OpenSO_Tab> createState() => _OpenSO_TabState();
}

class _OpenSO_TabState extends State<OpenSO_Tab> {
  List<Map<String, dynamic>> openData = [
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
      'cName': 'Tata Consultancy Services Limited',
      'sNumber': 'SO2306009',
      'cPO': 'POITC34567765456',
      'dDate': '2023-06-01',
      'color': const Color(0xfff5cc29c),
      'tItem': '20',
      'ststus': 'Open',
      'sColor': const Color(0xfff0b7736),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: openData.length,
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
                        openData[index]['cName'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Text(
                      openData[index]['dDate'],
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
                        openData[index]['cPO'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Text(
                      openData[index]['sNumber'],
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
                          openData[index]['tItem'],
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
                        color: openData[index]['color'],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Text(
                          openData[index]['ststus'],
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: openData[index]['sColor'],
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
