import 'package:mypack/utils/time.dart';

enum Giorno {
  lunedi,
  martedi,
  mercoledi,
  giovedi,
  venerdi;

  @override
  String toString() {
    switch (this) {
      case lunedi:
        return 'Lunedì';
      case martedi:
        return 'Martedì';
      case mercoledi:
        return 'Mercoledì';
      case giovedi:
        return 'Giovedì';
      case venerdi:
        return 'Venerdì';
    }
  }

  String get short {
    switch (this) {
      case lunedi:
        return 'Lun';
      case martedi:
        return 'Mar';
      case mercoledi:
        return 'Mer';
      case giovedi:
        return 'Gio';
      case venerdi:
        return 'Ven';
    }
  }

  static List<Giorno> get valuesFromToday {
    var today = now.weekday;
    if (today > 5) {
      today = 0;
    }
    var vals = [
      for (var i = 0; i < values.length; i++)
        values[(i + today - 1) % values.length]
    ];
    return vals;
  }
}
