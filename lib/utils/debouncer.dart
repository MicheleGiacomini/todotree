import 'dart:async';

class Debouncer {
  final Duration debounce;
  Timer? _timer;
  void Function()? _currentCallback;

  Debouncer({this.debounce = const Duration(milliseconds: 300)});

  void run(void Function() action) {
    _timer?.cancel();
    _currentCallback = action;
    _timer = Timer(debounce, action);
  }

  void complete() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
      _currentCallback?.call();
    }
  }
}
