import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_bill/models/provider.dart';
import 'package:food_bill/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions.fromMap({
    "apiKey": "AIzaSyDpoGtvUmbcxCg48RDbJbkcjMFaytqGw54",
    "authDomain": "food-bill-b5248.firebaseapp.com",
    "projectId": "food-bill-b5248",
    "storageBucket": "food-bill-b5248.appspot.com",
    "messagingSenderId": "632745770012",
    "appId": "1:632745770012:web:327ba6502fe7826341f3d9",
    "measurementId": "G-P94EG7P77D"
  }));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FoodProvider()),
      ],
      child: MaterialApp(
        title: 'Food App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        home: HomePage(),
      ),
    );
  }
}
