part of 'promotion_bloc.dart';

class PromotionEvent extends Equatable {
  const PromotionEvent();

  @override
  List<Object> get props => [];
}

class LoadPromotionEvent extends PromotionEvent {}

class UpdateViewedAppsEvent extends PromotionEvent {
  final List<App> apps;

  const UpdateViewedAppsEvent({required this.apps});
}
