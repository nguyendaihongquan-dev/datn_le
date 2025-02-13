import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pear_app/provider/loading_provider.dart';
import 'package:pear_app/provider/login_provider.dart';
import 'package:pear_app/provider/user_provider.dart';
import 'package:pear_app/screens/forgot_password_screen.dart';
import 'package:pear_app/screens/login_screen.dart';
import 'package:pear_app/screens/test_screen.dart';
import 'package:pear_app/widgets/key_board_dismiss.dart';
import 'package:pear_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('vi', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoadingProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
        ],
        builder: (context, _) {
          return Consumer<LoadingProvider>(builder: (context, loading, child) {
            return KeyboardDismiss(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Stack(children: [
                  MaterialApp(
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    // initialRoute: AppRoutes.splash,
                    routes: AppRoutes.routes,
                    home: const LoginScreen(),
                  ),
                  loading.isLoading
                      ? const LoadingWidget()
                      : const SizedBox.shrink()
                ]),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              ),
            );
          });
        });
  }
}
