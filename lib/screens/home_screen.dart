import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordfinder/provider/definition_provider.dart';

class HomeScreen extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Word Finder',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Oswald'),
        ),
        centerTitle: true,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Consumer(builder: (context, ref, child) {
        final words = ref.watch(definitionProvider);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextFormField(
                controller: searchController,
                textCapitalization: TextCapitalization.words,
                onFieldSubmitted: (value) {
                  ref
                      .read(definitionProvider.notifier)
                      .searchWord(query: value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10, right: 15, left: 15),
                  hintText: 'Search for a word....',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        ref.refresh(definitionProvider);
                      }),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white38,
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            searchController.text.isEmpty
                ? Container()
                : words.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height - 215,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height - 215,
                        child: ListView.builder(
                            itemCount: words.length,
                            itemBuilder: (context, index) {
                              final dat = words[index];
                              return Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 10, right: 10),
                                  child: Card(
                                    color: Color(0xFF1D1E33),
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 18),
                                      width: double.infinity,
                                      // height: 250,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    searchController.text.trim(),
                                                    style:
                                                        TextStyle(fontSize: 40),
                                                  ),
                                                  Text(
                                                    dat.type,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    dat.definition,
                                                    maxLines: 5,
                                                    textAlign: TextAlign.justify,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '"' + dat.example + '"',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
          ]),
        );
      }),
    );
  }
}
