// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacmanSlider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$PacmanSliderController on PacmanSliderControllerBase, Store {
  final _$pacmanPositionAtom =
      Atom(name: 'PacmanSliderControllerBase.pacmanPosition');

  @override
  double get pacmanPosition {
    _$pacmanPositionAtom.reportObserved();
    return super.pacmanPosition;
  }

  @override
  set pacmanPosition(double value) {
    _$pacmanPositionAtom.context
        .checkIfStateModificationsAreAllowed(_$pacmanPositionAtom);
    super.pacmanPosition = value;
    _$pacmanPositionAtom.reportChanged();
  }

  final _$bordersAnimationAtom =
      Atom(name: 'PacmanSliderControllerBase.bordersAnimation');

  @override
  Animation<BorderRadius> get bordersAnimation {
    _$bordersAnimationAtom.reportObserved();
    return super.bordersAnimation;
  }

  @override
  set bordersAnimation(Animation<BorderRadius> value) {
    _$bordersAnimationAtom.context
        .checkIfStateModificationsAreAllowed(_$bordersAnimationAtom);
    super.bordersAnimation = value;
    _$bordersAnimationAtom.reportChanged();
  }

  final _$submitWidthAnimationAtom =
      Atom(name: 'PacmanSliderControllerBase.submitWidthAnimation');

  @override
  Animation<double> get submitWidthAnimation {
    _$submitWidthAnimationAtom.reportObserved();
    return super.submitWidthAnimation;
  }

  @override
  set submitWidthAnimation(Animation<double> value) {
    _$submitWidthAnimationAtom.context
        .checkIfStateModificationsAreAllowed(_$submitWidthAnimationAtom);
    super.submitWidthAnimation = value;
    _$submitWidthAnimationAtom.reportChanged();
  }

  final _$pacmanMovementControllerAtom =
      Atom(name: 'PacmanSliderControllerBase.pacmanMovementController');

  @override
  AnimationController get pacmanMovementController {
    _$pacmanMovementControllerAtom.reportObserved();
    return super.pacmanMovementController;
  }

  @override
  set pacmanMovementController(AnimationController value) {
    _$pacmanMovementControllerAtom.context
        .checkIfStateModificationsAreAllowed(_$pacmanMovementControllerAtom);
    super.pacmanMovementController = value;
    _$pacmanMovementControllerAtom.reportChanged();
  }

  final _$pacmanAnimationAtom =
      Atom(name: 'PacmanSliderControllerBase.pacmanAnimation');

  @override
  Animation<double> get pacmanAnimation {
    _$pacmanAnimationAtom.reportObserved();
    return super.pacmanAnimation;
  }

  @override
  set pacmanAnimation(Animation<double> value) {
    _$pacmanAnimationAtom.context
        .checkIfStateModificationsAreAllowed(_$pacmanAnimationAtom);
    super.pacmanAnimation = value;
    _$pacmanAnimationAtom.reportChanged();
  }

  final _$PacmanSliderControllerBaseActionController =
      ActionController(name: 'PacmanSliderControllerBase');

  @override
  void changePacmanPosition(dynamic value) {
    final _$actionInfo =
        _$PacmanSliderControllerBaseActionController.startAction();
    try {
      return super.changePacmanPosition(value);
    } finally {
      _$PacmanSliderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSubmitWidthAnimation(dynamic value) {
    final _$actionInfo =
        _$PacmanSliderControllerBaseActionController.startAction();
    try {
      return super.changeSubmitWidthAnimation(value);
    } finally {
      _$PacmanSliderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBordersAnimation(dynamic value) {
    final _$actionInfo =
        _$PacmanSliderControllerBaseActionController.startAction();
    try {
      return super.changeBordersAnimation(value);
    } finally {
      _$PacmanSliderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePacmanAnimation(dynamic value) {
    final _$actionInfo =
        _$PacmanSliderControllerBaseActionController.startAction();
    try {
      return super.changePacmanAnimation(value);
    } finally {
      _$PacmanSliderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePacmanMovementController(dynamic value) {
    final _$actionInfo =
        _$PacmanSliderControllerBaseActionController.startAction();
    try {
      return super.changePacmanMovementController(value);
    } finally {
      _$PacmanSliderControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
