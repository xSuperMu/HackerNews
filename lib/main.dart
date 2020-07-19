import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'model/article.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _ids = [
    23851275,
    23848039,
    23833362,
    23858662,
    23841491,
    23835918,
    23878508,
    23875692,
    23833140,
    23868355,
    23871169,
    23864265,
    23833267,
    23845579,
    23859401,
    23876146,
    23842656,
    23842179,
    23853786,
    23878753,
    23869480,
    23858294,
    23836616,
    23860338,
    23859085,
    23834153,
    23877468,
    23840670,
    23855884,
    23852754,
    23875758,
    23845575,
    23864934,
    23846654,
    23837824,
    23865116,
    23881220,
    23849202,
    23870339,
    23865484,
    23867892,
    23851542,
    23859180,
    23857072,
    23868206,
    23871367,
    23876847,
    23846103,
    23863903,
    23843145,
    23870434,
    23880207,
    23875790,
    23856988,
    23837341,
    23869665,
    23878728,
    23875367,
    23840364,
    23837838,
    23842137,
    23864793,
    23840787,
    23843711,
    23871798,
    23844267,
    23860584,
    23867278,
    23865900,
    23869858,
    23858590,
    23855208,
    23872625,
    23881342,
    23867402,
    23878741,
    23861396,
    23869155,
    23859548,
    23838124,
    23866894,
    23860779,
    23849072,
    23870283,
    23851870,
    23880071,
    23875419,
    23839895,
    23858008,
    23874206,
    23869349,
    23870066,
    23839271,
    23846186,
    23866678,
    23862903,
    23881584,
    23870164,
    23836985,
    23863322,
    23855539,
    23846026,
    23840735,
    23871907,
    23869752,
    23843525,
    23881309,
    23843813,
    23840243,
    23836876,
    23846845,
    23836578,
    23851864,
    23847993,
    23882029,
    23860829,
    23856086,
    23844643,
    23859448,
    23858764,
    23839212,
    23872019,
    23843434,
    23860659,
    23859278,
    23843485,
    23873752,
    23870282,
    23837251,
    23833429,
    23833441,
    23869819,
    23870693,
    23862471,
    23846203,
    23859985,
    23851393,
    23877406,
    23866688,
    23860533,
    23863483,
    23856229,
    23848512,
    23860362,
    23851200,
    23834483,
    23882026,
    23859625,
    23857654,
    23872873,
    23864909,
    23845020,
    23846485,
    23881643,
    23882814,
    23843296,
    23837109,
    23878029,
    23855564,
    23854329,
    23852036,
    23843965,
    23878627,
    23869532,
    23859508,
    23882114,
    23841409,
    23841049,
    23862189,
    23877912,
    23868119,
    23850718,
    23877872,
    23875671,
    23866926,
    23858916,
    23870240,
    23861435,
    23882224,
    23850831,
    23868756,
    23865674,
    23864247,
    23854222,
    23844490,
    23871710,
    23880379,
    23843530,
    23881539,
    23855722,
    23844163,
    23861547,
    23839371,
    23870521,
    23882564,
    23872636,
    23838264,
    23881390,
    23860281,
    23857849
  ];

  Future<List<int>> _getBestStories() async {
    final url = 'https://hacker-news.firebaseio.com/v0/beststories.json';
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return parseTopStories(res.body);
    }
    return null;
  }

  Future<Article> _getArticleById(int id) async {
    final articleUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final articleRes = await http.get(articleUrl);
    if (articleRes.statusCode == 200) {
      return parseArticle(articleRes.body);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: _ids
              .map((id) => FutureBuilder<Article>(
                    future: _getArticleById(id),
                    builder: (BuildContext context,
                        AsyncSnapshot<Article> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return _buildItem(snapshot.data);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ))
              .toList(),
        ));
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(article.title, style: TextStyle(fontSize: 24.0)),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(article.type),
              IconButton(
                  icon: Icon(Icons.launch),
                  onPressed: () async {
                    if (await canLaunch(article.url)) {
                      launch(article.url);
                    }
                  }),
            ],
          )
        ],
      ),
    );
  }
}
