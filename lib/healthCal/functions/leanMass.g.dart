// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leanMass.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$LeanMass on LeanMassBase, Store {
  final _$heightAtom = Atom(name: 'LeanMassBase.height');

  @override
  int get height {
    _$heightAtom.reportObserved();
    return super.height;
  }

  @override
  set height(int value) {
    _$heightAtom.context.checkIfStateModificationsAreAllowed(_$heightAtom);
    super.height = value;
    _$heightAtom.reportChanged();
  }

  final _$weightAtom = Atom(name: 'LeanMassBase.weight');

  @override
  int get weight {
    _$weightAtom.reportObserved();
    return super.weight;
  }

  @override
  set weight(int value) {
    _$weightAtom.context.checkIfStateModificationsAreAllowed(_$weightAtom);
    super.weight = value;
    _$weightAtom.reportChanged();
  }

  final _$genderAtom = Atom(name: 'LeanMassBase.gender');

  @override
  Gender get gender {
    _$genderAtom.reportObserved();
    return super.gender;
  }

  @override
  set gender(Gender value) {
    _$genderAtom.context.checkIfStateModificationsAreAllowed(_$genderAtom);
    super.gender = value;
    _$genderAtom.reportChanged();
  }

  final _$LeanMassBaseActionController = ActionController(name: 'LeanMassBase');

  @override
  void changeHeight(dynamic value) {
    final _$actionInfo = _$LeanMassBaseActionController.startAction();
    try {
      return super.changeHeight(value);
    } finally {
      _$LeanMassBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeWeight(dynamic value) {
    final _$actionInfo = _$LeanMassBaseActionController.startAction();
    try {
      return super.changeWeight(value);
    } finally {
      _$LeanMassBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeGender(Gender value) {
    final _$actionInfo = _$LeanMassBaseActionController.startAction();
    try {
      return super.changeGender(value);
    } finally {
      _$LeanMassBaseActionController.endAction(_$actionInfo);
    }
  }
}
