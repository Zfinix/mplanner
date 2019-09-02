// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodyFatResult.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$BodyFatResult on BodyFatResultBase, Store {
  final _$countAtom = Atom(name: 'BodyFatResultBase.count');

  @override
  double get count {
    _$countAtom.reportObserved();
    return super.count;
  }

  @override
  set count(double value) {
    _$countAtom.context.checkIfStateModificationsAreAllowed(_$countAtom);
    super.count = value;
    _$countAtom.reportChanged();
  }

  final _$textAtom = Atom(name: 'BodyFatResultBase.text');

  @override
  String get text {
    _$textAtom.reportObserved();
    return super.text;
  }

  @override
  set text(String value) {
    _$textAtom.context.checkIfStateModificationsAreAllowed(_$textAtom);
    super.text = value;
    _$textAtom.reportChanged();
  }

  final _$BodyFatResultBaseActionController =
      ActionController(name: 'BodyFatResultBase');

  @override
  void changeCount(double value) {
    final _$actionInfo = _$BodyFatResultBaseActionController.startAction();
    try {
      return super.changeCount(value);
    } finally {
      _$BodyFatResultBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeText(String value) {
    final _$actionInfo = _$BodyFatResultBaseActionController.startAction();
    try {
      return super.changeText(value);
    } finally {
      _$BodyFatResultBaseActionController.endAction(_$actionInfo);
    }
  }
}
