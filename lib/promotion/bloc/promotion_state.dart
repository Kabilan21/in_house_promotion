part of 'promotion_bloc.dart';

class PromotionState extends Equatable {
  const PromotionState();

  @override
  List<Object> get props => [];
}

class PromotionInitial extends PromotionState {}

class PromotionLoadedState extends PromotionState {
  final List<App> apps;
  final bool shouldNotify;

  const PromotionLoadedState({required this.apps, required this.shouldNotify});
  @override
  List<Object> get props => [apps, shouldNotify];
}

class PromotionLoadingState extends PromotionState {}
