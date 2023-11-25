part of 'news_list_bloc.dart';

@immutable
abstract class NewsListState {}

class NewsListInitial extends NewsListState {}

class NewsListInitState extends NewsListState {
  final List<NewsEntity> news;

  NewsListInitState({required this.news});
}
