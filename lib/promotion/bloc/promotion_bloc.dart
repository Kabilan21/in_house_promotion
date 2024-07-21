import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_house_promotion/promotion/model/promotion.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  static String promotionKey = "appPromotion";
  static String viewedAppsKey = "viewedApps";
  String appIdentifier;
  FirebaseRemoteConfig config;
  SharedPreferences preferences;

  PromotionBloc(
      {required this.appIdentifier,
      required this.config,
      required this.preferences})
      : super(PromotionInitial()) {
    on<LoadPromotionEvent>(loadPromotion);
    on<UpdateViewedAppsEvent>(updateViewedApps);
  }

  FutureOr<void> loadPromotion(
      LoadPromotionEvent event, Emitter<PromotionState> emit) async {
    final viewedApps = preferences.getString(viewedAppsKey) ?? '';
    final promotion = Promotion.fromJson(config.getString(promotionKey));
    final canShowPromotion = promotion.canShowPromotion &&
        (!promotion.useDynamicKey || config.getBool(promotion.dynamicKey));
    final apps = canShowPromotion
        ? promotion.apps
            .where((app) =>
                app.platformAppUrl.isNotEmpty &&
                app.packageName != appIdentifier &&
                app.isEnabled &&
                (!app.useDynamicKey || config.getBool(app.dynamicKey)))
            .toList()
        : <App>[];

    final newAppList = apps.map((e) => e.packageName).join(",");
    if (apps.isNotEmpty) {
      emit(PromotionLoadedState(
          apps: apps, shouldNotify: viewedApps != newAppList));
    }
  }

  FutureOr<void> updateViewedApps(
      UpdateViewedAppsEvent event, Emitter<PromotionState> emit) {
    final newAppList = event.apps.map((e) => e.packageName).join(",");
    preferences.setString(viewedAppsKey, newAppList);
    emit(PromotionLoadedState(apps: event.apps, shouldNotify: false));
  }
}
