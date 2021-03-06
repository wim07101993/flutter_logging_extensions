import 'package:flutter/material.dart';
import 'package:flutter_logging_extensions/flutter_logging_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../faker_extensions.dart';

void main() {
  late Color? fakeDefault;
  late Color? fakeFinest;
  late Color? fakeFiner;
  late Color? fakeFine;
  late Color? fakeConfig;
  late Color? fakeInfo;
  late Color? fakeWarning;
  late Color? fakeSevere;
  late Color? fakeShout;

  late LogLevelToColorConverter converter;

  setUp(() {
    fakeDefault = faker.color();
    fakeFinest = faker.color();
    fakeFiner = faker.color();
    fakeFine = faker.color();
    fakeConfig = faker.color();
    fakeInfo = faker.color();
    fakeWarning = faker.color();
    fakeSevere = faker.color();
    fakeShout = faker.color();

    converter = LogLevelToColorConverter(
      defaultValue: fakeDefault,
      finest: fakeFinest,
      finer: fakeFiner,
      fine: fakeFine,
      config: fakeConfig,
      info: fakeInfo,
      warning: fakeWarning,
      severe: fakeSevere,
      shout: fakeShout,
    );
  });

  test('should be a [LogLevelConverter]', () {
    expect(converter, isA<LogLevelConverter<Color?>>());
  });

  group('constructor', () {
    test('should set the fields', () {
      expect(converter.defaultValue, fakeDefault);
      expect(converter.finest, fakeFinest);
      expect(converter.finer, fakeFiner);
      expect(converter.fine, fakeFine);
      expect(converter.config, fakeConfig);
      expect(converter.info, fakeInfo);
      expect(converter.warning, fakeWarning);
      expect(converter.severe, fakeSevere);
      expect(converter.shout, fakeShout);
    });

    test('should set values to defaults if not given', () {
      // act
      converter = const LogLevelToColorConverter();

      // assert
      expect(converter.finest, Colors.grey);
      expect(converter.finer, Colors.grey);
      expect(converter.fine, null);
      expect(converter.config, Colors.green);
      expect(converter.info, Colors.blue);
      expect(converter.warning, Colors.deepOrange);
      expect(converter.severe, Colors.red);
      expect(converter.shout, Colors.purple);
      expect(converter.defaultValue, null);
    });
  });
}
