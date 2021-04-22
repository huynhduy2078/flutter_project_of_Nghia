import 'package:chat_messanger_ui/services/register_providers.dart';
import 'package:chat_messanger_ui/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/auth/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: registerProviders,
      child: MaterialApp(
        title: 'NAME_PROJECT',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: Login(),
      ),
    );
  }
}
