enum Action { Ready, Guess, Skip, Timeout }

abstract class State {
  int team;
  dynamic data;
  List<String> words;
  State(this.team, this.data, this.words);
  State consume(Action action);

  String word() => words.first;
}

class ScoreState extends State {
  ScoreState(data) : super(0, data, []);

  @override
  State consume(Action action) {
    return ReadyState(0, data, words);
  }
}

class ReadyState extends State {
  ReadyState(team, data, remains) : super(team, data, remains);

  @override
  consume(action) {
    return TimerState(team, data, words);
  }
}

class TimerState extends State {
  TimerState(team, data, remains) : super(team, data, remains);
  @override
  consume(action) {
    if (action == Action.Timeout) return ReadyState(next(), data, words);
    if (action == Action.Guess) {
      data[team] += 1;
      words.removeAt(0);
      if (words.isEmpty) {
        return ScoreState(data);
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
