import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:russian_hat/src/screens/setup/models/team_ui_model.dart';
import 'package:russian_hat/src/widgets/selectable_grid_item.dart';

class SetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          FlareActor('res/bg.flr',
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              animation: "run"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: PageView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return _TeamSetupPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamSetupPage extends StatefulWidget {
  @override
  _TeamSetupPageState createState() => _TeamSetupPageState();
}

class _TeamSetupPageState extends State<_TeamSetupPage> {
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
