part of 'tree_node_tile.dart';

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
