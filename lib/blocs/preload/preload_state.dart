part of 'preload_bloc.dart';

enum PreloadStatus {
  loadingAfterLogin,
  loading,
  loaded,
}

extension PreloadStatusExtension on PreloadStatus {
  bool get isLoadingAfterLogin => this == PreloadStatus.loadingAfterLogin;

  bool get isLoading => this == PreloadStatus.loading;

  bool get isLoaded => this == PreloadStatus.loaded;
}

class PreloadState extends Equatable {
  final PreloadStatus status;
  final String? idAccount;
  final String? idUser;
  final EventServiceController? eventServiceController;
  final ScoreServiceController? scoreServiceController;
  final NotificationServiceController? notificationServiceController;
  final ExamScheduleServiceController? examScheduleServiceController;

  const PreloadState({
    required this.status,
    this.idAccount,
    this.idUser,
    this.eventServiceController,
    this.scoreServiceController,
    this.notificationServiceController,
    this.examScheduleServiceController,
  });

  PreloadState copyWith({
    PreloadStatus? status,
    String? idAccount,
    String? idUser,
    EventServiceController? eventServiceController,
    ScoreServiceController? scoreServiceController,
    NotificationServiceController? notificationServiceController,
    ExamScheduleServiceController? examScheduleServiceController,
  }) {
    return PreloadState(
      status: status ?? this.status,
      idAccount: idAccount ?? this.idAccount,
      idUser: idUser ?? this.idUser,
      eventServiceController: eventServiceController ?? this.eventServiceController,
      scoreServiceController: scoreServiceController ?? this.scoreServiceController,
      notificationServiceController: notificationServiceController ?? this.notificationServiceController,
      examScheduleServiceController: examScheduleServiceController ?? this.examScheduleServiceController,
    );
  }

  const PreloadState.loading() : this(status: PreloadStatus.loading);

  const PreloadState.loadingAfterLogin() : this(status: PreloadStatus.loadingAfterLogin);

  PreloadState.loaded(UserDataModel userDataModel)
      : this(
          status: PreloadStatus.loaded,
          idAccount: userDataModel.uuidAccount,
          idUser: userDataModel.idUser,
          eventServiceController: userDataModel.eventServiceController,
          scoreServiceController: userDataModel.scoreServiceController,
          notificationServiceController: userDataModel.notificationServiceController,
          examScheduleServiceController: userDataModel.examScheduleServiceController,
        );

  @override
  List<Object> get props => [];
}

class PreloadInitial extends PreloadState {
  const PreloadInitial() : super(status: PreloadStatus.loading);
}
