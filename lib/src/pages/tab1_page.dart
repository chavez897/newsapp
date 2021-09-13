import 'package:flutter/material.dart';
import 'package:newsapp/src/services/dbService.dart';
import 'package:newsapp/src/services/newsService.dart';
import 'package:newsapp/src/widgets/newsList.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    final dbService = Provider.of<DBService>(context);
    return Scaffold(
      body: (newsService.headlines.length <= 0)
          ? Center(child: CircularProgressIndicator())
          : NewsList(
              newsService.headlines,
              dbService.savedTitles,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
