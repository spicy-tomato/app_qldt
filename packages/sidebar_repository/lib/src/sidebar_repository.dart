import 'dart:async';

enum SidebarStatus { closed, opened }

extension SidebarStatusExtensions on SidebarStatus {
  bool get shouldClose => this == SidebarStatus.closed;

  bool get shouldOpen => this == SidebarStatus.opened;
}

class SidebarRepository {
  final _controller = StreamController<SidebarStatus>();

  Stream<SidebarStatus> get status async* {
    yield SidebarStatus.closed;
    yield* _controller.stream;
  }

  void open() {
    _controller.add(SidebarStatus.opened);
  }

  void close() {
    _controller.add(SidebarStatus.closed);
  }
}
