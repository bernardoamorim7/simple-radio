import 'package:flutter/material.dart';
import './radio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simple Radio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getRadios().then((result) {
      if (result) {
        setState(() {}); // Update the UI after fetching data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.radio),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: radios.isNotEmpty
            ? Center(
                child: ListView.builder(
                  itemCount: radios.length,
                  itemBuilder: (context, index) {
                    final radio = radios[index];
                    return RadioTile(
                      name: radio.name,
                      url: radio.url,
                      favicon: radio.favicon,
                    );
                  },
                ),
              )
            : const CircularProgressIndicator(), // Center the loading indicator
      ),
    );
  }
}
