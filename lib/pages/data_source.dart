import 'package:flutter/material.dart';
import 'package:flutter_search_in_appbar/data.dart';
import 'package:json_view/json_view.dart';

class DataSource extends StatefulWidget {
  final String title;
  const DataSource({super.key, required this.title});

  @override
  State<DataSource> createState() => _DataSourceState();
}

class _DataSourceState extends State<DataSource> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DATA SOURCE'),
        bottom: TabBar(
          tabs: const [
            Tab(text: 'Simple List'),
            Tab(text: 'Complex List'),
          ],
          controller: _tabController,
        ),
      ),
      body: SafeArea(
        child: JsonConfig(
          data: JsonConfigData(
            gap: 20,
            style: const JsonStyleScheme(
              quotation: JsonQuotation.same('"'),
              // set this to true to open all nodes at start
              // use with caution, it will cause performance issue when json items is too large
              openAtStart: false,
              arrow: Icon(Icons.arrow_forward),
              // too large depth will cause performance issue
              depth: 0,
            ),
            color: const JsonColorScheme(),
          ),
          child: TabBarView(
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            children: [
              JsonView(
                json: listCountries,
              ),
              JsonView(
                json: allCountries,
                gap: 20,
                styleScheme: const JsonStyleScheme(
                  quotation: JsonQuotation.same('"'),
                  openAtStart: false,
                  arrow: Icon(Icons.arrow_forward),
                  depth: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
