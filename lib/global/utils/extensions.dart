import 'dart:developer' as devtools show log;


extension AppLoger on Object? {
  void log() => devtools.log(toString());
}
