import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:audioplayers/audio_cache.dart';
import 'package:russian_hat/src/screens/start/start_screen.dart';
import 'page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(_) => MaterialApp(
    theme: ThemeData.dark(),
    home: StartScreen(),
  );

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
  ScreenState createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  Page page = LoadingPage();

  dynamic get data => page.data;

  ScreenState() {
    AudioCache().loop('song.m4a');
    Stream.periodic(Duration(seconds: 1)).listen((_) => send(Action.Tick));
    initScreen();
  }

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var sub = text.subtitle;
    var head = text.display1;
    var space = SizedBox(width: 20, height: 30);

    if (page is LoadingPage) return Text('loading');

    if (page is RulesPage) return Column(children: [
      Text('Rules', style: head,),
      Text(data['rRules'], style: sub,),
      btn(data['rBack']),
    ],);

    if (page is InitPage) return Column(children: [
      flare("res/hat.flr"), Text(data['rWelcome'], style: head,),
      row([btn(data['rPlay']), btn(data['rToRules'], action: Action.Rules)])
    ],);

    if (page is ReadyPage) return Column(children: [
      flare(page.teamRes()),
      Text(data['rPrepare${page.team}'], style: sub),
      space, btn(data['rReady']),
    ],);

    if (page is ScorePage) return Column(children: [
      Text(data['rScore'], style: text.display3),
      Text('Kitties: ${data['0']}', style: head),
      Text('Robots: ${data['1']}', style: head),
      space, RaisedButton(
        child: Text(data['rAgain']),
        onPressed: initScreen),
    ],);

    return Column(
      children: [
        Text('${page.time}', style: text.display4,),
        Text(page.word(), style: head),
        flare(page.teamRes()), space,
        row([btn(data['rDone']), btn(data['rSkip'], color: Colors.red, action: Action.Skip)])
      ],
    );
  }

  btn(title, {color = Colors.green, action = Action.Next}) => Padding(
    padding: EdgeInsets.zero, child: FlatButton(
      padding: EdgeInsets.all(20), color: color, onPressed: () => send(action),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Text(title)),
  );

  flare(name) => Container(
    height: 200, child: FlareActor(name, 
    alignment: Alignment.topCenter, 
    fit: BoxFit.fitHeight, 
    animation: "run"),
  );

  row(List<Widget> items) => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items);

  send(Action action) => setState(() => page = page.consume(action));

  initScreen() => rootBundle
    .loadString('res/data.json')
    .then(json.decode)
    .then((data) => InitPage(data))
    .then((initPage) => setState(() => page = initPage));
}
