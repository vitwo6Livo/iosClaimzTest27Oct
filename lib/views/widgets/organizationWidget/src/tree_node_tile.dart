import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/views/widgets/organizationWidget/src/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../config/mediaQuery.dart';
import 'app_controller.dart';
part '_actions_chip.dart';

const Color _kDarkBlue = Color.fromARGB(255, 102, 137, 177);

const RoundedRectangleBorder kRoundedRectangleBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class TreeNodeTile extends StatefulWidget {
  final int empId;
  final String name;
  final String departmentName;
  final String profilePhoto;

  @override
  _TreeNodeTileState createState() => _TreeNodeTileState();

  TreeNodeTile(this.empId, this.name, this.departmentName, this.profilePhoto);
}

class _TreeNodeTileState extends State<TreeNodeTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LinesWidget(),
        SizedBox(width: 9),
        widget.profilePhoto == 'NA'
            ? CircleAvatar(
                radius: SizeVariables.getWidth(context) * 0.08,
                backgroundColor: Colors.green,
                backgroundImage: const AssetImage('assets/img/profilePic.jpg'),
                // child: const Icon(Icons.account_box, color: Colors.white),
              )
            : CachedNetworkImage(
                imageUrl: widget.profilePhoto,
                imageBuilder: (context, imageProvider) => Container(
                  height: SizeVariables.getHeight(context) * 0.08,
                  width: SizeVariables.getHeight(context) * 0.08,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain)),
                ),
                placeholder: (context, url) => Container(
                    height: SizeVariables.getHeight(context) * 0.06,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: const CircleAvatar(
                        radius: 2,
                        backgroundColor: Colors.green,
                        child: Center(
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    )),
              ),
        SizedBox(width: 9),
        _NodeActionsChip(widget.departmentName),
        // _NodeSelector(),

        // Expanded(child: _NodeTitle()),

        SizedBox(width: 100),
        Information(),
      ],
    );
  }
}
