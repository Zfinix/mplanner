// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodyFat.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$BodyFat on BodyFatBase, Store {
  final _$heightAtom = Atom(name: 'BodyFatBase.height');

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

  final _$weightAtom = Atom(name: 'BodyFatBase.weight');

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

  final _$ageAtom = Atom(name: 'BodyFatBase.age');

  @override
  int get age {
    _$ageAtom.reportObserved();
    return super.age;
  }

  @override
  set age(int value) {
    _$ageAtom.context.checkIfStateModificationsAreAllowed(_$ageAtom);
    super.age = value;
    _$ageAtom.reportChanged();
  }

  final _$genderAtom = Atom(name: 'BodyFatBase.gender');

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

  final _$BodyFatBaseActionController = ActionController(name: 'BodyFatBase');

  @override
  void changeHeight(dynamic value) {
    final _$actionInfo = _$BodyFatBaseActionController.startAction();
    try {
      return super.changeHeight(value);
    } finally {
      _$BodyFatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeWeight(dynamic value) {
    final _$actionInfo = _$BodyFatBaseActionController.startAction();
    try {
      return super.changeWeight(value);
    } finally {
      _$BodyFatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeAge(dynamic value) {
    final _$actionInfo = _$BodyFatBaseActionController.startAction();
    try {
      return super.changeAge(value);
    } finally {
      _$BodyFatBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeGender(Gender value) {
    final _$actionInfo = _$BodyFatBaseActionController.startAction();
    try {
      return super.changeGender(value);
    } finally {
      _$BodyFatBaseActionController.endAction(_$actionInfo);
    }
  }
}
