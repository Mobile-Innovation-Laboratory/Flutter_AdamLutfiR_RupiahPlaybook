import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/common/theme/app_theme.dart';
import 'package:tugas_besar_motion/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ScreenUtilInit(
    designSize: Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/dashboard' : '/login',
      getPages: AppPages.routes,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: ThemeMode.system,
    ),
  ));
}
