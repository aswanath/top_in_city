import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';
import 'package:top_in_city/modules/contact/network/google_sheets_form_api.dart';
import 'package:top_in_city/modules/menu/network/google_form_menu_api.dart';

part 'core_event.dart';

part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  List<Worksheet>? menuList;

  CoreBloc() : super(CoreInitial()) {
    on<InitializeApi>(_onInitializeApi);
    on<MenuTapped>(_onMenuTapped);
    on<HomeScreenTapped>(_onHomeScreenTapped);
    on<ContactScreenTapped>(_onContactScreenTapped);
    on<FetchAllMenus>(_onFetchAllMenus);
    on<SwitchLanguage>(_onSwitchLanguage);
  }

  FutureOr<void> _onSwitchLanguage(SwitchLanguage event, emit) {
    emit(ChangedLanguage(isMalayalam: event.isMalayalam));
  }

  FutureOr<void> _onFetchAllMenus(event, emit) {
    emit(
      FetchedAllMenus(
        menuList: menuList,
      ),
    );
  }

  FutureOr<void> _onContactScreenTapped(event, emit) {
    emit(LoadingState(isLoading: true));
    emit(NavigateToContactScreen());
    emit(LoadingState(isLoading: false));
  }

  FutureOr<void> _onHomeScreenTapped(event, emit) {
    emit(LoadingState(isLoading: true));
    emit(NavigateToHomeScreen());
    emit(LoadingState(isLoading: false));
  }

  FutureOr<void> _onInitializeApi(event, emit) async {
    emit(LoadingState(isLoading: true));
    await GoogleSheetsFormApi.init();
    await GoogleSheetsMenuApi.init();
    menuList = GoogleSheetsMenuApi.menuList;
    emit(
      FetchedAllMenus(
        menuList: menuList,
      ),
    );
    emit(LoadingState(isLoading: false));
  }

  FutureOr<void> _onMenuTapped(MenuTapped event, emit) async {
    emit(LoadingState(isLoading: true));
    var menu = await GoogleSheetsMenuApi.getWorkSheet(title: event.menuTitle);
    var menuRows = await menu?.values.allRows();
    emit(
      NavigateToMenuScreen(
        screenName: menu?.title ?? '',
        menuRows: menuRows,
      ),
    );
    emit(LoadingState(isLoading: false));
  }
}
