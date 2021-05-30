enum CrawlerStatus {
  ok,
  serverError,
  invalidPassword,
  unknown,
  validatingPassword,
  crawlingScore,
  crawlingExamSchedule,
  errorWhileCrawling,
}

extension CrawlerStatusExtension on CrawlerStatus {
  static CrawlerStatus fromString(String string) {
    switch (string) {
      case 'OK':
        return CrawlerStatus.ok;

      case 'Unknown':
        return CrawlerStatus.unknown;

      case 'Invalid Password':
        return CrawlerStatus.invalidPassword;

      default:
        return CrawlerStatus.failed;
    }
  }

  bool get isOk => this == CrawlerStatus.ok;

  bool get isFailed => this == CrawlerStatus.serverError;

  bool get isInvalidPassword => this == CrawlerStatus.invalidPassword;

  bool get isUnknown => this == CrawlerStatus.unknown;

  bool get hasErrorWhileCrawling => this == CrawlerStatus.errorWhileCrawling;
}
