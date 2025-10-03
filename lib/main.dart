import 'package:flutter/material.dart';
import 'package:interviewtask03/auth/authcheck.dart';
import 'package:interviewtask03/controller/homescreencontroller.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Homescreencontroller(),
        ),
        

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthChecker(),
      ),
    );
  }
}