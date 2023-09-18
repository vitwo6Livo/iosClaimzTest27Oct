import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/widgets/clamizHistroyWidget/clamizStyle.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class ContainerHisWidget extends StatefulWidget {
  // const ContainerHisWidget({Key? key}) : super(key: key);

  @override
  State<ContainerHisWidget> createState() => _ContainerHisWidgetState();
}

class _ContainerHisWidgetState extends State<ContainerHisWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // scrollDirection: Axis.horizontal,

      height: SizeVariables.getHeight(context) * 0.9,
      child: ListView.builder(
        itemBuilder: (context, index) => Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      bottom: SizeVariables.getHeight(context) * 0.3),
                  child: CircleAvatar(
                    radius: SizeVariables.getWidth(context) * 0.06,
                    backgroundColor: Color(0xffF59F23),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        children: const [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              '25',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Sep',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: SizeVariables.getWidth(context) * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04),
                        child: ListWidget(
                          height: SizeVariables.getHeight(context) * 0.17,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeVariables.getHeight(context) *
                                                  0.013),
                                      width: SizeVariables.getWidth(context) *
                                          0.65,
                                      // color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: const [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'NewTown',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 164, 236, 166),
                                                    fontSize: 12,
                                                    // fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  '10:10 AM',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 113, 112, 112),
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const FittedBox(
                                                fit: BoxFit.contain,
                                                child: Icon(
                                                  Icons.motorcycle_outlined,
                                                  color: Color.fromARGB(
                                                      255, 167, 146, 81),
                                                  size: 25,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      '01',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      'H',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xffF59F23),
                                                              fontSize: 10),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.015,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      '11',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      'm',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xffF59F23),
                                                              fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: const [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'SoltLake',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 232, 175, 175),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  '11:10 AM',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          221, 118, 114, 114),
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.02,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.35,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Icon(
                                                      Icons.timer_outlined,
                                                      color: Color.fromARGB(
                                                          255, 167, 146, 81),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '02',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'H',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.015,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '50',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'm',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.008),
                                              Row(
                                                children: [
                                                  const FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Icon(
                                                      Icons.handshake_outlined,
                                                      color: Color.fromARGB(
                                                          255, 167, 146, 81),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '01',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'H',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.015,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '33',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'm',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.19),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.pushNamed(context,
                                              //     RouteNames.historyclaim);
                                            },
                                            child: Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.07,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.15,
                                              child: RippleAnimation(
                                                  repeat: true,
                                                  color: Colors.grey,
                                                  minRadius: 20,
                                                  ripplesCount: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 10,
                                                      left: 5,
                                                    ),
                                                    child: Image.asset(
                                                        'assets/icons/claim_logo.png'),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04),
                        child: ListWidget(
                          height: SizeVariables.getHeight(context) * 0.17,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeVariables.getHeight(context) *
                                                  0.013),
                                      width: SizeVariables.getWidth(context) *
                                          0.65,
                                      // color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: const [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'NewTown',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 164, 236, 166),
                                                    fontSize: 12,
                                                    // fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  '10:10 AM',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 113, 112, 112),
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const FittedBox(
                                                fit: BoxFit.contain,
                                                child: Icon(
                                                  Icons.motorcycle_outlined,
                                                  color: Color.fromARGB(
                                                      255, 167, 146, 81),
                                                  size: 25,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      '01',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      'H',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xffF59F23),
                                                              fontSize: 10),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.015,
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      '11',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      'm',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xffF59F23),
                                                              fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: const [
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'SoltLake',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 232, 175, 175),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  '11:10 AM',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          221, 118, 114, 114),
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.02,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.35,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Icon(
                                                      Icons.timer_outlined,
                                                      color: Color.fromARGB(
                                                          255, 167, 146, 81),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '02',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'H',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.015,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '50',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'm',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.008),
                                              Row(
                                                children: [
                                                  const FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Icon(
                                                      Icons.handshake_outlined,
                                                      color: Color.fromARGB(
                                                          255, 167, 146, 81),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '01',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'H',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.015,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          '33',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          16),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'm',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: const Color(
                                                                      0xffF59F23),
                                                                  fontSize: 10),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.19),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.pushNamed(context,
                                              //     RouteNames.historyclaim);
                                            },
                                            child: Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.07,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.15,
                                              child: RippleAnimation(
                                                  repeat: true,
                                                  color: Colors.grey,
                                                  minRadius: 20,
                                                  ripplesCount: 2,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 10,
                                                      left: 5,
                                                    ),
                                                    child: Image.asset(
                                                        'assets/icons/claim_logo.png'),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02)
          ],
        ),
        itemCount: 5,
      ),
    );
  }
}
