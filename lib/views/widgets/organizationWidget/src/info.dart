import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: IconButton(
              icon: const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.grey,
                size: 16,
              ),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.organizationdetails);
              },
            ),
          ),
          Container(
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.green.shade400,
              child: Text(
                '5',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
