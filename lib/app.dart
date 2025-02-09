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
      title: 'Mask to Wildcard Converter',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Mask to Wildcard Converter')),
        ),
        body: const SafeArea(
          child: MyForm(),
        ),
      ),
    );
  }
}
