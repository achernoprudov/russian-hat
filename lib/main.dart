import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:russian_hat/page.dart';

void main() => runApp(App());

final dynamic data = {
  0:0, 1:0,
  'rPrepare0': 'You are cute kitties and only you can fight these bold puppies!\n\nPress the button when you ready!',
  'rPrepare1': 'You are brave puppies and there is your chance to show who is boss there!\n\nPress the button when you ready!',
  'rScore': 'Score',
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Screen(data)],
        ))),
    );
  }
}

class Screen extends StatefulWidget {
  dynamic data;
  Screen(this.data);
  @override
  _ScreenState createState() => _ScreenState(ReadyPage(0, data, data['words']));
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

    if (page is ReadyPage) return Column(
      children: [
        Text(data['rPrepare${page.team}'], style: sub),
        space,
        btn(true, data['rReady']),
      ],
    );

    if (page is ScorePage) return Column(
      children: [
        Text(data['rScore'], style: head),
        space,
        Text('Kitties: ${data[0]}', style: body),
        Text('Puppies: ${data[1]}', style: body),
        space,
        btn(true, data['rAgain']),
      ],
    );

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

  Widget btn(next, title) {
     return FlatButton(
        color: next ? Colors.green : Colors.red,
        padding: EdgeInsets.all(30),
        child: Text(title),
        onPressed: () => send(next ? Action.Next : Action.Skip),
      );
  }

  send(Action action) => setState(() => page = page.consume(action));
}
