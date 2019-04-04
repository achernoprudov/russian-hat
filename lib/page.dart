enum Action { Next, Skip, Tick, Rules }

abstract class Page {
  int time;
  int team;
  dynamic data;
  List<String> words;
  Page(this.team, this.data, this.words, this.time);
  Page consume(Action action);

  String word() => words.first;
  String teamRes() => 'res/${team == 0 ? 'cat' : 'robot'}.flr';
}

class LoadingPage extends Page {
  LoadingPage() : super(0, {}, [], 0);
  @override
  Page consume(Action action) => this;
}

class RulesPage extends Page {
  RulesPage(data) : super(0, data, [], 0);
  @override
  consume(action) => action == Action.Next ? InitPage(data) : this;
}

class InitPage extends Page {
  InitPage(data) : super(0, data, [], 0);
  @override
  consume(action) {
    if (action == Action.Next) return ReadyPage(0, data, List<String>.from(data['words']));
    if (action == Action.Rules) return RulesPage(data);
    return this;
  }
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
      return time < 0 ? ReadyPage(team ^ 1, data, words) : this;
    }
    if (action == Action.Next) {
      data['$team'] += 1;
      words.removeAt(0);
      return words.isEmpty ? ScorePage(data) : this;
    }
    if (action == Action.Skip) {
      words.shuffle();
    }
    return this;
  }
}

class ScorePage extends Page {
  ScorePage(data) : super(0, data, [], 0);
  @override
  consume(action) => action == Action.Next ? ReadyPage(0, data, words) : this;
}
