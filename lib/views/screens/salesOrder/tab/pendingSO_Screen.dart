// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../../config/mediaQuery.dart';
import '../widget/salesContainerStyle.dart';

class PendingSO_Tab extends StatefulWidget {
  const PendingSO_Tab({super.key});

  @override
  State<PendingSO_Tab> createState() => _PendingSO_TabState();
}

class _PendingSO_TabState extends State<PendingSO_Tab> {
  List<Map<String, dynamic>> pendingData = [
    {
      'cName': 'Joy shil pvt. ltd',
      'sNumber': 'SO2307003',
      'cPO': 'PO989898',
      'dDate': '2023-07-05',
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
      'color': const Color(0xfffb9a76e),
      'tItem': '1',
      'ststus': 'PENDING',
      'sColor': const Color(0xfff7c711e),
    },
    {
      'cName': 'Tata Consultancy Services Limited',
      'sNumber': 'SO2306009',
      'cPO': 'POITC34567765456',
      'dDate': '2023-06-01',
      'color': const Color(0xfffb9a76e),
      'tItem': '1',
      'ststus': 'PENDING',
      'sColor': const Color(0xfff7c711e),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pendingData.length,
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
                        pendingData[index]['cName'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Text(
                      pendingData[index]['dDate'],
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
                        pendingData[index]['cPO'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Text(
                      pendingData[index]['sNumber'],
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
                          pendingData[index]['tItem'],
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
                        color: pendingData[index]['color'],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        child: Text(
                          pendingData[index]['ststus'],
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: pendingData[index]['sColor'],
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
