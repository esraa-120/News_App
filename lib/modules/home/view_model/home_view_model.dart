import 'package:flutter/material.dart';
import 'package:news_app/core/network/http_requests_service.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/source_model.dart';

class HomeViewModel extends ChangeNotifier {

  final List<CategoryModel> _categories = [
    CategoryModel(id: 'general', name: 'General', image: Assets.images.general.path),
    CategoryModel(id: 'business', name: 'Business', image: Assets.images.busniess.path),
    CategoryModel(id: 'sports', name: 'Sports', image: Assets.images.sport.path),
    CategoryModel(id: 'technology', name: 'Technology', image: Assets.images.technology.path),
    CategoryModel(id: 'entertainment', name: 'Entertainment', image: Assets.images.entertainment.path),
    CategoryModel(id: 'health', name: 'Health', image: Assets.images.helth.path),
    CategoryModel(id: 'science', name: 'Science', image: Assets.images.science.path),
  ];

  int _selectedIndex = 0;
  CategoryModel? _selectedCategory;
  List<SourceModel> _sourcesList = [];
  List<ArticleModel> _articlesList = [];

  int get selectedIndex => _selectedIndex;
  List<CategoryModel> get categories => _categories;
  CategoryModel? get selectedCategory => _selectedCategory;
  List<SourceModel> get sourcesList => _sourcesList;
  List<ArticleModel> get articlesList => _articlesList;

  void changeTabIndex(int index) {
    _selectedIndex = index;
    getAllArticles();
    notifyListeners();
  }
  void changeSelectedCategory(CategoryModel? categoryModel) {

    if (categoryModel == null) {
      _selectedCategory = null;
      return;
    }

    _selectedCategory = categoryModel;
    notifyListeners();
  }

  Future<void> getAllSources() async {
    final data = await HttpRequestsService.getAllSources(_selectedCategory!.id);
    _sourcesList = data;
      notifyListeners();
    }
    Future<void> getAllArticles() async {
    final data = await HttpRequestsService.getAllArticles(_sourcesList[_selectedIndex].id);
    _articlesList = data;
    notifyListeners();
  }
  }
