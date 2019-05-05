import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:russian_hat/src/screens/setup/models/duration_ui_model.dart';

class TimeSetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Stack(
      children: <Widget>[
        Text(
          'Select round duration',
          style: textTheme.display3,
        ),
        Center(
          child: CupertinoPicker.builder(
            itemExtent: 48,
            diameterRatio: 1.3,
            useMagnifier: false,
            backgroundColor: Colors.transparent,
            childCount: DurationUiModel.all.length,
            magnification: 1,
            itemBuilder: (context, index) {
              var model = DurationUiModel.all[index];
              return Container(
                alignment: Alignment.center,
                child: Text(
                  model.title,
                  style: textTheme.display1,
                ),
              );
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
