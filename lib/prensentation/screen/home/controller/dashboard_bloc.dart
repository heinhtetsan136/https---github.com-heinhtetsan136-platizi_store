import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_app/prensentation/screen/home/controller/dashboard_event.dart';
import 'package:platzi_app/prensentation/screen/home/controller/dashboard_state.dart';

class DashboardNavigationBloc
    extends Bloc<DashboardNavigationEvent, DashboardNavigationState> {
  DashboardNavigationBloc(super.initialState) {
    on<DashboardNavigationEvent>((event, emit) {
      emit(DashboardNavigationState(event.i));
    });
  }
}
