part of 'crawler_bloc.dart';

abstract class CrawlerEvent extends Equatable {
  const CrawlerEvent();

  @override
  List<Object> get props => [];
}

class CrawlerPasswordChanged extends CrawlerEvent {
  final String password;

  const CrawlerPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class CrawlerPasswordVisibleChanged extends CrawlerEvent {
  final bool? hidePassword;

  const CrawlerPasswordVisibleChanged({this.hidePassword});

  @override
  List<Object> get props => [hidePassword!];
}

class CrawlerResetStatus extends CrawlerEvent {}

class CrawlerSubmitted extends CrawlerEvent {}

class CrawlerDownload extends CrawlerEvent {}
