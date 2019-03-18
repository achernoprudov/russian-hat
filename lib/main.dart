import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:rxdart/rxdart.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  dynamic data = {
    'rDone' : 'Ez! We did it!',
    'rSkip' : 'No, they cant :(',
    'words': ['cat', 'bat', 'mat', 'sad'],
  };

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var space = SizedBox(
      width: 20,
      height: 30,
    );
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1), (i) => 60 - i),
            builder: (ctx, snp) {
              return Text(
                '${snp?.data ?? 60}',
                style: text.display4,
              );
            },
          ),
          space,
          Text(
            'Simplification',
            style: text.display3,
          ),
          space,
          Row(
            children: [
              btn(data['rDone'], true),
              space,
              btn(data['rSkip'], false),
            ],
          )
        ],
      ),
    ));
  }

  Widget btn(title, gotIt) {
    return Expanded(
      child: FlatButton(
        color: gotIt ? Colors.green : Colors.red,
        padding: EdgeInsets.all(30),
        child: Text(title),
        onPressed: () {},
      ),
    );
  }
}
