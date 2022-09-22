part of 'go_router_bloc.dart';

class GoRouteState extends Equatable {
  final GoRouter? goRouter;

  const GoRouteState({
    required this.goRouter,
  });

  factory GoRouteState.initial() {
    return const GoRouteState(goRouter: null);
  }

  GoRouteState copyWith({
    GoRouter? goRouter,
  }) {
    return GoRouteState(
      goRouter: goRouter ?? this.goRouter,
    );
  }

  @override
  List<Object?> get props => [goRouter];
}
