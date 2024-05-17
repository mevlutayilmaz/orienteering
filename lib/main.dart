import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'router/router.dart';
import 'router/routes.dart';
import 'utils/constants/constants.dart';
import 'dependency_injection.dart';
import 'firebase_options.dart';
import 'utils/theme/theme.dart';
import 'utils/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(EasyLocalization(
    supportedLocales: const [
      LocaleConstants.enLocale,
      LocaleConstants.trLocale,
    ],
    saveLocale: true,
    fallbackLocale: LocaleConstants.enLocale,
    path: LocaleConstants.localePath,
    child: const MyApp(),
  ));
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return GetMaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
  
            theme: themeNotifier.isDark ? TAppTheme.darkTheme : TAppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: user == null ? Routes.welcome : Routes.mainHome,
            onGenerateRoute: RouteGenerate.generateRoute,
          );
        },
      ),
    );
  }
}
