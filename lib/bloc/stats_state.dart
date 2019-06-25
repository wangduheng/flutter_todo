import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
@immutable
abstract class StatsState extends Equatable {
  StatsState({List prop = const []}) : super(prop);
}
class StatsLoading extends StatsState{

  @override
  String toString() {
    return 'StatsLoading{}';
  }
}


class StatsLoaded extends StatsState{
  final int numberActive;
  final int numberComplete;

  StatsLoaded(this.numberActive, this.numberComplete):super(prop:[numberActive,numberComplete]);

  @override
  String toString() {
    return 'StatsLoaded{numberActive: $numberActive, numberComplete: $numberComplete}';
  }


}