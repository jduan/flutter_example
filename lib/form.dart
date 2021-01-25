import 'package:flutter/material.dart';

enum SearchType { web, image, news, shopping }

class ProperForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProperFormState();
}

class _ProperFormState extends State<ProperForm> {
  // A map to hold the data from the form.
  final Map<String, dynamic> _searchForm = <String, dynamic>{
    'searchTerm': '',
    'searchType': SearchType.web,
    'safeSearchOn': true,
  };

  // The flutter key to point to the form
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _key,
            autovalidate: false,
            child: Container(
                child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _searchForm['searchTerm'],
                  decoration: InputDecoration(
                    labelText: 'Search terms',
                  ),
                  // On every keystroke, you can do something
                  onChanged: (String val) {
                    setState(() => _searchForm['searchTerm'] = val);
                  },
                  // When the user submits, you could do something for this field
                  onSaved: (String val) {},
                  // Returns null if validation passes, and an error message if it fails
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'We need something to search for';
                    } else {
                      return null;
                    }
                  },
                ),
                FormField<SearchType>(
                  builder: (FormFieldState<SearchType> state) {
                    return DropdownButton<SearchType>(
                      value: _searchForm['searchType'],
                      items: const <DropdownMenuItem<SearchType>>[
                        DropdownMenuItem<SearchType>(
                          child: Text('Web'),
                          value: SearchType.web,
                        ),
                        DropdownMenuItem<SearchType>(
                          child: Text('Image'),
                          value: SearchType.image,
                        ),
                        DropdownMenuItem<SearchType>(
                          child: Text('News'),
                          value: SearchType.news,
                        ),
                        DropdownMenuItem<SearchType>(
                          child: Text('Shopping'),
                          value: SearchType.shopping,
                        ),
                      ],
                      onChanged: (SearchType val) {
                        setState(() => _searchForm['searchType'] = val);
                      },
                    );
                  },
                  onSaved: (SearchType initValue) {},
                ),
                FormField<bool>(
                  builder: (FormFieldState<bool> state) {
                    return Row(
                      children: <Widget>[
                        Checkbox(
                          value: _searchForm['safeSearchOn'],
                          // every time it changes, you can do sth
                          onChanged: (bool val) {
                            setState(() => _searchForm['safeSearchOn'] = val);
                          },
                        ),
                        const Text('Safesearch on'),
                      ],
                    );
                  },
                  onSaved: (bool initValue) {
                    // when the user saves, this is run
                  },
                ),
                RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    // Remember this calls the validator on all fields in the form
                    if (_key.currentState.validate()) {
                      // this calls onSaved() for all fields
                      _key.currentState.save();
                      // you'd save the data (_searchForm) to a database or whatever here
                      print('Successfully saved the state: $_searchForm.');
                    }
                  },
                )
              ],
            )
            )
        )
    );
  }
}