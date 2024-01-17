import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


extension AppLoger on Object? {
  void log() => devtools.log(toString());
}
