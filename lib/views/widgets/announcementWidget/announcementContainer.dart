import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../res/appUrl.dart';

class AnnouncementsContainer extends StatefulWidget {
  // const AnnouncementsContainer({Key? key}) : super(key: key);
  final List<dynamic> announcements;

  @override
  State<AnnouncementsContainer> createState() => _AnnouncementsContainerState();

  const AnnouncementsContainer(this.announcements, {super.key});
}

class _AnnouncementsContainerState extends State<AnnouncementsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () => _bottomSheetAnnouncement(context, index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 33, 33, 33),
                borderRadius: BorderRadius.circular(18)),
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            height: SizeVariables.getHeight(context) * 0.12,
            width: double.infinity,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.all(
                        SizeVariables.getHeight(context) * 0.005),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.announcements[index]['profile_photo'] == null
                            ? CircleAvatar(
                                radius: SizeVariables.getWidth(context) * 0.08,
                                backgroundImage: const AssetImage(
                                    'assets/img/profilePic.jpg'),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    '${AppUrl.baseUrl}/profile_photo/${widget.announcements[index]['profile_photo']}',
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius:
                                      SizeVariables.getWidth(context) * 0.08,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor:
                                      const Color.fromARGB(255, 120, 120, 120),
                                  child: CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.announcements[index]['emp_name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 16)),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.announcements[index]
                                              ['announcement_title'],
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.005),
                            child: Text(
                              widget.announcements[index]['created_at'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        itemCount: widget.announcements.length,
      ),
    );
  }

  Future<dynamic> _bottomSheetAnnouncement(BuildContext context, int index) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: SizeVariables.getHeight(context) * 0.07,
                child: Row(
                  children: [
                    widget.announcements[index]['profile_photo'] == null
                        ? CircleAvatar(
                            radius: SizeVariables.getWidth(context) * 0.08,
                            backgroundImage:
                                const AssetImage('assets/img/profilePic.jpg'),
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                '${AppUrl.baseUrl}/profile_photo/${widget.announcements[index]['profile_photo']}',
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: SizeVariables.getWidth(context) * 0.08,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: CircleAvatar(
                                radius: SizeVariables.getWidth(context) * 0.08,
                              ),
                            ),
                          ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.announcements[index]['announcement_title'],
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.02),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Text(
                    widget.announcements[index]['announcement'],
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
