import 'package:buscando_minas/backend/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show BuildContext, Color, Colors, Container, EdgeInsets, GestureDetector, Padding, Widget;

class CellView extends StatelessWidget {
  final Cell cell;
  const CellView({super.key, required this.cell});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: imageForCell(cell)
    );
  }

  imageForCell(Cell cell) {
    if (cell is CellClosed){
      return cellClosedStyle();
    }else{
      return cellOpenedStyle();
    }
    
  }
}


  Center cellClosedStyle(){
    final Color cellColor = Colors.white54;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          color: cellColor,
          ),
      ),
    );
  }

  Center cellOpenedStyle(){
    Color openedColor = Colors.transparent;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          color: openedColor,
          ),
      ),
    );
  }