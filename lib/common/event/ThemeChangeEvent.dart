import 'package:event_bus/event_bus.dart';

class ThemeChangeEvent {
  final int color;

  ThemeChangeEvent(this.color);
}

class ThemeChangeHandle {
  static final EventBus eventBus = new EventBus();

  static themeChangeHandle(color) {
    eventBus.fire(new ThemeChangeEvent(color));
  }
}
