import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, Color, Colors, Container, EdgeInsets, GestureDetector, Padding, State, StatefulWidget, Widget;

class CellView extends StatefulWidget {
  final int index;
  const CellView({super.key, required this.index});
  @override
  State<CellView> createState() => _CellViewState();
}

class _CellViewState extends State<CellView> {
  Color _cellColor = Colors.white54;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onClick,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          color: _cellColor,
          child: Text("${widget.index}"),
          ),
      )
    );
  }
    void _onClick(){
    setState(() {
      _cellColor = Colors.transparent;
    });
  }
}