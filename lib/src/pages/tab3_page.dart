import 'package:flutter/material.dart';
import 'package:newsapp/src/models/newsModels.dart';
import 'package:newsapp/src/services/dbService.dart';
import 'package:newsapp/src/widgets/newsList.dart';

class Tab3Page extends StatefulWidget {
  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final Future<List<Article>> savedNews = DBService.db.getNews();
    return Scaffold(
      body: FutureBuilder<List<Article>>(
        future: savedNews,
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.length > 0
                ? NewsList(snapshot.data, true)
                : Center(child: Text('No Saved News'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
