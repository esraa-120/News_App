import 'package:flutter/material.dart';
import 'package:news_app/models/source_model.dart';

class TabBarItem extends StatelessWidget {

  final bool isSelected;
  final SourceModel sourceModel;
  const TabBarItem({super.key, required this.sourceModel, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      sourceModel.name,
      style: TextStyle(
        color: Colors.black,
        fontSize: isSelected ? 16 : 14,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
    );
  }
}
