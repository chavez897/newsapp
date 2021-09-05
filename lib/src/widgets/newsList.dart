import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:newsapp/src/models/newsModels.dart';
import 'package:newsapp/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(news: this.news[index], index: index);
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;

  const _News({this.news, this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TopBarCard(this.news, this.index),
        _TitleCard(this.news),
        _ImageCard(this.news),
        _BodyCard(this.news),
        SizedBox(height: 10),
        _ButtonsCard(this.news),
        Divider(),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article news;
  final int index;
  const _TopBarCard(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: myTheme.accentColor),
          ),
          Text(
            '${news.source.name}. ',
          ),
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
    return Container(
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
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article news;
  const _BodyCard(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text((news.description != null) ? news.description : ''),
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  final Article news;
  const _ButtonsCard(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            onPressed: () {
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
                  dismissButtonStyle:
                      SafariViewControllerDismissButtonStyle.close,
                  modalPresentationCapturesStatusBarAppearance: true,
                ),
              );
            },
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}
