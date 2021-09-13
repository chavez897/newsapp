import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:newsapp/src/models/newsModels.dart';

class DBService with ChangeNotifier {
  static Database _database;
  static final DBService db = DBService();
  List<Article> myNews = [];
  List<String> savedTitles = [];

  DBService();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'MyNews.db');

    return await openDatabase(path, version: 3,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
        CREATE TABLE my_news(
          id INTEGER PRIMARY KEY,
          source_name TEXT NULL,
          title TEXT NULL,
          description TEXT NULL,
          url TEXT NULL,
          url_to_image TEXT NULL,
          content TEXT NULL
        );
      ''');
    });
  }

  Future<int> insertNews(Article news) async {
    final db = await database;

    final response = await db.rawInsert('''
      INSERT INTO my_news
      (source_name, title, description, url, url_to_image, content)
      VALUES ('${news.source.name}', '${news.title.replaceAll('\'', '')}', '${news.description.replaceAll('\'', '')}', '${news.url}', '${news.urlToImage}', '${news.content}');
    ''');
    this.getNews();
    return response;
  }

  getNews() async {
    final db = await database;
    List<Map> response = await db.query('my_news', orderBy: 'id DESC');
    final List<Article> news = response.isNotEmpty
        ? response.map((e) => Article.fromDB(e)).toList()
        : [];
    this.myNews = news;
    this.savedTitles = [];
    this.myNews.forEach((item) => {savedTitles.add(item.title)});
    notifyListeners();
  }

  Future<int> deleteNews(String title) async {
    final db = await database;
    final int response =
        await db.delete('my_news', where: 'title = ?', whereArgs: [title]);
    this.getNews();
    return response;
  }
}
