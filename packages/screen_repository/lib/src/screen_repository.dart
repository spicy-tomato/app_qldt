import 'dart:async';

import 'models/models.dart';

class ScreenRepository {
  final _controller = StreamController<ScreenPage>();

  void changeTab(ScreenPage newTab) {
    _controller.add(newTab);
  }
}
