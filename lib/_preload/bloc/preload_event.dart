part of 'preload_bloc.dart';

abstract class PreloadEvent extends Equatable {
  const PreloadEvent();

  @override
  List<Object> get props => [];
}

class PreloadStatusChanged extends PreloadEvent {
  final PreloadStatus status;

  const PreloadStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class PreloadLoading extends PreloadEvent {}

class PreloadLoadingAfterLogin extends PreloadEvent {}
