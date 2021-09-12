part of 'schedule_bloc.dart';

class ScheduleState extends Equatable {
  final UserDataSourceModel sourceModel;

  const ScheduleState(this.sourceModel);

  @override
  List<Object?> get props => [sourceModel];
}

class ScheduleInitial extends ScheduleState {
  ScheduleInitial() : super(UserDataSourceModel(<UserEventModel>[]));
}
