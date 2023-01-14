part of 'core_bloc.dart';

@immutable
abstract class CoreState {}

class CoreInitial extends CoreState {}

class FetchedAllMenus extends CoreState {
  final List<Worksheet>? menuList;

  FetchedAllMenus({
    this.menuList,
  });
}

class NavigateToHomeScreen extends CoreState {}

class NavigateToContactScreen extends CoreState {}

class NavigateToMenuScreen extends CoreState {
  final String screenName;
  final List<List<String>>? menuRows;

  NavigateToMenuScreen({
    required this.screenName,
    this.menuRows,
  });
}

class ChangedLanguage extends CoreState {
  final bool isMalayalam;

  ChangedLanguage({required this.isMalayalam});
}
