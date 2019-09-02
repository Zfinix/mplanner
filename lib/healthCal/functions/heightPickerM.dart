import 'package:mobx/mobx.dart';

part 'heightPickerM.g.dart';

class HeightPickerM = HeightPickerMBase with _$HeightPickerM;

abstract class HeightPickerMBase with Store {
  @observable
  double startDragYOffset;

  @observable
  int startDragHeight;

  @observable
  int height;

  @action
  void changeStartDragYOffset(double value) => startDragYOffset = value;

  @action
  void changeHeight(int value) => height = value;

  @action
  void changeStartDragHeight(int value) => startDragHeight = value;
}
