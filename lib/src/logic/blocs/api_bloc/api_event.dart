part of 'api_bloc.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class LoadApi extends ApiEvent {}
 

class FailToLoadApi extends ApiEvent {}
