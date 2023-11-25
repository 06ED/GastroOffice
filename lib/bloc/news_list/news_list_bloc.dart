import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../entities/impl/news_entity.dart';

part 'news_list_event.dart';

part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  NewsListBloc() : super(NewsListInitial()) {
    on<NewsListInitEvent>((event, emit) {
      emit(NewsListInitState(news: [
        NewsEntity(
            id: "1",
            title: "Новость ывафввафыфа",
            description:
                "sadkjfasiuldfadsnhlfkhadsnflaskjdfhsadkjf,asdhfkjsad,fhasdkd,hfk",
            photoId:
                "https://avtonam.ru/wp-content/uploads/2016/02/citroen-ds3-2016-2.jpg"),
        NewsEntity(
            id: "1",
            title: "Новость ывафввафыфа",
            description:
                "sadkjfasiuldfadsnhlfkhadsnflaskjdfhsadkjf,asdhfkjsad,fhasdkd,hfk",
            photoId:
                "https://avtonam.ru/wp-content/uploads/2016/02/citroen-ds3-2016-2.jpg"),
        NewsEntity(
            id: "1",
            title: "Новость ывафввафыфа",
            description:
                "sadkjfasiuldfadsnhlfkhadsnflaskjdfhsadkjf,asdhfkjsad,fhasdkd,hfk",
            photoId:
                "https://avtonam.ru/wp-content/uploads/2016/02/citroen-ds3-2016-2.jpg"),
        NewsEntity(
            id: "1",
            title: "Новость ывафввафыфа",
            description:
                "sadkjfasiuldfadsnhlfkhadsnflaskjdfhsadkjf,asdhfkjsad,fhasdkd,hfk",
            photoId:
                "https://avtonam.ru/wp-content/uploads/2016/02/citroen-ds3-2016-2.jpg"),
      ]));
    });
  }
}
