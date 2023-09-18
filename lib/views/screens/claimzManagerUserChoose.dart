import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/bottomNavigationBar.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/appUrl.dart';
import 'claimzManagerUserChooseShimmer.dart';

class claimzManagerUserChooseScreen extends StatefulWidget {
  // const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  State<claimzManagerUserChooseScreen> createState() =>
      _claimzManagerUserChooseScreenState();
}

class _claimzManagerUserChooseScreenState
    extends State<claimzManagerUserChooseScreen> {
  ClaimzHistoryViewModel searchUserData = ClaimzHistoryViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map data = {
      "keyword": "",
    };
    searchUserData.postSearchUser(context, data);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          padding: EdgeInsets.only(
            left: SizeVariables.getWidth(context) * 0.025,
            right: SizeVariables.getWidth(context) * 0.025,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.02),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomBottomNavigation(0)));
                      },
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Choose User',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              ChangeNotifierProvider<ClaimzHistoryViewModel>(
                create: (context) => searchUserData,
                child: Consumer<ClaimzHistoryViewModel>(
                  builder: (context, value, child) {
                    switch (value.searchUserRecord!.status) {
                      case Status.ERROR:
                        return Center(
                          child:
                              Text(value.searchUserRecord.message.toString()),
                        );
                      case Status.LOADING:
                        return ManagerConvenyanceShimmer();
                      // CircularProgressIndicator();
                      case Status.COMPLETED:
                        return Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                            itemCount:
                                value.searchUserRecord.data!.data!.length,
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                boxShadow: (themeProvider.darkTheme)
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          //offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                              ),
                              child: ContainerStyle(
                                height: SizeVariables.getHeight(context) * 0.07,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeVariables.getHeight(context) *
                                          0.02),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          print(value.searchUserRecord.data!
                                              .data![index].id
                                              .toString());
                                          Map data = {
                                            "uid": value.searchUserRecord.data!
                                                .data![index].id
                                                .toString(),
                                          };
                                          Navigator.pushNamed(context,
                                              RouteNames.claimmanagerscreen,
                                              arguments: data);
                                        });
                                        // Navigator.pop(context);
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.01,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: value
                                                            .searchUserRecord
                                                            .data!
                                                            .data![index]!
                                                            .profilePhoto ==
                                                        '${AppUrl.baseUrl}/profile_photo/' ||
                                                    value
                                                            .searchUserRecord
                                                            .data!
                                                            .data![index]!
                                                            .profilePhoto ==
                                                        null
                                                ? CircleAvatar(
                                                    radius:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.08,
                                                    backgroundColor:
                                                        Colors.green,
                                                    backgroundImage:
                                                        const AssetImage(
                                                            'assets/img/profilePic.jpg'),
                                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl: value
                                                        .searchUserRecord
                                                        .data!
                                                        .data![index]!
                                                        .profilePhoto,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.08,
                                                      width: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.08,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit
                                                                  .contain)),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        Container(
                                                            height: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.06,
                                                            child: Shimmer
                                                                .fromColors(
                                                              baseColor: Colors
                                                                  .grey[400]!,
                                                              highlightColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      120,
                                                                      120,
                                                                      120),
                                                              child:
                                                                  const CircleAvatar(
                                                                radius: 2,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                child: Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .camera_alt_outlined,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 25),
                                                                ),
                                                              ),
                                                            )),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.01,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              value.searchUserRecord.data!
                                                  .data![index]!.empName
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.005,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              value.searchUserRecord.data!
                                                  .data![index]!.count
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                    }
                    return Container();
                  },
                  // child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
