import 'package:mplanner/healthCal/model/gender.dart';
import 'package:mobx/mobx.dart';

part 'bmi.g.dart';

class BMI = BMIBase with _$BMI;

abstract class BMIBase with Store {
  
  @observable
  var height = 180;

  @observable
  var weight = 70;

  @observable
  Gender gender = Gender.other;

  @action
  void changeHeight(value) => height = value;

  @action
  void changeWeight(value) => weight = value;

  @action
  void changeGender(Gender value) => gender = value;
}
