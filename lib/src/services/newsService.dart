import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/models/categoryModel.dart';
import 'package:newsapp/src/models/newsModels.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dbService.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = '72492bb78d284e6badef389a803220be';
final _COUNTRY = 'mx';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyballBall, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = [];
    });
  }

  get selectedCategory => this._selectedCategory;
  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  getTopHeadlines() async {
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?country=$_COUNTRY&apiKey=$_API_KEY');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles;
    }
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?country=$_COUNTRY&apiKey=$_API_KEY&category=$category');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }

  List<Article> get getSelectedCategoryArticle =>
      this.categoryArticles[this._selectedCategory];
}
