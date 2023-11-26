import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gastro_office/api/http_client.dart';

import '../../entities/impl/news_entity.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc() : super(NewsListInitial()) {
    on<NewsListInitEvent>((event, emit) async {
      final client = HttpClient(OAuthClient());
      final response = await client.get("/news/get");
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as List;

      emit(NewsListInitState(
          news: decodedResponse.map((e) => NewsEntity.fromJson(e)).toList()));
    });
  }
}
