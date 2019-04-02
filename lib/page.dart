enum Action { Next, Skip, Timeout }

abstract class Page {
  int team;
  dynamic data;
  List<String> words;
  Page(this.team, this.data, this.words);
  Page consume(Action action);

  String word() => words.first;
}

class ScorePage extends Page {
  ScorePage(data) : super(0, data, []);

  @override
  consume(action) {
    return ReadyPage(0, data, words);
  }
}

class ReadyPage extends Page {
  ReadyPage(team, data, remains) : super(team, data, remains);

  @override
  consume(action) {
    return TimerPage(team, data, words);
  }
}

class TimerPage extends Page {
  TimerPage(team, data, remains) : super(team, data, remains);
  @override
  consume(action) {
    if (action == Action.Timeout) return ReadyPage(next(), data, words);
    if (action == Action.Next) {
      data[team] += 1;
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
