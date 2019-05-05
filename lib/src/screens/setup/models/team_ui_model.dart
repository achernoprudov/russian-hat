import 'package:flutter/material.dart';

class TeamUiModel {
  final String name;
  final IconData image;
  bool isSelected = false;

  TeamUiModel(this.name, this.image, this.isSelected);

  static List<TeamUiModel> defaultList() {
    return [
      TeamUiModel('Cats', Icons.ac_unit, true),
      TeamUiModel('Zombie', Icons.accessible, true),
      TeamUiModel('Ninjas', Icons.accessibility, false),
      TeamUiModel('Rotots', Icons.adb, false),
    ];
  }
}