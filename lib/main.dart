import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:pear_app/provider/loading_provider.dart';
import 'package:pear_app/provider/login_provider.dart';
import 'package:pear_app/provider/user_provider.dart';
import 'package:pear_app/screens/login_screen.dart';
import 'package:pear_app/widgets/key_board_dismiss.dart';
import 'package:pear_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken("pk.eyJ1IjoicGV0ZXJ2dTEyMyIsImEiOiJjbHdzbzY1bngwOTdrMndvZWRha3Iyb29iIn0.8dif0JPZ1Q_PWM9m0QwaXQ");
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
