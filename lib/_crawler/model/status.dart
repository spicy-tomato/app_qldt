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
  static CrawlerStatus fromStatusCode(int statusCode) {
    final Map<int, CrawlerStatus> map = {
      200: CrawlerStatus.ok,
      401: CrawlerStatus.invalidPassword,
      500: CrawlerStatus.serverError,
    };
    
    final CrawlerStatus? status = map[statusCode];
    
    return status ?? CrawlerStatus.unknown;
  }

  bool get isOk => this == CrawlerStatus.ok;

  bool get isFailed => this == CrawlerStatus.serverError;

  bool get isInvalidPassword => this == CrawlerStatus.invalidPassword;

  bool get isUnknown => this == CrawlerStatus.unknown;

  bool get hasErrorWhileCrawling => this == CrawlerStatus.errorWhileCrawling;
}
