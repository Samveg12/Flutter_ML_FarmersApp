import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

Future<String> trans(String input1, String lang) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(input1,
        from: 'en', to: lang);
    print("translation: ${(translation).toString()}");
    return (translation).toString();
  }

class FindUrea extends StatefulWidget {
  final translated;
  final lang;
  @override
  _FindUreaState createState() => _FindUreaState();
  FindUrea(this.translated, this.lang);
}

class _FindUreaState extends State<FindUrea> {
  var data;
  bool isLoading;
  @override
  void initState() {
    getData();
    super.initState();
    isLoading = true;
  }

  void getData() async {
    final url = Uri.parse('https://naitikfarmer.herokuapp.com/indiamart');
    print('something');
    final response = await http.post(
      url,
      body: json.encode({'sentence': widget.translated}),
    );
    setState((){
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      print(decoded);
      data = decoded['status']['message'];
      isLoading = false;
      
    });
    for(int i=0; i<min(data.length,6); i++){
        data[i]['name'] = await trans(data[i]['name'], widget.lang);
        data[i]["companyname"] = await trans(data[i]["companyname"], widget.lang);
        data[i]["price"] = await trans(data[i]["price"], widget.lang);
        data[i]["unit"] = await trans(data[i]['unit'], widget.lang);
        data[i]["address"] = await trans(data[i]['address'], widget.lang);
      }

      setState(() {
      });
  }

  @override
  Widget build(BuildContext context) {
    var lang = widget.lang;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: 
      Container(
      child: isLoading ? Center(child: CircularProgressIndicator()) :
      ListView.builder(
        itemCount: min(data.length,6),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              width: 6,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Company -",
                              //textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Expanded(
                              child: Text(
                                " ${data[index]["companyname"]}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Text(
                                "Price : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.grey),
                              ),
                              Text(
                                "${data[index]["price"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Unit: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey[700]),
                            ),
                            Text(
                              "${data[index]["unit"]} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "${data[index]["address"]}",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
    );
  }
}

class Retailer extends StatefulWidget {
  final translated;
  final lang;
  @override
  _RetailerState createState() => _RetailerState();
  Retailer(this.translated,this.lang);
}

class _RetailerState extends State<Retailer> {
  var data;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final url = Uri.parse('https://naitikfarmer.herokuapp.com/web');
    print('something');
    final response = await http.post(
      url,
      body: json.encode({'sentence': widget.translated}),
    );
    setState(() {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      print(decoded);
      data = decoded['status']['message'];
    });
    for(int i=0; i<min(data.length,6); i++){
        data[i]['name'] = await trans(data[i]['name'], widget.lang);
        data[i]["companyname"] = await trans(data[i]["companyname"], widget.lang);
        data[i]["price"] = await trans(data[i]["price"], widget.lang);
        data[i]["unit"] = await trans(data[i]['unit'], widget.lang);
        data[i]["address"] = await trans(data[i]['address'], widget.lang);
      }

      setState(() {
      });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              width: 6,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Company -",
                              //textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Expanded(
                              child: Text(
                                " ${data[index]["companyname"]}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Text(
                                "Price : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.grey),
                              ),
                              Text(
                                "${data[index]["price"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Unit: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey[700]),
                            ),
                            Text(
                              "${data[index]["unit"]} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "${data[index]["address"]}",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          // return Card(
          //   child: Text(
          //       "Name :${data[index]['name']} \nRating :${data[index]['rating']} \nAddress :${data[index]['address']}"),
          // );
        },
      ),
    );
  }
}

class Mandi extends StatefulWidget {
  final translated;
  final lang;
  @override
  _MandiState createState() => _MandiState();
  Mandi(this.translated,this.lang);
}

class _MandiState extends State<Mandi> {
  var data;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final url = Uri.parse('https://naitikfarmer.herokuapp.com/web');
    print('something');
    final response = await http.post(
      url,
      body: json.encode({'sentence': widget.translated}),
    );
    setState(() {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      print(decoded);
      data = decoded['status']['message'];
    });
    for(int i=0; i<data.length; i++){
        data[i]['name'] = await trans(data[i]['name'], widget.lang);
        data[i]["modalPrice"] = await trans(data[i]["modalPrice"], widget.lang);
        data[i]["variety"] = await trans(data[i]["variety"], widget.lang);
        data[i]["market"] = await trans(data[i]['market'], widget.lang);
      }

      setState(() {
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Container(
              width: 6,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Market -",
                              //textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Expanded(
                              child: Text(
                                " ${data[index]["market"]}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        Divider(thickness: 2, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Text(
                                "Price : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.grey),
                              ),
                              Text(
                                "${data[index]["modalPrice"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Unit: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey[700]),
                            ),
                            Text(
                              "${data[index]["variety"]} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          // return Card(
          //   child: Text(
          //       "Name :${data[index]['name']} Market :${data[index]['market']}  Variety :${data[index]['variety']}  modalPrice :${data[index]['modalPrice']}"),
          // );
        },
      ),
    );
  }
}

class News extends StatefulWidget {
  final translated;
  final lang;
  @override
  _NewsState createState() => _NewsState();
  News(this.translated, this.lang);
}

class _NewsState extends State<News> {
  var data;
  var isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
    isLoading = true;
  }

  void getData() async {
    final url = Uri.parse('https://naitikfarmer.herokuapp.com/web');
    print('something');
    final response = await http.post(
      url,
      body: json.encode({'sentence': widget.translated}),
    );
    setState(() {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      print(decoded);
      data = decoded['status']['message'];
      isLoading = false;
    });
    for(int i=0; i<min(data.length,6); i++){
        data[i]["title"] =   await trans(data[i]["title"], widget.lang);
        //print(data[i]["title"]);
        data[i]["author"] =   trans(data[i]["author"], widget.lang);
        //print(data[i]["author"]);
        data[i]["content"] =  trans(data[i]["content"], widget.lang);
        //print(data[i]["content"]);
      }
    setState(() {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Urea"),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              width: 6,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "${data[index]["title"]}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Author -",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            Expanded(
                              child: Text(
                                " ${data[index]["author"]}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        
                        Divider(thickness: 2, color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "${data[index]["content"]}",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          // return Card(
          //   child: Text(
          //       "Title :${data[index]['title']} \nContent :${data[index]['content']}\n  Author :${data[index]['author']}  date :${data[index]['date']}"),
          // );
        },
      ),
    );
  }
}
