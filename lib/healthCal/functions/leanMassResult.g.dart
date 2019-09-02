// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leanMassResult.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$LeanMassResult on LeanMassResultBase, Store {
  final _$countAtom = Atom(name: 'LeanMassResultBase.count');

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

  final _$LeanMassResultBaseActionController =
      ActionController(name: 'LeanMassResultBase');

  @override
  void changeCount(double value) {
    final _$actionInfo = _$LeanMassResultBaseActionController.startAction();
    try {
      return super.changeCount(value);
    } finally {
      _$LeanMassResultBaseActionController.endAction(_$actionInfo);
    }
  }
}
