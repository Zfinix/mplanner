// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$BMI on BMIBase, Store {
  final _$heightAtom = Atom(name: 'BMIBase.height');

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

  final _$weightAtom = Atom(name: 'BMIBase.weight');

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

  final _$genderAtom = Atom(name: 'BMIBase.gender');

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

  final _$BMIBaseActionController = ActionController(name: 'BMIBase');

  @override
  void changeHeight(dynamic value) {
    final _$actionInfo = _$BMIBaseActionController.startAction();
    try {
      return super.changeHeight(value);
    } finally {
      _$BMIBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeWeight(dynamic value) {
    final _$actionInfo = _$BMIBaseActionController.startAction();
    try {
      return super.changeWeight(value);
    } finally {
      _$BMIBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeGender(Gender value) {
    final _$actionInfo = _$BMIBaseActionController.startAction();
    try {
      return super.changeGender(value);
    } finally {
      _$BMIBaseActionController.endAction(_$actionInfo);
    }
  }
}
