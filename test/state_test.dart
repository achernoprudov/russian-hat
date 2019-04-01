import 'package:flutter_test/flutter_test.dart';

import 'package:russian_hat/state.dart';

void main() {
  group('TimerState', () {
    var team = 0;
    TimerState state;

    setUp(() {
      final defaultData = {
        0: 0, // team0 result
        1: 0, // team1 result
        'words': ['foo', 'bar', 'dao', 'zin', 'cat', 'usa', 'ursa'],
      };

      state = TimerState(team, defaultData, defaultData['words']);
    });

    test(
        'adds one to current team score, removes first word' +
            ' and returns TimerState when consumes Action.Guess ' +
            ' and stil doesnt have words', () {
      var firstWord = state.word();
      var newState = state.consume(Action.Guess);

      expect(newState, isInstanceOf<TimerState>());
      expect(newState.data[team], equals(1));
      expect(newState.words, isNot(contains(firstWord)));
    });

    test(
        'returns ScoreState when consumes Action.Guess ' +
            ' and there are no words left', () {
      state.words = ['foo'];
      var newState = state.consume(Action.Guess);

      expect(newState, isInstanceOf<ScoreState>());
      expect(newState.data[team], equals(1));
    });

    test('shuffle words and return TimerState when consumes Action.Skip ', () {
      var firstWord = state.word();
      var newState = state.consume(Action.Skip);

      expect(newState, isInstanceOf<TimerState>());
      expect(newState.data[team], equals(0)); // same score
      expect(newState.word(), isNot(equals(firstWord)));
    }, retry: 3);

    test(
        'returns ReadyState when consumes Action.Timeout', () {
      var newState = state.consume(Action.Timeout);

      expect(newState, isInstanceOf<ReadyState>());
      expect(newState.data, equals(state.data));
      expect(newState.words, equals(state.words));
      expect(newState.team, equals(1)); // next team
    });
  });
  group('ReadyState', () {
    
    test('returns TimerState when consumes Action.Ready', () {
      var state = ReadyState(0, {}, ['foo']);

      var newState = state.consume(Action.Ready);

      expect(newState, isInstanceOf<TimerState>());
    });
  });
}
