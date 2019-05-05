import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:russian_hat/src/screens/setup/setup_screen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          FlareActor('res/bg.flr',
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              animation: "run"),
          StartScreenContainer(),
        ],
      ),
    );
  }
}

class StartScreenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Start game'),
        onPressed: () {
          var routeBuilder = PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (context, _, secondaryAnimation) => SetupScreen());
          Navigator.of(context).push(routeBuilder);
        },
      ),
    );
  }
}
