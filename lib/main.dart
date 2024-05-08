import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grade_management_app/app_provider.dart';
import 'package:grade_management_app/global/services/firebase_notification_service.dart';
import 'package:grade_management_app/locator.dart';
import 'package:grade_management_app/modules/onboarding/splash/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'modules/dashboard/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServices();
  await Firebase.initializeApp();
  await FirebaseNotificationService().initNotificationService();
  await hiveInit();

  _configureSystemUIOverlayStyle();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProvider.getList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

Future<void> hiveInit() async {
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  _registerHiveAdapters();

  await Future.wait([
    Hive.openBox<Course>('course'),
    Hive.openBox<Semester>('semester'),
    Hive.openBox<Year>('year'),
    Hive.openBox<Student>(studentBoxName)
  ]);

  final studentBox = Hive.box<Student>(studentBoxName);
  if (studentBox.isEmpty) {
    await studentBox.add(Student(years: []));
  }
}

void _registerHiveAdapters() async {
  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(SemesterAdapter());
  Hive.registerAdapter(YearAdapter());
  Hive.registerAdapter(StudentAdapter());
}

void _configureSystemUIOverlayStyle() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}
