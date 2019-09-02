// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heightPickerM.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$HeightPickerM on HeightPickerMBase, Store {
  final _$startDragYOffsetAtom =
      Atom(name: 'HeightPickerMBase.startDragYOffset');

  @override
  double get startDragYOffset {
    _$startDragYOffsetAtom.reportObserved();
    return super.startDragYOffset;
  }

  @override
  set startDragYOffset(double value) {
    _$startDragYOffsetAtom.context
        .checkIfStateModificationsAreAllowed(_$startDragYOffsetAtom);
    super.startDragYOffset = value;
    _$startDragYOffsetAtom.reportChanged();
  }

  final _$startDragHeightAtom = Atom(name: 'HeightPickerMBase.startDragHeight');

  @override
  int get startDragHeight {
    _$startDragHeightAtom.reportObserved();
    return super.startDragHeight;
  }

  @override
  set startDragHeight(int value) {
    _$startDragHeightAtom.context
        .checkIfStateModificationsAreAllowed(_$startDragHeightAtom);
    super.startDragHeight = value;
    _$startDragHeightAtom.reportChanged();
  }

  final _$heightAtom = Atom(name: 'HeightPickerMBase.height');

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

  final _$HeightPickerMBaseActionController =
      ActionController(name: 'HeightPickerMBase');

  @override
  void changeStartDragYOffset(double value) {
    final _$actionInfo = _$HeightPickerMBaseActionController.startAction();
    try {
      return super.changeStartDragYOffset(value);
    } finally {
      _$HeightPickerMBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeHeight(int value) {
    final _$actionInfo = _$HeightPickerMBaseActionController.startAction();
    try {
      return super.changeHeight(value);
    } finally {
      _$HeightPickerMBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeStartDragHeight(int value) {
    final _$actionInfo = _$HeightPickerMBaseActionController.startAction();
    try {
      return super.changeStartDragHeight(value);
    } finally {
      _$HeightPickerMBaseActionController.endAction(_$actionInfo);
    }
  }
}
