import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class CustomeSfLocalizationsVi extends SfLocalizationsVi {
  @override
  String get allowedViewDayLabel => r'Ngày';

  @override
  String get allowedViewMonthLabel => r'Tháng';

  @override
  String get allowedViewScheduleLabel => r'Lịch biểu';

  @override
  String get allowedViewTimelineDayLabel => r'Thời gian biểu ngày';

  @override
  String get allowedViewTimelineMonthLabel => r'Thời gian biểu tháng';

  @override
  String get allowedViewTimelineWeekLabel => r'Thời gian biểu tuần';

  @override
  String get allowedViewTimelineWorkWeekLabel => r'Thời gian biểu ngày làm việc';

  @override
  String get allowedViewWeekLabel => r'Tuần';

  @override
  String get allowedViewWorkWeekLabel => r'Ngày làm việc';

  @override
  String get daySpanCountLabel => r'Ngày';

  @override
  String get dhualhiLabel => r'Dhu al-Hijjah';

  @override
  String get dhualqiLabel => r'Dhu al-Qi' "'" r'dah';

  @override
  String get itemsDataPagerLabel => r'mục';

  @override
  String get jumada1Label => r'Jumada al-awwal';

  @override
  String get jumada2Label => r'Jumada al-thani';

  @override
  String get muharramLabel => r'Muharram';

  @override
  String get noEventsCalendarLabel => r'Không có sự kiện';

  @override
  String get noSelectedDateCalendarLabel => r'Không có ngày được chọn';

  @override
  String get ofDataPagerLabel => r'của';

  @override
  String get pagesDataPagerLabel => r'trang';

  @override
  String get pdfBookmarksLabel => r'Dấu trang';

  @override
  String get pdfEnterPageNumberLabel => r'Nhập số trang';

  @override
  String get pdfGoToPageLabel => r'Đi tới trang';

  @override
  String get pdfInvalidPageNumberLabel => r'Vui lòng nhập một số hợp lệ';

  @override
  String get pdfNoBookmarksLabel => r'Không tìm thấy dấu trang';

  @override
  String get pdfPaginationDialogCancelLabel => r'Huỷ bỏ';

  @override
  String get pdfPaginationDialogOkLabel => r'Đồng ý';

  @override
  String get pdfScrollStatusOfLabel => r'của';

  @override
  String get rabi1Label => r'Rabi ' "'" r'al-awwal';

  @override
  String get rabi2Label => r'Rabi ' "'" r'al-thani';

  @override
  String get rajabLabel => r'Rajab';

  @override
  String get ramadanLabel => r'Ramadan';

  @override
  String get safarLabel => r'Safar';

  @override
  String get shaabanLabel => r'Sha' "'" r'aban';

  @override
  String get shawwalLabel => r'Shawwal';

  @override
  String get shortDhualhiLabel => r'Dhu' "'" r'l-H';

  @override
  String get shortDhualqiLabel => r'Dhu' "'" r'l-Q';

  @override
  String get shortJumada1Label => r'Jum. I';

  @override
  String get shortJumada2Label => r'Jum. II';

  @override
  String get shortMuharramLabel => r'Muh.';

  @override
  String get shortRabi1Label => r'Rabi. I';

  @override
  String get shortRabi2Label => r'Rabi. II';

  @override
  String get shortRajabLabel => r'Raj.';

  @override
  String get shortRamadanLabel => r'Ram.';

  @override
  String get shortSafarLabel => r'Saf.';

  @override
  String get shortShaabanLabel => r'Sha.';

  @override
  String get shortShawwalLabel => r'Shaw.';

  @override
  String get todayLabel => r'Hôm nay';
}

class SfLocalizationsVnDelegate extends LocalizationsDelegate<SfLocalizations> {
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'vi';

  @override
  Future<SfLocalizations> load(Locale locale) {
    return SynchronousFuture<SfLocalizations>(CustomeSfLocalizationsVi());
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) => true;
}
