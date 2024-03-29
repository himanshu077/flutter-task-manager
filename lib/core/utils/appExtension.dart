import 'package:flutter/material.dart';

import '../../components/coreWidgets/AppDialog.dart';
import '../../components/coreWidgets/AppLoader.dart';
import '../../components/widgets/dialog/FailureMessageDialog.dart';
import '../errors/failure.dart';

extension NavigatorExtn on BuildContext {
  // navigate to next screen
  void pushNavigator(Widget screen) => Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => screen,
      ));

  // push and replace ......
  void replaceNavigator(Widget screen) => Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => screen,
      ));

  // clear stack and navigate to screen....
  void pushAndClearNavigator(Widget screen) => Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);

  //pop back...
  void pop() => Navigator.pop(this);
}

extension AppStateExtn on BuildContext {
// show progress loader....
  void get load => appLoader(this);

// close progressLoader or dialog .....
  void get stopLoader => Navigator.of(this, rootNavigator: false).pop('dialog');

  Future<DateTime?> get datePicker {
    return showDatePicker(
        context: this,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(3000));
  }

  Future<TimeOfDay?> get timePicker {
    return showTimePicker(
        context: this,
        initialTime: TimeOfDay.now(),
        builder: (context, child) => MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child!,
            ));
  }

// show popup dialog ....
//   void openDialog(Widget child,{bool barrierDismissible = true}) => appDialog(this, child,barrierDismissible: barrierDismissible);

  // show popup dialog ....
  void openFailureDialog(String message) => appDialog(
      this,
      FailureMessageDialog(
        message: message,
        onTap: () {
          stopLoader;
        },
        dismiss: () {
          stopLoader;
        },
      ));

  // show bottom sheet  ....
  // void openBottomSheet(Widget child) => appBSheet(this,child);

// check whether is portrait mode state ...
  bool get isPortraitMode =>
      MediaQuery.of(this).orientation == Orientation.portrait;
}

extension StringExtn on String {
  // password condition check....
  bool get isPassword => length > 6 && length < 25;

  bool isEquals(String value) => compareTo(value) == 0;

  bool get isPhone {
    if (length > 16 || length < 9) return false;
    return _hasMatch(this, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  bool get isEmail => _hasMatch(this,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String get getFileName {
    int lastIndex = lastIndexOf('/');
    if (lastIndex != -1 && lastIndex < length - 1) {
      return substring(lastIndex + 1);
    }
    return this;
  }

  String get getFileExtension {
    int lastIndex = lastIndexOf('.');
    if (lastIndex != -1 && lastIndex < length - 1) {
      return substring(lastIndex);
    }
    return '';
  }

  bool get isNum {
    if (trim().isEmpty) return false;
    return num.tryParse(this) is num;
  }

  num get getNum => num.parse(this);
}

bool _hasMatch(String? value, String pattern) {
  return (value == null) ? false : RegExp(pattern).hasMatch(value);
}

extension FailureException on Failure {
  String get value {
    String string = '';
    if (this is CacheFailure) {
      string = 'CACHE_FAILURE_MESSAGE';
    } else if (this is ServerFailure) {
      string = 'SERVER_FAILURE_MESSAGE';
    } else if (this is ErrorFailure) {
      final vv = this as ErrorFailure;
      string = vv.error;
    }
    return string;
  }
}
