import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/widgets/organizationWidget/organisationShimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../data/response/status.dart';
import '../../../provider/theme_provider.dart';
import '../../../res/components/containerStyle.dart';
import '../../../viewModel/organisationViewModel.dart';
import '../../config/mediaQuery.dart';

class OrganizationTree extends StatefulWidget {
  const OrganizationTree({Key? key}) : super(key: key);

  @override
  State<OrganizationTree> createState() => _OrganizationTreeState();
}

class _OrganizationTreeState extends State<OrganizationTree> {
  // final organizationViewModel = OrganizationViewModel();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrganizationViewModel>(context, listen: false)
        .getOrganisation()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final provider = Provider.of<OrganizationViewModel>(context).organisation;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.05,
              right: SizeVariables.getWidth(context) * 0.05,
              top: SizeVariables.getHeight(context) * 0.02,
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 40,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider['data'].length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.organisationlist,
                    arguments: provider['data'][index],
                  );
                },
                child: ContainerStyle(
                  height: SizeVariables.getHeight(context) * 0.024.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // width: SizeVariables.getWidth(context)*0.4,
                          child: Text(
                            '${provider['data'][index]['department']}:',
                            style: Theme.of(context).textTheme.bodyText2!,
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: Colors.amber,
                              ),
                              Text(
                                // value.organisation.data!.data![i].members!
                                //     .length
                                //     .toString(),
                                provider['data'][index]['members']
                                    .length
                                    .toString(),
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

    // return ChangeNotifierProvider<OrganizationViewModel>(
    //   create: (context) => organizationViewModel,
    //   child: Consumer<OrganizationViewModel>(
    //     builder: (context, value, child) {
    //       switch (value.organisation.status) {
    //         case Status.LOADING:
    //           return Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         case Status.ERROR:
    //           return Center(
    //             child: Text(value.organisation.message.toString()),
    //           );
    //         case Status.COMPLETED:
    //           return Container(
    //             padding: EdgeInsets.only(
    //               left: SizeVariables.getWidth(context) * 0.05,
    //               right: SizeVariables.getWidth(context) * 0.05,
    //               top: SizeVariables.getHeight(context) * 0.02,
    //             ),
    //             child: GridView.builder(
    //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2,
    //                 crossAxisSpacing: 30,
    //                 mainAxisSpacing: 40,
    //               ),
    //               physics: const NeverScrollableScrollPhysics(),
    //               shrinkWrap: true,
    //               itemCount: value.organisation.data!.data!.length,
    //               itemBuilder: (context, index) => InkWell(
    //                 onTap: () {
    //                   Navigator.pushNamed(
    //                     context,
    //                     RouteNames.organisationlist,
    //                     arguments: value.organisation.data!.data![index],
    //                   );
    //                 },
    //                 child: ContainerStyle(
    //                   height: SizeVariables.getHeight(context) * 0.024.h,
    //                   child: Center(
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         Container(
    //                           // width: SizeVariables.getWidth(context)*0.4,
    //                           child: Text(
    //                             '${value.organisation.data!.data![index].department}:',
    //                             style: Theme.of(context).textTheme.bodyText2!,
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: SizeVariables.getHeight(context) * 0.02,
    //                         ),
    //                         Container(
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceAround,
    //                             children: [
    //                               const Icon(
    //                                 Icons.person_outline,
    //                                 color: Colors.amber,
    //                               ),
    //                               Text(
    //                                 // value.organisation.data!.data![i].members!
    //                                 //     .length
    //                                 //     .toString(),
    //                                 value.organisation.data!.data![index]
    //                                     .members!.length
    //                                     .toString(),
    //                                 style:
    //                                     Theme.of(context).textTheme.bodyText1!,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         default:
    //       }
    //       return Container();
    //     },
    //   ),
    // );
  }
}
