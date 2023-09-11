import 'package:flutter/material.dart';
import 'option1.dart';
import 'option2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DTE'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Option 1'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Option1Page()),
                );
              },
            ),
            ListTile(
              title: const Text('Option 2'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Option2Page()),
                );
              },
            ),
            // Add more list tiles here for more options
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Center(
            child: Card(
              child: InkWell(
                onTap: () {
                  // Navigate to Option1Page when the first card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Option1Page()),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://example.com/image1.jpg'), // replace with your image url
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              child: InkWell(
                onTap: () {
                  // Navigate to Option2Page when the second card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Option2Page()),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://example.com/image2.jpg'), // replace with your image url
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Add more cards with different links here
        ],
      ),
    );
  }
}
