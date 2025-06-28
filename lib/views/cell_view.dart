import 'package:buscando_minas/logic/model.dart';
import 'package:flutter/material.dart';
import 'package:buscando_minas/assets.dart';
class CellView extends StatelessWidget {
  final Cell cell;

  const CellView({
    super.key,
    required this.cell,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: avoid_print
      onTap: (){},
      child: Image.asset(_imageForCell(cell)),
    );
  }


  String _imageForCell(Cell cell){
    if(cell is CellClosed){
      return Assets.cellClosed;
    }else{
      return Assets.openedCells[cell.content.index];
    }
  }


}