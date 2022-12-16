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
            const ComplexSearch(title: "Complex Countries List"),
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
                    const SizedBox(
                      height: 25,
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
                          child: const Text("Complex Search"),
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
        floatingActionButton: ElevatedButton(
          onPressed: () => _navigateTo('/data'),
          child: const Text("Data sources"),
        ),
      ),
    );
  }
}
