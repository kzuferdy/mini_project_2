import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; 
import 'logic/product/product_bloc.dart';
import 'logic/product/product_event.dart';
import 'logic/profile/profile_bloc.dart';
import 'notification_helper.dart';
import 'services/services.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initLocalNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductService())..add(FetchProducts()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileBloc(ProfileService(http.Client()))..add(LoadProfileEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}