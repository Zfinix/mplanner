import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'pacmanSlider.g.dart';

class PacmanSliderController = PacmanSliderControllerBase
    with _$PacmanSliderController;

abstract class PacmanSliderControllerBase with Store {
  @observable
  double pacmanPosition = 24.0;

  @observable
  Animation<BorderRadius> bordersAnimation;

  @observable
  Animation<double> submitWidthAnimation;

  @observable
  AnimationController pacmanMovementController;
  
  @observable
  Animation<double> pacmanAnimation;

  @action
  void changePacmanPosition(value) {
    pacmanPosition = value;
  }

  @action
  void changeSubmitWidthAnimation(value) {
    submitWidthAnimation = value;
  }

  @action
  void changeBordersAnimation(value) {
    bordersAnimation = value;
  }

  @action
  void changePacmanAnimation(value) {
    pacmanAnimation = value;
  }

  @action
  void changePacmanMovementController(value) {
    pacmanMovementController = value;
  }
}
