import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_in_appbar/pages/complex_search.dart';
import 'package:flutter_search_in_appbar/pages/data_source.dart';
import 'package:flutter_search_in_appbar/pages/simple_search.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navKey = GlobalKey<NavigatorState>();
    void _navigateTo(page) {
      navKey.currentState!.pushNamed(page);
    }

    return MaterialApp(
      title: 'Flutter Appbar Search',
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: <String, WidgetBuilder>{
        '/simple': (BuildContext context) =>
            const SimpleSearch(title: 'Simple Countries List'),
        '/complex': (BuildContext context) =>
            const ComplexSearch(title: "Advanced Countries List"),
        '/data': (BuildContext context) =>
            const DataSource(title: "Data of Countries List"),
      },
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Flutter Search in AppBar",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "@misterdiallo",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 10.0, color: Colors.white),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 2000),
                            animatedTexts: [
                              TyperAnimatedText('Follow me: @misterdiallo'),
                              TyperAnimatedText('A passionate Guinean'),
                              TyperAnimatedText('and Flutter Lover'),
                              TyperAnimatedText('By - Mister Diallo'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _navigateTo('/simple'),
                          child: const Text("Simple Search"),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateTo('/complex'),
                          child: const Text("Advanced Search"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateTo('/data'),
          backgroundColor: Colors.teal[900],
          child: const Icon(
            Icons.insert_drive_file_rounded,
            // size: 35,
          ),
        ),
      ),
    );
  }
}
