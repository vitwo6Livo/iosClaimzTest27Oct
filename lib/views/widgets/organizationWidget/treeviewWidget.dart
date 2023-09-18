import 'package:claimz/views/widgets/organizationWidget/src/app_controller.dart';
import 'package:claimz/views/widgets/organizationWidget/src/treeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import '../../../viewModel/reportingTreeViewModel.dart';
import '../../config/mediaQuery.dart';
import 'src/tree_node_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/views/widgets/organizationWidget/src/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:shimmer/shimmer.dart';

class TreeviewWidget extends StatefulWidget {
  final int empId; //The Employee ID passed from the previous Widget
  final String name; //The Name passed from the previous Widget
  final String
      departmentName; //The Department Name passed from the previous Widget
  final String profilePhoto; //The Profile Photo passed from the previous Widget

  @override
  State<TreeviewWidget> createState() => _TreeviewWidgetState();

  TreeviewWidget(this.empId, this.name, this.departmentName, this.profilePhoto);
}

class _TreeviewWidgetState extends State<TreeviewWidget> {
  bool isLoading = true;
  var tree;

  @override
  void initState() {
    // TODO: implement initState

    //This here is the API call which stores the response received from the server. Also, tree is where it gets stored for further use

    Provider.of<ReportingTreeViewModel>(context, listen: false)
        .getReportingTree(context, widget.empId)
        .then((value) {
      setState(() {
        isLoading = false;
        tree = Provider.of<ReportingTreeViewModel>(context, listen: false).tree;
      });
    });

    super.initState();
  }

  late final AppController appController = AppController(tree);

