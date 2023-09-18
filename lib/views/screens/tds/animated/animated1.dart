import 'package:flutter/material.dart';

class ExpandedSectionTds1 extends StatefulWidget {
  final Widget child;
  final int height;
  final bool expand;

  ExpandedSectionTds1({
    this.expand = false,
    required this.child,
    required this.height,
  });

  @override
  _ExpandedSectionTds1State createState() => _ExpandedSectionTds1State();
}

class _ExpandedSectionTds1State extends State<ExpandedSectionTds1>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSectionTds1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),

        padding: const EdgeInsets.only(bottom: 5),
        constraints: BoxConstraints(
          minWidth: double.infinity,
          maxHeight: widget.height > 5
              ? 350
              : widget.height == 1
                  ? 55
                  : widget.height * 50.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: widget.child,
        ),
      ),
    );
  }
}
