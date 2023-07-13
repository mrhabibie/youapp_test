import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'obscure_state.dart';

class ObscureCubit extends Cubit<bool> {
  ObscureCubit() : super(true);

  void toggle() => emit(!state);
}
