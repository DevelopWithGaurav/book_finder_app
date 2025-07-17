import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_formatters_and_converters.dart';

extension StringFormat on int {
  String get toCommaSeperatedString => NumberFormat('#,##0', 'en_US').format(this);
}

extension StringFormatOnDouble on double {
  String get toCommaSeperatedString => NumberFormat('#,##0', 'en_US').format(this);
}

extension CapExtension on String? {
  String get inCaps => isValid ? (this!.isNotEmpty ? '${this![0].toUpperCase()}${this!.substring(1)}' : '') : '';
  String get capitalizeFirstOfEach => isValid ? (this!.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ")) : '';
  bool get isValid => this != null && this!.isNotEmpty;
  bool get isNotValid => this == null || this!.isEmpty;
  bool get isEmail =>
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this!);
  bool get isNotEmail =>
      !(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this!));
  String get initials {
    if (isValid) {
      var list = this!.trim().split(' ');
      if (list.length > 1) {
        return (list.first.isValid ? list.first[0] : '') + (list.last.isValid ? list.last[0] : '');
      } else {
        return this![0];
      }
      // return (this!.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" "));
    } else {
      return '';
    }
  }

  String get getIfValid => isValid ? this! : '';
  String get removeAllWhitespace => isValid ? this!.replaceAll(' ', '') : this!;
  String get extension {
    String extension = isValid ? this!.split('/').last.split('.').last : '';
    if (extension.length > 5) {
      extension = 'jpg';
    }
    return extension;
  }

  String get url {
    if (isValid) {
      if (this!.startsWith('http') || this!.startsWith('https') || this!.startsWith('www.')) {
        return this!;
      } else {
        return 'https://$this';
      }
    }
    return '';
  }

  String get fileName {
    String extension = isValid ? this!.split('/').last : '';
    return extension;
  }
}

extension DateTimeExtensionNullable on DateTime? {
  bool get isNull {
    if (this == null) {
      return true;
    }
    return false;
  }

  bool get isNotNull {
    if (this != null) {
      return true;
    }
    return false;
  }
}

extension DateTimeExtension on DateTime {
  bool get isToday {
    return DateFormatters().dMy.format(this) == DateFormatters().dMy.format(getDateTime());
  }

  bool get isYesterday {
    return DateFormatters().dMy.format(this) == DateFormatters().dMy.format(getDateTime().subtract(const Duration(days: 1)));
  }

  int get getAge {
    return getDateTime().difference(this).inDays ~/ 365;
  }

  bool compareDate(date) {
    return DateFormatters().dMy.format(this) == DateFormatters().dMy.format(date);
  }

  String get getTimeIfToday {
    if (isNotNull) {
      if (isToday) {
        return 'Today';
      } else if (isYesterday) {
        return 'Yesterday';
      } else {
        return DateFormatters().dMy.format(this);
      }
    } else {
      return '';
    }
  }

  String get yMD => DateFormatters().yMD.format(this);
  String get yMDSlash => DateFormatters().yMDSlash.format(this);
  String get mD => DateFormatters().mD.format(this);
  String get dM => DateFormatters().dM.format(this);
  String get dMM => DateFormatters().dMM.format(this);
  String get dMySlash => DateFormatters().dMySlash.format(this);
  String get hMA => DateFormatters().hMA.format(this);
  String get hA => DateFormatters().hA.format(this);
  String get hMs => DateFormatters().hMs.format(this);
  String get ms => DateFormatters().ms.format(this);
  String get dMy => DateFormatters().dMy.format(this);
  // ignore: non_constant_identifier_names
  String get My => DateFormatters().My.format(this);
  String get dM2 => DateFormatters().dM2.format(this);
  String get eee => DateFormatters().eee.format(this);
  String get mmm => DateFormatters().mmm.format(this);
  String get dMyDash => DateFormatters().dMyDash.format(this);
  String get dMonthYear => DateFormatters().dMonthYear.format(this);
  String get dateTime => DateFormatters().dateTime.format(this);
  String get dayDMY => DateFormatters().dayDMY.format(this);
  String get dayDM => DateFormatters().dayDM.format(this);
  String get dayDateTime => DateFormatters().dayDateTime.format(this);
  String get dayString => DateFormatters().dayString.format(this);
  String get dayDate => DateFormatters().dayDate.format(this);
  String get dateDay => DateFormatters().dateDay.format(this);
  String get month => DateFormatters().month.format(this);
  String get date => DateFormatters().date.format(this);

  DateTime get dateOnly => DateTime(year, this.month, day);
}

extension Sum<T> on List<T> {
  int get getSum {
    var sum = 0.0;
    for (var element in this) {
      sum += int.parse("$element");
    }
    return sum.toInt();
  }

  T? get getFirstIfNotEmpty {
    if (isNotEmpty) {
      return first;
    }
    return null;
  }

  String get getNamesPlus {
    if (length > 3) {
      return '${sublist(0, 3).map((e) => e).toString().replaceAll('(', '').replaceAll(')', '')}+ ${length - 3} more';
    }
    return map((e) => e).toString().replaceAll('(', '').replaceAll(')', '');
  }

  String get commaSeparated {
    return toString().substring(1, toString().length - 1);
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

extension GetRequest on Map {
  String get convertGetResponseUrl {
    String url = '';
    for (int i = 0; i < keys.length; i++) {
      if (i == 0) {
        url += '?${keys.toList()[i]}=${this[keys.toList()[i]]}';
      } else {
        url += '&${keys.toList()[i]}=${this[keys.toList()[i]]}';
      }
    }
    return url;
  }
}

extension Context on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color get primaryColor => Theme.of(this).primaryColor;
  double get bottomViewInsets => MediaQuery.of(this).viewInsets.bottom;
// Color get primaryColor => Theme.of(this).copyWith();
}
