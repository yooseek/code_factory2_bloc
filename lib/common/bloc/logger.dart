import 'package:flutter_bloc/flutter_bloc.dart';

class Logger extends BlocObserver {

  @override
  void onChange(BlocBase bloc, Change change) {
    print('[Bloc Change] Bloc : $bloc / Change : $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('[Bloc Transition] Bloc : $bloc / Transition : $transition');
  }

  @override
  void onCreate(BlocBase bloc) {
    print('[Bloc Create] Bloc : $bloc / Value : ${bloc.state}');
  }
}