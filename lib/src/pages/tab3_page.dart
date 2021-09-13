import 'package:flutter/material.dart';
import 'package:newsapp/src/services/dbService.dart';
import 'package:newsapp/src/widgets/newsList.dart';
import 'package:provider/provider.dart';

class Tab3Page extends StatefulWidget {
  @override
  _Tab3PageState createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DBService>(context);
    dbService.getNews();
    return Scaffold(
      body: (dbService.myNews.length <= 0)
          ? Center(child: Text('No se han guardado noticias'))
          : NewsList(dbService.myNews, dbService.savedTitles),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
