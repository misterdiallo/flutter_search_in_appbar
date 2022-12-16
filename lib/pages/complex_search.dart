import 'package:flutter/material.dart';
import 'package:flutter_search_in_appbar/data.dart';

class ComplexSearch extends StatefulWidget {
  final String title;
  const ComplexSearch({super.key, required this.title});

  @override
  State<ComplexSearch> createState() => _ComplexSearchState();
}

class _ComplexSearchState extends State<ComplexSearch> {
  bool _searchBoolean = false;
  final List<Map<String, Object>> _listCountries = allCountries;
  List<Map<String, Object>> _searchList = [];
  final TextEditingController _searchTextFieldController =
      TextEditingController();

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchList = [];
          _searchList = _listCountries
              .where((mapObject) =>
                  (mapObject["name"] as String).toLowerCase().contains(s) ||
                  (mapObject["dialling_code"] as String).contains(s))
              .toList();
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
        itemCount: _searchList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                functionToExecuteOnSelect(_searchList[index]);
                setState(() {
                  _searchBoolean = false;
                  _searchList = [];
                });
              },
              title: Text(
                  "${_searchList[index]['name']} (${_searchList[index]['code']})"),
              trailing: Text(_searchList[index]['dialling_code'].toString()),
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
              title: Text(
                  "${allCountries[index]['name']} (${allCountries[index]['code']})"),
              trailing: Text(allCountries[index]['dialling_code'].toString()),
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
                            _searchList = [];
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
        body: !_searchBoolean ? _defaultListView() : _searchListView());
  }

  functionToExecuteOnSelect(Map<String, Object> selectedCountrie) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
// Controls visual overflow
          overflow: TextOverflow
              .clip, // Controls how the text should be aligned horizontally
          textAlign: TextAlign.end,
// Control the text direction
          textDirection: TextDirection.rtl,
// Whether the text should break at soft line breaks
          softWrap: true,
// Maximum number of lines for the text to span
          // maxLines: 1,
// The number of font pixels for each logical pixel
          // textScaleFactor: 1,
          text: TextSpan(
            text: '',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
            children: <TextSpan>[
              TextSpan(text: " \nName: ", children: [
                TextSpan(
                  text: '${selectedCountrie['name']} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              TextSpan(text: "\nCode: ", children: [
                TextSpan(
                  text: '${selectedCountrie['code']} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              TextSpan(text: "\nCapital: ", children: [
                TextSpan(
                  text: '${selectedCountrie['capital']} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              TextSpan(text: "\nCurrency: ", children: [
                TextSpan(
                  text: '${selectedCountrie['currency']} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              TextSpan(text: "\nLanguage: ", children: [
                TextSpan(
                  text: '${selectedCountrie['language']} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
              TextSpan(text: "\nPhone Code: ", children: [
                TextSpan(
                  text: '${selectedCountrie['dialling_code']} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
            ],
          ),
          // Text(
          // "You selected: ${selectedCountrie['name']} (${selectedCountrie['code']})"),
        ),
      ),
    );
  }
}
