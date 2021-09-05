import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tabs_page.dart';
import 'package:newsapp/src/services/newsService.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: TabsPage(),
      ),
    );
  }
}
