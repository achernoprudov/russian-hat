import 'package:flutter/material.dart';
import 'package:russian_hat/src/screens/setup/models/team_ui_model.dart';
import 'package:russian_hat/src/widgets/selectable_grid_item.dart';

class TeamSetupPage extends StatefulWidget {
  @override
  _TeamSetupPageState createState() => _TeamSetupPageState();
}

class _TeamSetupPageState extends State<TeamSetupPage> {
  final List<TeamUiModel> models = TeamUiModel.defaultList();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemCount: models.length,
      itemBuilder: (context, index) {
        var uiModel = models[index];
        return SelectableGridItem(
          title: uiModel.name,
          iconData: uiModel.image,
          isSelected: uiModel.isSelected,
          onTap: () => _toggleSelection(uiModel),
        );
      },
    );
  }

  void _toggleSelection(TeamUiModel uiModel) {
    var selectedCount = models.where((model) => model.isSelected).length;
    // minimum 2 teams could be selected
    if (selectedCount == 2 && uiModel.isSelected) {
      return;
    }
    setState(() {
      uiModel.isSelected = !uiModel.isSelected;
    });
  }
}
