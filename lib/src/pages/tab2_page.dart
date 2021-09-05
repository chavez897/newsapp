import 'package:flutter/material.dart';
import 'package:newsapp/src/models/categoryModel.dart';
import 'package:newsapp/src/services/newsService.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:newsapp/src/widgets/newsList.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _CategoriesList(),
            Expanded(
                child: (newsService.getSelectedCategoryArticle.length <= 0)
                    ? Center(child: CircularProgressIndicator())
                    : NewsList(newsService.getSelectedCategoryArticle)),
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: newsService.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(newsService.categories[index]),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${newsService.categories[index].name[0].toUpperCase()}${newsService.categories[index].name.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final CategoryModel categoryModel;

  _CategoryButton(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = categoryModel.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(categoryModel.icon,
            color: (this.categoryModel.name == newsService.selectedCategory)
                ? myTheme.accentColor
                : Colors.black54),
      ),
    );
  }
}
