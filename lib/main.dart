import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mini_project_2/firebase_options.dart';
import 'package:mini_project_2/helper/fcm_helper.dart'; 
import 'logic/auth/auth_bloc.dart';
import 'logic/product/product_bloc.dart';
import 'logic/product/product_event.dart';
import 'logic/profile/profile_bloc.dart';
import 'migrate/migrate.dart';
import 'helper/notification_helper.dart';
import 'services/services.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  await NotificationHelper().initLocalNotifications();

  ///tambahkan ini

  await FcmHelper().init(); //tambahkan ini

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductService())..add(FetchProducts()),
        ),
        BlocProvider(
          create: (context) => 
          ProfileBloc(ProfileService(FirebaseFirestore.instance)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}