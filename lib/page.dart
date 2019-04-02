enum Action { Next, Skip, Tick }

abstract class Page {
  int time;
  int team;
  dynamic data;
  List<String> words;
  Page(this.team, this.data, this.words, this.time);
  Page consume(Action action);

  String word() => words.first;
}

class InitPage extends Page {
  InitPage(data) : super(0, data, [], 0);

  @override
  consume(action) => action ==Action.Next ? ReadyPage(0, data, data['words']) : this;
}

class ReadyPage extends Page {
  ReadyPage(team, data, remains) : super(team, data, remains, 0);

  @override
  consume(action) => action == Action.Next ? TimerPage(team, data, words) : this;
}

class TimerPage extends Page {
  TimerPage(team, data, remains) : super(team, data, remains, 10);
  @override
  consume(action) {
    if (action == Action.Tick) {
      time--;
      if (time < 0) return ReadyPage(next(), data, words);
      return this;
    }
    if (action == Action.Next) {
      data['$team'] += 1;
      words.removeAt(0);
      if (words.isEmpty) {
        return ScorePage(data);
      }
      return this;
    }
    if (action == Action.Skip) {
      words.shuffle();
      return this;
    }
  }

  int next() => team ^ 1;
}

class ScorePage extends Page {
  ScorePage(data) : super(0, data, [], 0);

  @override
  consume(action) => action == Action.Next ? ReadyPage(0, data, words) : this;
}
