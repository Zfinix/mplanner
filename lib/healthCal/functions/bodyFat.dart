import 'package:mplanner/healthCal/model/gender.dart';
import 'package:mobx/mobx.dart';

part 'bodyFat.g.dart';

class BodyFat = BodyFatBase with _$BodyFat;

abstract class BodyFatBase with Store {
  
  @observable
  var height = 180;

  @observable
  var weight = 70;

  @observable
  var age = 18;

  @observable
  Gender gender = Gender.other;

  @action
  void changeHeight(value) {
    height = value;
  }

  @action
  void changeWeight(value) => weight = value;

  @action
  void changeAge(value) => age = value;

  @action
  void changeGender(Gender value) => gender = value;
}
