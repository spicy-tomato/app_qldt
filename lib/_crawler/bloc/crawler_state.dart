part of 'crawler_bloc.dart';

class CrawlerState extends Equatable {
  final FormzStatus formStatus;
  final Password password;
  final bool hidePassword;
  final CrawlerStatus status;

  const CrawlerState({
    required this.formStatus,
    required this.password,
    required this.hidePassword,
    required this.status,
  });

  CrawlerState copyWith({
    FormzStatus? formStatus,
    Password? password,
    bool? hidePassword,
    CrawlerStatus? status,
  }) {
    return CrawlerState(
      formStatus: formStatus ?? this.formStatus,
      password: password ?? this.password,
      hidePassword: hidePassword ?? this.hidePassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        formStatus,
        password,
        hidePassword,
        status,
      ];
}

class CrawlerInitial extends CrawlerState {
  const CrawlerInitial()
      : super(
          formStatus: FormzStatus.pure,
          password: const Password.pure(),
          hidePassword: true,
          status: CrawlerStatus.unknown,
        );
}
