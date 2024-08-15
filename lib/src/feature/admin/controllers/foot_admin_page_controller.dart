import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/foot_model.dart';

class FootAdminPageController extends GetxController
    with GetTickerProviderStateMixin {
  static FootAdminPageController get to => Get.find();

  ScrollController listByDateScrollController = ScrollController();
  StreamController<List<FootModel>> listByDateStreamController =
      BehaviorSubject<List<FootModel>>();
  QueryDocumentSnapshot<Map<String, dynamic>>? listByDateKeyPage;
  List<FootModel>? listByDatePrevList;
  bool isListByDateLastPage = false;
  final int _pageSize = 20;

  @override
  void onInit() async {
    super.onInit();
    loadNewFootModel('date');
    listByDateScrollController.addListener(() {
      loadMoreFootModel('date');
    });
  }

  void loadNewFootModel(String type) async {
    List<FootModel> firstList = await getNewFootModel(_pageSize, null, null);
    listByDateStreamController.add(firstList);
  }

  void loadMoreFootModel(String type) async {
    if (listByDateScrollController.position.pixels ==
        listByDateScrollController.position.maxScrollExtent) {
      if (!isListByDateLastPage) {
        List<FootModel> nextList = await getNewFootModel(
            _pageSize, listByDateKeyPage, listByDatePrevList);
        listByDateStreamController.add(nextList);
      }
    }
  }

  Future<List<FootModel>> getNewFootModel(
    int pageSize,
    QueryDocumentSnapshot<Map<String, dynamic>>? keyPage,
    List<FootModel>? prevList,
  ) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collectionGroup('foot')
        .orderBy('createdAt', descending: true);
    if (keyPage != null) {
      query = query.startAfterDocument(keyPage);
    }
    query = query.limit(pageSize);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
    List<FootModel> footModels = prevList ?? [];
    for (var footModel in querySnapshot.docs) {
      footModels.add(FootModel.fromJson(footModel.data()));
    }
    //키페이지 설정
    QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument =
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
    listByDateKeyPage = lastDocument;
    //이전 리스트 저장
    listByDatePrevList = footModels;
    //마지막 페이지인지 여부 확인
    if (querySnapshot.docs.length < pageSize) {
      isListByDateLastPage = true;
    }
    return footModels;
  }
}