  @override
  void dispose() {
    appController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppControllerScope(
      controller: appController,
      child: FutureBuilder<void>(
        future: appController.init(),
        builder: (_, __) {
          if (appController.isInitialized) {
            return HomePage(widget.empId, widget.name, widget.departmentName,
                widget.profilePhoto);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final int empId;
  final String name;
  final String departmentName;
  final String profilePhoto;

  HomePage(this.empId, this.name, this.departmentName, this.profilePhoto);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height > 850
          ? 72.4.h
          : height > 750
              ? 71.6.h
              : height < 650
                  ? 70.h
                  : 67.9.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 700,
            height: 80,
            // color: Colors.red,
            child: _ResponsiveBody(empId, name, departmentName, profilePhoto),

            // endDrawer: const Drawer(child: SettingsView()),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveBody extends StatelessWidget {
  final int empId;
  final String name;
  final String departmentName;
  final String profilePhoto;

  _ResponsiveBody(
      this.empId, this.name, this.departmentName, this.profilePhoto);

  @override
  Widget build(BuildContext context) {
    // if (MediaQuery.of(context).size.width < 600) {
    //   return const CustomTreeView();
    // }
    final appController = AppController.of(context);
    return ValueListenableBuilder<TreeViewTheme>(
      valueListenable: appController.treeViewTheme,
      builder: (_, treeViewTheme, __) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TreeView(
            controller: appController.treeController,
            // theme: treeViewTheme,
            // scrollController: appController.scrollController,
            nodeHeight: appController.nodeHeight,
            nodeBuilder: (_, __) =>
                TreeNodeTile(empId, name, departmentName, profilePhoto),
          ),
        );
      },
    );
  }
}

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

class _NodeActionsChip extends StatefulWidget {
  final String departmentName;

  @override
  State<_NodeActionsChip> createState() => _NodeActionsChipState();

  _NodeActionsChip(this.departmentName);
}

class _NodeActionsChipState extends State<_NodeActionsChip> {
  final GlobalKey<PopupMenuButtonState> _popupMenuKey = GlobalKey();

  // PopupMenuButtonState? get _menu => _popupMenuKey.currentState;

  @override
  Widget build(BuildContext context) {
    final nodeScope = TreeNodeScope.of(context);

    return Container(
      // height: 200,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.pink,
            child: Row(
              children: [
                Container(
                  child: Text(
                    nodeScope.node.id,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  height: 35,
                  child: const ExpandNodeIcon(
                    color: Colors.white,
                    expandedColor: Colors.amber,
                    // size: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.amber,
            // height: 1,
            child: Text(
              widget.departmentName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
        // onPressed: () {},
        // backgroundColor: const Color(0x331565c0),
      ),
    );
  }
}

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
          // Container(
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.remove_red_eye_outlined,
          //       color: Colors.grey,
          //       size: 16,
          //     ),
          //     onPressed: () {
          //       Navigator.pushNamed(context, RouteNames.organizationdetails);
          //     },
          //   ),
          // ),
          SizedBox(width: SizeVariables.getWidth(context) * 0.18),
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

enum ExpansionButtonType { folderFile, chevron }

class AppController with ChangeNotifier {
  final dynamic tree;

  AppController(this.tree);

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  static AppController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppControllerScope>()!
        .controller;
  }

  Future<void> init() async {
    if (_isInitialized) return;

    final rootNode = TreeNode(id: kRootId);
    generateSampleTree(rootNode);

    treeController = TreeViewController(
      rootNode: rootNode,
    );

    _isInitialized = true;
  }

  late final TreeViewController treeController;

  final nodeHeight = 70.0;

  late final scrollController = ScrollController();

  final treeViewTheme = ValueNotifier(const TreeViewTheme());
  // final expansionButtonType = ValueNotifier(ExpansionButtonType.folderFile);

  @override
  void dispose() {
    treeController.dispose();
    scrollController.dispose();

    treeViewTheme.dispose();
    // expansionButtonType.dispose();
    super.dispose();
  }
}

class AppControllerScope extends InheritedWidget {
  const AppControllerScope({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final AppController controller;

  @override
  bool updateShouldNotify(AppControllerScope oldWidget) => false;
}

void generateSampleTree(TreeNode parent) {
  final childrenIds = kDataSample[parent.id];
  if (childrenIds == null) return;

  parent.addChildren(
    childrenIds.map(
      (String childId) => TreeNode(
        id: childId,
        // label: 'Sample Node',
      ),
    ),
  );
  parent.children.forEach(generateSampleTree);
}

const String kRootId = 'Root';

const Map<String, List<String>> kDataSample = {
  kRootId: [
    'Joy Shill',
  ],
  'Joy Shill': [
    'Rachhel',
    'Joy Shil',
    'Joy',
    'Joy1',
    'Joy2',
    'Joy3',
    'Joy4',
    'Joy5',
    'Joy6',
    'Joy7',
    'Joy8',
    'Joy9',
    'Joy10',
  ],
  'Rachhel': [
    'Joy11',
    'Joy12',
    'Joy13',
    'Joy14',
    'Joy15',
  ],
  'Joy11': ['Paromita', 'Paro'],
  'Paromita': ['Siddd', 'tanay'],
  'Siddd': [
    'Ramen',
    'imran',
  ],
  'Ramen': [
    'Supriyo',
  ]
};

//JSON Response

// {
//     "status": 200,
//     "data": [
//         {
//             "department": "System",
//             "hod": {
//                 "dep_id": 161,
//                 "department_name": "System",
//                 "user_id": 921,
//                 "emp_name": "Shaikh Salim Akhtar",
//                 "emp_code": "EMP055",
//                 "profile_photo": "https://console.claimz.in/api/profile_photo/202210291143921image_cropper_1667024019467.jpg"
//             },
//             "members": [
//                 {
//                     "id": 886,
//                     "emp_name": "Souvik Karmakar",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202210271206886image_cropper_1666852528222.jpg",
//                 },
//                 {
//                     "id": 911,
//                     "emp_name": "Ritashree Dey",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202210271030911image_cropper_1666846837116.jpg",
//                 },
//                 {
//                     "id": 920,
//                     "emp_name": "Rachhel Sekh",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202211111352920image_cropper_1668154951828.jpg",
//                 },
//                 {
//                     "id": 921,
//                     "emp_name": "Shaikh Salim Akhtar",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202210291143921image_cropper_1667024019467.jpg",
//                 },
//                 {
//                     "id": 925,
//                     "emp_name": "Somdutta Sengupta",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202209191410925IMG_20220919_135715.jpg",
//                 },
//                 {
//                     "id": 928,
//                     "emp_name": "Kashif Ali",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202212151810928image_cropper_1671107986310.jpg",
//                 },
//                 {
//                     "id": 929,
//                     "emp_name": "Rupsha Chatterjee",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo",
//                 },
//                 {
//                     "id": 932,
//                     "emp_name": "Siddhartha Chatterjee",
//                     "profile_photo": "https://console.claimz.in/api/profile_photo/202305010024932image_cropper_1682880873644.jpg"
//                 }
//             ]
//         },
//     ]
// }