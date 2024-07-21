import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  static const defaultPromotion =
      Promotion(canShowPromotion: false, apps: [], useDynamicKey: false);

  final bool canShowPromotion;
  final bool useDynamicKey;
  final List<App> apps;
  const Promotion(
      {required this.canShowPromotion,
      required this.apps,
      required this.useDynamicKey});

  String get dynamicKey => "promotion_dynamic";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'canShowPromotion': canShowPromotion,
      'apps': apps.map((x) => x.toMap()).toList(),
      'useDynamicKey': useDynamicKey,
    };
  }

  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      canShowPromotion: (map['canShowPromotion'] ?? false) as bool,
      apps: List<App>.from(
        (map['apps'] as List<dynamic>)
            .map<App>((x) => App.fromMap(x as Map<String, dynamic>)),
      ),
      useDynamicKey: (map['useDynamicKey'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Promotion.fromJson(String source) =>
      Promotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [canShowPromotion, apps];
}

class App extends Equatable {
  final String name;
  final String packageName;
  final String appUrl;
  final String iosAppUrl;
  final String iconUrl;
  final String description;
  final String callToAction;
  final bool isNew;
  final bool isPrimary;
  final bool useDynamicKey;
  final bool isEnabled;
  const App({
    required this.name,
    required this.packageName,
    required this.appUrl,
    required this.iosAppUrl,
    required this.iconUrl,
    required this.description,
    required this.callToAction,
    required this.isNew,
    required this.isPrimary,
    required this.useDynamicKey,
    required this.isEnabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'packageName': packageName,
      'appUrl': appUrl,
      'iconUrl': iconUrl,
      'description': description,
      'callToAction': callToAction,
      'isNew': isNew,
      'useDynamicKey': useDynamicKey,
      'isPrimary': isPrimary,
      'isEnabled': isEnabled,
      'iosAppUrl': iosAppUrl
    };
  }

  factory App.fromMap(Map<String, dynamic> map) {
    return App(
      name: (map['name'] ?? '') as String,
      packageName: (map['packageName'] ?? '') as String,
      appUrl: (map['appUrl'] ?? '') as String,
      iosAppUrl: (map['appUrl'] ?? '') as String,
      iconUrl: (map['iconUrl'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      callToAction: (map['callToAction'] ?? '') as String,
      isNew: (map['isNew'] ?? false) as bool,
      useDynamicKey: (map['useDynamicKey'] ?? false) as bool,
      isPrimary: (map['isPrimary'] ?? false) as bool,
      isEnabled: (map['isEnabled'] ?? true) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory App.fromJson(String source) =>
      App.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  String get dynamicKey => "${cleanedPacakgeName}_dynamic";

  @override
  List<Object> get props {
    return [
      name,
      packageName,
      appUrl,
      iconUrl,
      description,
      callToAction,
      isNew,
      isPrimary,
      isEnabled
    ];
  }

  String get cleanedPacakgeName => packageName.replaceAll(".", "_");

  String get trackingEventName => "${cleanedPacakgeName}_install";

  String get platformAppUrl => Platform.isIOS ? iosAppUrl : appUrl;
}
