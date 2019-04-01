enum Action { Ready, Guess, Skip, Timeout }

abstract class State {
  State consume(Action action);
}

class InitState extends State {
  @override
  consume(action) {
    return null;
  }
}

class ReadyState extends State {
  @override
  consume(action) {
    return null;
  }
}

class TimerState extends State {
  int team;
  List<String> remains;
  dynamic result;

  @override
  consume(action) {
    if (action == Action.Timeout) return ReadyState();
    if (action == Action.Guess) return this;
    if (action == Action.Skip) return this;
    return null;
  }
}
