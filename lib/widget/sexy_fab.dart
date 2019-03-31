import 'package:flutter/material.dart';

/// A simple sexy FloatingActionButton
class SexyFab extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final String tooltip;
  final IconData icon;

  SexyFab({this.itemBuilder, this.tooltip, this.icon, this.itemCount});

  @override
  _SexyFabState createState() => _SexyFabState();
}

class _SexyFabState extends State<SexyFab> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget _toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'toggle',
        backgroundColor: _buttonColor.value,
        onPressed: _animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    if (index < 0 || index >= widget.itemCount) {
      throw new Exception(
          "index is negative or overflow, expected lower than ${widget.itemCount}, but actually is $index");
    }
    return widget.itemBuilder(context, index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List();
    for (int i = 0; i < widget.itemCount; i++) {
      Widget item = Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton.value * (widget.itemCount - i),
          0.0,
        ),
        child: widget.itemBuilder(context, i),
      );
      items.add(item);
    }
    items.add(_toggle());
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: items,
    );
  }
}
