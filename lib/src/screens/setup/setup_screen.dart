import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:russian_hat/src/screens/setup/pages/team_setup_page.dart';
import 'package:russian_hat/src/screens/setup/pages/time_setup_page.dart';

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
              itemCount: 2,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0: return TeamSetupPage();
                  case 1: return TimeSetupPage();
                  default: return Text('error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

