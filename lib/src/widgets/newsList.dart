import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:newsapp/src/models/newsModels.dart';
import 'package:newsapp/src/services/dbService.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;
  final List<String> savedNews;

  const NewsList(this.news, this.savedNews);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(
            news: this.news[index], index: index, savedNews: this.savedNews);
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;
  final List<String> savedNews;
  const _News({this.news, this.index, this.savedNews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TitleCard(this.news),
        _ImageCard(this.news),
        _SourcesCard(this.news, this.savedNews),
        SizedBox(height: 10),
        _BodyCard(this.news),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _SourcesCard extends StatelessWidget {
  final Article news;
  final List<String> savedNews;
  const _SourcesCard(this.news, this.savedNews);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            '${news.source.name}. ',
          ),
        ),
        _IconsRow(this.news, savedNews),
      ],
    );
  }
}

class _IconsRow extends StatelessWidget {
  final Article news;
  final List<String> savedNews;
  const _IconsRow(this.news, this.savedNews);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        children: <Widget>[
          _SavedIcon(this.news, this.savedNews),
          SizedBox(width: 10),
          Icon(Icons.share),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article news;
  const _TitleCard(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(news.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article news;
  const _ImageCard(this.news);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
                child: (this.news.urlToImage != null)
                    ? FadeInImage(
                        placeholder: AssetImage('assets/giphy.gif'),
                        image: NetworkImage(this.news.urlToImage),
                      )
                    : Image(
                        image: AssetImage('assets/no-image.png'),
                      )),
          ),
        ),
        onTap: () {
          FlutterWebBrowser.openWebPage(
            url: news.url,
            customTabsOptions: CustomTabsOptions(
              colorScheme: CustomTabsColorScheme.dark,
              addDefaultShareMenuItem: true,
              instantAppsEnabled: true,
              showTitle: true,
              urlBarHidingEnabled: true,
            ),
            safariVCOptions: SafariViewControllerOptions(
              barCollapsingEnabled: true,
              dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
              modalPresentationCapturesStatusBarAppearance: true,
            ),
          );
        });
  }
}

class _BodyCard extends StatelessWidget {
  final Article news;
  const _BodyCard(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text((news.description != null) ? news.description : ''),
    );
  }
}

class _SavedIcon extends StatelessWidget {
  final Article news;
  final List<String> savedNews;
  const _SavedIcon(this.news, this.savedNews);
  @override
  Widget build(BuildContext context) {
    final bool isSaved = savedNews.contains(news.title);
    return GestureDetector(
      onTap: () {
        if (isSaved) {
          DBService.db.deleteNews(this.news.title);
        } else {
          DBService.db.insertNews(this.news);
        }
      },
      child: (isSaved) ? Icon(Icons.delete) : Icon(Icons.star_border),
    );
  }
}
