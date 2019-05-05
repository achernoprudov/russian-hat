import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:russian_hat/src/screens/setup/models/duration_ui_model.dart';

class SetupTimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        Text(
          'Select round duration',
          style: textTheme.display2,
        ),
        Center(
          child: CupertinoPicker.builder(
            itemExtent: 8,
            childCount: DurationUiModel.all.length,
            itemBuilder: (context, index) {
              var model = DurationUiModel.all[index];
              return Text(model.title);
            },
            onSelectedItemChanged: (int value) {
              //TODO change delegate
            },
          ),
        )
      ],
    );
  }
}
