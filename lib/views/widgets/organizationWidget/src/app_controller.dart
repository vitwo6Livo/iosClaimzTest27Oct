import 'package:flutter/widgets.dart';

import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

enum ExpansionButtonType { folderFile, chevron }

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
  // 'Joy': [
  //   'Tanny',
  //   'Sidd',
  // ],
  // 'Sidd': [
  //   'ABCD',
  // ],
  // 'ABCD': [
  //   'EFG',
  // ],
};

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
