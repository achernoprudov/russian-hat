import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:russian_hat/page.dart';

void main() => runApp(App());

final dynamic data = {
  0:0, 1:0,
  'rDone': 'Ez! We did it!',
  'rSkip': 'No, they cant :(',
  'words': ['Cat', 'Bat', 'Mat', 'Sad', 'Simplification'],
};

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Screen(data));
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
  _ScreenState(this.page);

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var space = SizedBox(width: 20, height: 30);

    if (page is ReadyPage) return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Command ${page.team}'),
          space,
          btn(true),
        ],
      ),
    );

    if (page is ScorePage) return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Horray!', style: text.display3),
          Text('Command 2 win!!!', style: text.display3),
          space,
          btn(true),
        ],
      ),
    );

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1), (i) => 10 - i),
            builder: (ctx, snp) {
              var tick = snp?.data ?? 60;
              return Text('$tick', style: text.display4,);
            },
          ),
          space,
          Text(page.word(), style: text.display3),
          space,
          Row(children: [btn(true), space, btn(false)])
        ],
      ),
    );
  }

  Widget btn(next) {
     return FlatButton(
        color: next ? Colors.green : Colors.red,
        padding: EdgeInsets.all(30),
        child: Text(next ? data['rDone'] : data['rSkip']),
        onPressed: () => send(next ? Action.Next : Action.Skip),
      );
  }

  send(Action action) => setState(() => page = page.consume(action));
}
