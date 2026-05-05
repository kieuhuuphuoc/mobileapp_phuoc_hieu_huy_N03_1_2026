import 'package:flutter/material.dart';
import 'package:app_hoc_tieng_anh/screens/auth/login_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'App Học Tiếng Anh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      
    );
  }
}