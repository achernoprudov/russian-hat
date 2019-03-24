import 'package:flutter/material.dart';
import "package:flare_flutter/flare_actor.dart";

void main() => runApp(App());

dynamic data = {
  'rDone': 'Ez! We did it!',
  'rSkip': 'No, they cant :(',
  'words': ['Cat', 'Bat', 'Mat', 'Sad', 'Simplification'],
  'defRes': {'team1': 0, 'team2': 0}
};

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Home(Store(data['words'], data['defRes'])),
    );
  }
}

class Store {
  List<String> remains;
  dynamic result;
  Store(this.remains, this.result) {
    remains.shuffle();
  }
}

class Home extends StatelessWidget {
  final Store store;
  const Home(this.store);

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
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1), (i) => 10 - i),
            builder: (ctx, snp) {
              var tick = snp?.data ?? 60;
              print('tick' + store.result.toString());
              return Text(
                '$tick',
                style: text.display4,
              );
            },
          ),
          space,
          Text(
            '${store.remains[0]}',
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
        onPressed: () {
          store.result['team1'] += gotIt ? 1 : -1;
          print('some' + store.result['team1']);
        },
      ),
    );
  }
}
