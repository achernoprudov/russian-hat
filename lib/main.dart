import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 3,
      itemBuilder: (ctx, index) {
        return Container(
          height: 200,
          child: FlareActor("res/hat.flr",
              alignment: Alignment.topCenter,
              fit: BoxFit.fitHeight,
              animation: "run"),
        );
      },
    ));
  }
}
