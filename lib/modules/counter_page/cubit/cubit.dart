import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im/modules/counter_page/cubit/states.dart';

class CountrCubit extends Cubit<CounterStates> {
  CountrCubit() : super(initValue());

  static CountrCubit get(context) => BlocProvider.of(context);

  int counter = 6;

  void minus() {
    counter--;
    emit(minusValue(counter));
  }

  void plus() {
    counter++;
    emit(plusValue(counter));
  }
}
