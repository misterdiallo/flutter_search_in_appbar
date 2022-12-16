import 'package:flutter/material.dart';
import 'package:flutter_search_in_appbar/data.dart';

class SimpleSearch extends StatefulWidget {
  final String title;

  const SimpleSearch({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _SimpleSearchState createState() => _SimpleSearchState();
}

class _SimpleSearchState extends State<SimpleSearch> {
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];
  final List<String> _listCountries = listCountries;
  final TextEditingController _searchTextFieldController =
      TextEditingController();

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < _listCountries.length; i++) {
            if ((_listCountries[i].toLowerCase()).contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      controller: _searchTextFieldController,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Type the name',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(
            child: ListTile(
              onTap: () {
                setState(() {
                  _searchBoolean = false;
                  _searchIndexList = [];
                });
                functionToExecuteOnSelect(_listCountries[index]);
              },
              title: Text(_listCountries[index]),
            ),
          );
        });
  }

  Widget _defaultListView() {
    return ListView.builder(
        itemCount: _listCountries.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                functionToExecuteOnSelect(_listCountries[index]);
              },
              title: Text(_listCountries[index]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !_searchBoolean ? Text(widget.title) : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                          _searchIndexList = [];
                        });
                      })
                ]
              : [
                  IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      })
                ]),
      body: !_searchBoolean ? _defaultListView() : _searchListView(),
    );
  }

  functionToExecuteOnSelect(String selectedCountrie) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You selected: ${selectedCountrie.toUpperCase()}"),
      ),
    );
  }
}
