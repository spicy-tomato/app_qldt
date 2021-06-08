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

  const PreloadState.loaded({
    required String idAccount,
    required String idUser,
    required EventServiceController eventServiceController,
    required ScoreServiceController scoreServiceController,
    required NotificationServiceController notificationServiceController,
    required ExamScheduleServiceController examScheduleServiceController,
  }) : this(
          status: PreloadStatus.loaded,
          idAccount: idAccount,
          idUser: idUser,
          eventServiceController: eventServiceController,
          scoreServiceController: scoreServiceController,
          notificationServiceController: notificationServiceController,
          examScheduleServiceController: examScheduleServiceController,
        );

  @override
  List<Object> get props => [];
}

class PreloadInitial extends PreloadState {
  PreloadInitial() : super(status: PreloadStatus.loading);
}
