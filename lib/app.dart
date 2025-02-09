import 'package:flutter/material.dart';
import 'package:convertissor/form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(bodyLarge: TextStyle(color: const Color.fromARGB(255, 5, 65, 7))),
        scaffoldBackgroundColor: Colors.black,
      ),
      title: 'Mask to Wildcard Converter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: const Color.fromARGB(255, 5, 65, 7)),
          title: const Center(child: Text('Mask to Wildcard Converter')),
        ),
        body: const SafeArea(
          child: MyForm(),
        ),
      ),
    );
  }
}
