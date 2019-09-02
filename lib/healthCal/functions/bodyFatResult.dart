import 'package:mobx/mobx.dart';

part 'bodyFatResult.g.dart';

class BodyFatResult = BodyFatResultBase with _$BodyFatResult;

abstract class BodyFatResultBase with Store {
 
  @observable
  double count = 0;
  
  @observable
  String text = '';

  @action
  void changeCount(double value) => count = value;

  @action
  void changeText(String value) => text = value;
  
}
