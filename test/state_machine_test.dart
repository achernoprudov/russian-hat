import 'package:flutter_test/flutter_test.dart';

import 'package:russian_hat/page.dart';

void main() {
  group('InitPage', () {
    InitPage page;

    setUp(() {
      page = InitPage({'words': []});
    });

    test('returns RulesPage if consumes Action.Rules', () {
      var newPage = page.consume(Action.Rules);

      expect(newPage, isInstanceOf<RulesPage>());
    });

    test('returns ReadyPage if consumes Action.Next', () {
      var newPage = page.consume(Action.Next);

      expect(newPage, isInstanceOf<ReadyPage>());
    });

    test('returns self if consumes Action.Tick', () {
      var newPage = page.consume(Action.Tick);

      expect(newPage, equals(page));
    });
  });

  group('RulesPage', () {
    RulesPage page;

    setUp(() {
      page = RulesPage({'words': []});
    });

    test('returns InitPage if consumes Action.Next', () {
      var newPage = page.consume(Action.Next);

      expect(newPage, isInstanceOf<InitPage>());
    });

    test('returns self if consumes Action.Tick', () {
      var newPage = page.consume(Action.Tick);

      expect(newPage, equals(page));
    });
  });

  group('ReadyPage', () {
    ReadyPage page;

    setUp(() {
      page = ReadyPage(0, {}, ['foo']);
    });

    test('returns TimerPage when consumes Action.Next', () {
      var newPage = page.consume(Action.Next);

      expect(newPage, isInstanceOf<TimerPage>());
    });

    test('returns self if consumes Action.Tick', () {
      var newPage = page.consume(Action.Tick);

      expect(newPage, equals(page));
    });
  });

  group('TimerPage', () {
    var team = 0;
    TimerPage page;

    setUp(() {
      final defaultData = {
        '0': 0, // team0 result
        '1': 0, // team1 result
        'words': ['foo', 'bar', 'dao', 'zin', 'cat', 'usa', 'ursa'],
      };

      page = TimerPage(team, defaultData, defaultData['words']);
    });

    test(
        'adds one to current team score, removes first word' +
            ' and returns TimerPage when consumes Action.Guess ' +
            ' and stil doesnt have words', () {
      var firstWord = page.word();
      var newPage = page.consume(Action.Next);

      expect(newPage, isInstanceOf<TimerPage>());
      expect(newPage.data['$team'], equals(1));
      expect(newPage.words, isNot(contains(firstWord)));
    });

    test(
        'returns ScorePage when consumes Action.Guess ' +
            ' and there are no words left', () {
      page.words = ['foo'];
      var newPage = page.consume(Action.Next);

      expect(newPage, isInstanceOf<ScorePage>());
      expect(newPage.data['$team'], equals(1));
    });

    test('shuffle words and return TimerPage when consumes Action.Skip ', () {
      var firstWord = page.word();
      var newPage = page.consume(Action.Skip);

      expect(newPage, isInstanceOf<TimerPage>());
      expect(newPage.data['$team'], equals(0)); // same score
      expect(newPage.word(), isNot(equals(firstWord)));
    }, retry: 3);

    test('returns self when consumes Action.Tick', () {
      var oldTime = page.time;
      var newPage = page.consume(Action.Tick);

      expect(newPage, isInstanceOf<TimerPage>());
      expect(newPage.time, lessThan(oldTime));
    });

    test('returns ReadyPage when consumes enought Action.Tick', () {
      var actions = List.generate(page.time + 1, (_) => Action.Tick);
      Page newPage = page;
      for (var action in actions) {
        newPage = page.consume(action);
      }

      expect(newPage, isInstanceOf<ReadyPage>());
      expect(newPage.data, equals(page.data));
      expect(newPage.words, equals(page.words));
      expect(newPage.team, equals(1)); // next team
    });
  });

  group('ScorePage', () {
    ScorePage page;

    setUp(() {
      page = ScorePage({});
    });

    test('returns self if consumes Action.Tick', () {
      var newPage = page.consume(Action.Tick);

      expect(newPage, equals(page));
    });
  });
}
