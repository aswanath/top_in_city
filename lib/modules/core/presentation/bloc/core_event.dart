part of 'core_bloc.dart';

@immutable
abstract class CoreEvent {}

class InitializeApi extends CoreEvent {}

class HomeScreenTapped extends CoreEvent {}

class ContactScreenTapped extends CoreEvent {}

class MenuTapped extends CoreEvent {
  final String menuTitle;

  MenuTapped({
    required this.menuTitle,
  });
}

class FetchAllMenus extends CoreEvent {}

class SwitchLanguage extends CoreEvent {
  final bool isMalayalam;

  SwitchLanguage({required this.isMalayalam});
}
