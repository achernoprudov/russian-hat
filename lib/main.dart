import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:russian_hat/page.dart';

void main() => runApp(App());

final dynamic data = {
  0:0, 1:0,
  'rPrepare0': 'You are cute kitties team and only you can fight these bold puppies!\n\nPress the button when you ready!',
  'rPrepare1': 'You are brave puppies team and there is your chance to show who is boss there!\n\nPress the button when you ready!',
  'rScore': 'Score',
  'rRules': 'Hi there! It is russian hat!\nIts team game where you have to bla-bla.\ndfd\ndfd\ndfd\ndfd\ndfd\ndfd\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n\ndfd\ndfd\ndfd\n',
  'rAgain': 'It was fun. We want more!',
  'rReady': 'We are ready! Let\'s rock!',
  'rDone': 'Ez! We did it!',
  'rSkip': 'No, they cant :(',
  'words': ['Cat', 'Bat', 'Mat', 'Sad', 'Simplification', 'Foo', 'Bar', 'Zoo'],
};

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Screen(data),
        ))),
    );
  }
}

class Screen extends StatefulWidget {
  dynamic data;
  Screen(this.data);
  @override
  _ScreenState createState() => _ScreenState(InitPage(data));
}

class _ScreenState extends State<Screen> {
  Page page;
  _ScreenState(this.page) {
    Stream.periodic(Duration(seconds: 1)).listen((_) => send(Action.Tick));
  }

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var sub = text.headline;
    var body = text.display2;
    var head = text.display4;
    var space = SizedBox(width: 20, height: 30);

    if (page is InitPage) return Column(children: [
      flare("res/hat.flr"),
      Text(data['rRules'], style: sub,),
      btn(true, data['rReady']),
    ],);

    if (page is ReadyPage) return Column(children: [
      Text(data['rPrepare${page.team}'], style: sub),
      space,
      btn(true, data['rReady']),
    ],);

    if (page is ScorePage) return Column(children: [
      Text(data['rScore'], style: head),
      space,
      Text('Kitties: ${data[0]}', style: body),
      Text('Puppies: ${data[1]}', style: body),
      space,
      btn(true, data['rAgain']),
    ],);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${page.time}', style: head,),
        space,
        Text(page.word(), style: body),
        space,
        Row(children: [btn(true, data['rDone']), space, btn(false, data['rSkip'])])
      ],
    );
  }

  Widget btn(next, title) => FlatButton(
    color: next ? Colors.green : Colors.red,
    padding: EdgeInsets.all(30),
    child: Text(title),
    onPressed: () => send(next ? Action.Next : Action.Skip),
  );

  Widget flare(name) => Container(
    height: 200, child: FlareActor(name, 
    alignment: Alignment.topCenter, 
    fit: BoxFit.fitHeight, 
    animation: "run"),
  );

  send(Action action) => setState(() => page = page.consume(action));
}
