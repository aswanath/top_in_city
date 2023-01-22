import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/core/constants.dart';
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
    on<BurgerMenuTapped>(_onBurgerMenuTapped);
    on<ContactFormSubmitted>(_onContactFormSubmitted);
  }

  FutureOr<void> _onContactFormSubmitted(ContactFormSubmitted event, emit) async {
    emit(LoadingState(isLoading: true));
    var isSuccess = await GoogleSheetsFormApi.createField(event.form);
    emit(LoadingState(isLoading: false));
    emit(ContactFormResult(isSuccess: isSuccess));
  }

  FutureOr<void> _onBurgerMenuTapped(BurgerMenuTapped event, emit) {
    emit(BurgerMenuChanged(isExpanded: !event.isExpanded));
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
    emit(NavigateToContactScreen());
  }

  FutureOr<void> _onHomeScreenTapped(event, emit) {
    emit(NavigateToHomeScreen());
  }

  FutureOr<void> _onInitializeApi(event, emit) async {
    await compute(GoogleSheetsFormApi.init,{});
    await compute(GoogleSheetsMenuApi.init,{});
    menuList = GoogleSheetsMenuApi.menuList;
    var menuListTitles = menuList?.map((e) => e.title).toList() ?? [];
    if (menuListTitles.isNotEmpty && footerLinks.length == 2) {
      footerLinks.insertAll(1, menuListTitles);
    }
    carouselImages = GoogleSheetsFormApi.images;
    emit(
      FetchedAllMenus(
        menuList: menuList,
      ),
    );
  }

  FutureOr<void> _onMenuTapped(MenuTapped event, emit) async {
    emit(LoadingState(isLoading: true));
    var menu =  GoogleSheetsMenuApi.getWorkSheet(title: event.menuTitle);
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
