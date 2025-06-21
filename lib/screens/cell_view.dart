import 'package:flutter/material.dart';

class CellView extends StatefulWidget {
  const CellView({super.key});

  @override
  State<CellView> createState() => _CellViewState();
}

class _CellViewState extends State<CellView> {
  Color _cellColor = Colors.white54;
  void _onClick(){
    setState(() {
      _cellColor = Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onClick,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(color: _cellColor),
      )
    );
  }
}