import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: Stack(children: [back(), screen()])),
    );
  }

  back() => FlareActor('res/bg.flr', 
    alignment: Alignment.center, 
    fit: BoxFit.fitHeight, 
    animation: "run");
  
  screen() => Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(30),
    child: SingleChildScrollView(child: Screen()));
}

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Page page = LoadingPage();

  dynamic get data => page.data;

  _ScreenState() {
    Stream.periodic(Duration(seconds: 1)).listen((_) => send(Action.Tick));
    initScreen();
  }

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var sub = text.subtitle;
    var body = text.display1;
    var space = SizedBox(width: 20, height: 30);

    if (page is LoadingPage) return Text('loading');

    if (page is InitPage) return Column(children: [
      flare("res/hat.flr"),
      Text(data['rWelcome'], style: body,),
      Text(data['rRules'], style: sub,),
      btn(data['rReady']),
    ],);

    if (page is ReadyPage) return Column(children: [
      flare(page.teamRes()),
      Text(data['rPrepare${page.team}'], style: sub),
      space, btn(data['rReady']),
    ],);

    if (page is ScorePage) return Column(children: [
      Text(data['rScore'], style: text.display3),
      Text('Kitties: ${data['0']}', style: body),
      Text('Robots: ${data['1']}', style: body),
      space, RaisedButton(
        padding: EdgeInsets.all(30),
        child: Text(data['rAgain']),
        onPressed: initScreen),
    ],);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${page.time}', style: text.display4,),
        Text(page.word(), style: body),
        flare(page.teamRes()), space,
        Row( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [btn(data['rDone']), btn(data['rSkip'], color: Colors.red, action: Action.Skip)])
      ],
    );
  }

  Widget btn(title, {color = Colors.green, action = Action.Next}) => Padding(
    padding: EdgeInsets.zero, child: FlatButton(
      padding: EdgeInsets.all(20), color: color, onPressed: () => send(action),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Text(title)),
  );

  Widget flare(name) => Container(
    height: 200, child: FlareActor(name, 
    alignment: Alignment.topCenter, 
    fit: BoxFit.fitHeight, 
    animation: "run"),
  );

  send(Action action) => setState(() => page = page.consume(action));

  initScreen() => rootBundle
    .loadString('res/data.json')
    .then((data) => json.decode(data))
    .then((data) => InitPage(data))
    .then((initPage) => setState(() => page = initPage));
}
