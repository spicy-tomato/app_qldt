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
  const CrawlerPasswordVisibleChanged();
}

class CrawlerResetStatus extends CrawlerEvent {
  const CrawlerResetStatus();
}

class CrawlerSubmitted extends CrawlerEvent {
  const CrawlerSubmitted();
}
