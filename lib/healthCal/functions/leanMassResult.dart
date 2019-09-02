import 'package:mobx/mobx.dart';

part 'leanMassResult.g.dart';

class LeanMassResult = LeanMassResultBase with _$LeanMassResult;

abstract class LeanMassResultBase with Store {
  
  @observable
  double count = 0;

  @action
  void changeCount(double value) {
    count = value;
  }
}
