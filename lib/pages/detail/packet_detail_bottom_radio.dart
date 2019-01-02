import 'package:flutter/material.dart';

typedef Widget RadioItemBuilder(int position);
typedef OnRadioSelect(int position);
typedef OnRadioReselect(int position);

class PacketDetailBottomRadioGroup extends StatefulWidget {
  final int length;
  final int selected;
  final RadioItemBuilder radioBuilder;
  final OnRadioSelect onRadioSelect;
  final OnRadioReselect onRadioReselect;

  const PacketDetailBottomRadioGroup(
      {Key key,
      length,
      selected,
      this.onRadioSelect,
      this.onRadioReselect,
      this.radioBuilder})
      : length = length ?? 0,
        selected = selected != null
            ? (selected < 0 ? 0 : (selected < length ? selected : length - 1))
            : 0,
        assert(radioBuilder != null),
        super(key: key);

  @override
  _PacketDetailBottomRadioGroupState createState() =>
      _PacketDetailBottomRadioGroupState();
}

class _PacketDetailBottomRadioGroupState
    extends State<PacketDetailBottomRadioGroup> {
  int _current = 0;
  int _last = 0;

  @override
  void initState() {
    super.initState();

    _current = widget.selected;
    _last = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: _buildRadios(),
      ),
    );
  }

  List<Widget> _buildRadios() {
    if (widget.length == 0) {
      return List(0);
    }
    var list = List<Widget>();
    for (int i = 0; i < widget.length; i++) {
      Widget radio = _buildRadio(i);
      list.add(radio);
    }
    return list;
  }

  Widget _buildRadio(int position) {
    return Expanded(
        child: InkWell(
      onTap: () {
        int temp = this._current;
        setState(() {
          this._current = position;
        });
        widget?.onRadioSelect(position);
        if (_last == position) {
          widget?.onRadioReselect(position);
        } else {
          _last = temp;
        }
      },
      child: Container(
        color: position == _current ? Colors.white : Colors.grey.withAlpha(80),
        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 8),
        child: Center(child: widget.radioBuilder(position)),
      ),
    ));
  }
}
