import 'package:flutter/material.dart';

class ExpandedSectionTds extends StatefulWidget {
  final Widget child;
  final int height;
  final bool expand;

  ExpandedSectionTds({
    this.expand = false,
    required this.child,
    required this.height,
  });

  @override
  _ExpandedSectionTdsState createState() => _ExpandedSectionTdsState();
}

class _ExpandedSectionTdsState extends State<ExpandedSectionTds>
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
  void didUpdateWidget(ExpandedSectionTds oldWidget) {
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
              ? 450
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
