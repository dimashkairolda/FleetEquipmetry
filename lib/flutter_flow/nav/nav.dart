import 'dart:async';

import 'package:Equipmetry/approvement/approvement/approvement_widget.dart';
import 'package:Equipmetry/approvement/approvement_detailed/approvement_detailed_widget.dart';
import 'package:Equipmetry/cto/create_c_t_o_maintenance/create_c_t_o_maintenance_widget.dart';
import 'package:Equipmetry/naryads/create_naryad_maintenance/create_naryad_maintenance_widget.dart';
import 'package:Equipmetry/procurement/add_price/add_price_widget.dart';
import 'package:Equipmetry/procurement/choose_T_M_C/choose_t_m_c_widget.dart';
import 'package:Equipmetry/procurement/compare_offers/compare_offers_widget.dart';
import 'package:Equipmetry/procurement/create_procurement/create_procurement_widget.dart';
import 'package:Equipmetry/procurement/manual_K_P/manual_K_P_widget.dart';
import 'package:Equipmetry/procurement/procurement/procurement_widget.dart';
import 'package:Equipmetry/procurement/procurement_detailed/procurement_detailed_widget.dart';
import 'package:Equipmetry/profile/defects/maintenance_c_t_o/maintenance_c_t_o_widget.dart';
import 'package:Equipmetry/profile/defects/maintenance_naryad/maintenance_naryad_widget.dart';
import 'package:Equipmetry/store_house/store_house_invoice/store_house_invoice_widget.dart';
import 'package:Equipmetry/store_house/store_house_receive/store_house_receive_widget.dart';
import 'package:Equipmetry/store_house/store_house_write_off/store_house_write_off_widget.dart';
import 'package:Equipmetry/testgo/testgo/testgo_widget.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';
import '/profile/bottom_nav_settings/bottom_nav_settings_widget.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  Equip2AuthUser? initialUser;
  Equip2AuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(Equip2AuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      observers: [MyApp.observer,FirebaseScreenObserver(),AppMetricaObserver(),],
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : AuthLoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : AuthLoginWidget(),
        ),
        FFRoute(
          name: AuthLoginWidget.routeName,
          path: AuthLoginWidget.routePath,
          builder: (context, params) => AuthLoginWidget(),
        ),
        FFRoute(
          name: CreateDefectWidget.routeName,
          path: CreateDefectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateDefectWidget(
            equipId: params.getParam(
              'equipId',
              ParamType.String,
            ),
            departmentid: params.getParam(
              'departmentid',
              ParamType.int,
            ),
            brandname: params.getParam(
              'brandname',
              ParamType.String,
            ),
            modelname: params.getParam(
              'modelname',
              ParamType.String,
            ),
            number: params.getParam(
              'number',
              ParamType.String,
            ),
            nazvanie: params.getParam(
              'nazvanie',
              ParamType.String,
            ),
            description: params.getParam(
              'description',
              ParamType.String,
            ),
            categoryid: params.getParam(
              'categoryid',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            probeg: params.getParam(
              'probeg',
              ParamType.int,
            ),
            motohours: params.getParam(
              'motohours',
              ParamType.int,
            ),
            gpsid: params.getParam(
              'gpsid',
              ParamType.int,
            ),
            users: params.getParam<String>(
              'users',
              ParamType.String,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: CreateProcurementWidget.routeName,
          path: CreateProcurementWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateProcurementWidget(
            initialTitle: params.getParam(
              'initialTitle',
              ParamType.String,
            ),
          ),
        ),
        
        FFRoute(
          name: DefectsWidget.routeName,
          path: DefectsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Defects')
              : DefectsWidget(),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'profilePage')
              : ProfilePageWidget(),
        ),
        FFRoute(
          name: 'BottomNavSettings',
          path: BottomNavSettingsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => const BottomNavSettingsWidget(),
        ),
        FFRoute(
          name: EquipmentsTreeWidget.routeName,
          path: EquipmentsTreeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EquipmentsTreeWidget(),
        ),
        FFRoute(
          name: InspectionsWidget.routeName,
          path: InspectionsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => InspectionsWidget(),
        ),
        FFRoute(
          name: DetailedInspectionsWidget.routeName,
          path: DetailedInspectionsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedInspectionsWidget(
            name: params.getParam(
              'name',
              ParamType.JSON,
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: DetailedInspectionsCopyWidget.routeName,
          path: DetailedInspectionsCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedInspectionsCopyWidget(
            asd: params.getParam(
              'asd',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: DetailedInspectionsCopyCopyWidget.routeName,
          path: DetailedInspectionsCopyCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedInspectionsCopyCopyWidget(
            json: params.getParam<dynamic>(
              'json',
              ParamType.JSON,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: RemontWidget.routeName,
          path: RemontWidget.routePath,
          requireAuth: true,
          builder: (context, params) => RemontWidget(
            needtoedit: params.getParam(
              'needtoedit',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: MainPageWidget.routeName,
          path: MainPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MainPageWidget(),
        ),
        FFRoute(
          name: TestgoWidget.routeName,
          path: TestgoWidget.routePath,
          requireAuth: true,
          builder: (context, params) => TestgoWidget(),
        ),
        FFRoute(
          name: CreateDefectFromInspectionWidget.routeName,
          path: CreateDefectFromInspectionWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateDefectFromInspectionWidget(
            searchid: params.getParam(
              'searchid',
              ParamType.int,
            ),
            equipid: params.getParam(
              'equipid',
              ParamType.int,
            ),
            formTitle: params.getParam(
              'formTitle',
              ParamType.String,
            ),
            text: params.getParam(
              'text',
              ParamType.String,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            reason: params.getParam(
              'reason',
              ParamType.String,
            ),
            event: params.getParam(
              'event',
              ParamType.String,
            ),
            type: params.getParam(
              'type',
              ParamType.String,
            ),
            isfixedonplace: params.getParam(
              'isfixedonplace',
              ParamType.int,
            ),
            isemergencysituation: params.getParam(
              'isemergencysituation',
              ParamType.int,
            ),
            name: params.getParam(
              'name',
              ParamType.JSON,
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ConfirmDefectPageWidget.routeName,
          path: ConfirmDefectPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ConfirmDefectPageWidget(
            equipID: params.getParam(
              'equipID',
              ParamType.int,
            ),
            type: params.getParam(
              'type',
              ParamType.String,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            reason: params.getParam(
              'reason',
              ParamType.String,
            ),
            events: params.getParam(
              'events',
              ParamType.String,
            ),
            equiptitle: params.getParam(
              'equiptitle',
              ParamType.String,
            ),
            authorid: params.getParam(
              'authorid',
              ParamType.int,
            ),
            authorfirstname: params.getParam(
              'authorfirstname',
              ParamType.String,
            ),
            authorlastname: params.getParam(
              'authorlastname',
              ParamType.String,
            ),
            isemergencysituation: params.getParam(
              'isemergencysituation',
              ParamType.int,
            ),
            isfixedonplace: params.getParam(
              'isfixedonplace',
              ParamType.int,
            ),
            responsible: params.getParam(
              'responsible',
              ParamType.int,
            ),
            department: params.getParam(
              'department',
              ParamType.String,
            ),
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: DetailedWidget.routeName,
          path: DetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedWidget(
            aa: params.getParam(
              'aa',
              ParamType.DataStruct,
              isList: false,
              structBuilder: DoprasxodyStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: InspectionsCopyWidget.routeName,
          path: InspectionsCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => InspectionsCopyWidget(
            id: params.getParam(
              'id',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: InspectionsTimeListWidget.routeName,
          path: InspectionsTimeListWidget.routePath,
          requireAuth: true,
          builder: (context, params) => InspectionsTimeListWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: PdfviewerWidget.routeName,
          path: PdfviewerWidget.routePath,
          requireAuth: true,
          builder: (context, params) => PdfviewerWidget(
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            viewer: params.getParam(
              'viewer',
              ParamType.String,
            ),
            extension: params.getParam(
              'extension',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ChooseassetWidget.routeName,
          path: ChooseassetWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseassetWidget(),
        ),
        FFRoute(
          name: ChooseTMCWidget.routeName,
          path: ChooseTMCWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseTMCWidget(),
        ),
        FFRoute(
          name: AddPriceWidget.routeName,
          path: AddPriceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AddPriceWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: CompareOffersWidget.routeName,
          path: CompareOffersWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CompareOffersWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: ManualKPWidget.routeName,
          path: ManualKPWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ManualKPWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: ChoosecatalogWidget.routeName,
          path: ChoosecatalogWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChoosecatalogWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            parentid: params.getParam(
              'parentid',
              ParamType.String,
            ),
            catalogid: params.getParam(
              'catalogid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ChoosecatalogCopyWidget.routeName,
          path: ChoosecatalogCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChoosecatalogCopyWidget(
            image: params.getParam(
              'image',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            json: params.getParam<dynamic>(
              'json',
              ParamType.JSON,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: VlozheniaWidget.routeName,
          path: VlozheniaWidget.routePath,
          requireAuth: true,
          builder: (context, params) => VlozheniaWidget(),
        ),
        FFRoute(
          name: SparepartsWidget.routeName,
          path: SparepartsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SparepartsWidget(
            needtoedit: params.getParam(
              'needtoedit',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: VlozheniWidget.routeName,
          path: VlozheniWidget.routePath,
          requireAuth: true,
          builder: (context, params) => VlozheniWidget(
            todo: params.getParam<dynamic>(
              'todo',
              ParamType.JSON,
              isList: true,
            ),
            todo2: params.getParam<String>(
              'todo2',
              ParamType.String,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: SaveddefectsWidget.routeName,
          path: SaveddefectsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SaveddefectsWidget(
            equipID: params.getParam(
              'equipID',
              ParamType.String,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            description: params.getParam(
              'description',
              ParamType.String,
            ),
            equiptitle: params.getParam(
              'equiptitle',
              ParamType.String,
            ),
            author: params.getParam(
              'author',
              ParamType.String,
            ),
            mileage: params.getParam(
              'mileage',
              ParamType.String,
            ),
            category: params.getParam(
              'category',
              ParamType.String,
            ),
            motohours: params.getParam(
              'motohours',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            todo: params.getParam<TodoStruct>(
              'todo',
              ParamType.DataStruct,
              isList: true,
              structBuilder: TodoStruct.fromSerializableMap,
            ),
            tmc: params.getParam<SparePartsStruct>(
              'tmc',
              ParamType.DataStruct,
              isList: true,
              structBuilder: SparePartsStruct.fromSerializableMap,
            ),
            photos: params.getParam<String>(
              'photos',
              ParamType.String,
              isList: true,
            ),
            status: params.getParam(
              'status',
              ParamType.String,
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: DetailedDefectsOfflineCopyWidget.routeName,
          path: DetailedDefectsOfflineCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DetailedDefectsOfflineCopyWidget(
            equipID: params.getParam(
              'equipID',
              ParamType.int,
            ),
            type: params.getParam(
              'type',
              ParamType.String,
            ),
            title: params.getParam(
              'title',
              ParamType.String,
            ),
            reason: params.getParam(
              'reason',
              ParamType.String,
            ),
            events: params.getParam(
              'events',
              ParamType.String,
            ),
            equiptitle: params.getParam(
              'equiptitle',
              ParamType.String,
            ),
            authorid: params.getParam(
              'authorid',
              ParamType.int,
            ),
            authorfirstname: params.getParam(
              'authorfirstname',
              ParamType.String,
            ),
            responsible: params.getParam(
              'responsible',
              ParamType.int,
            ),
            department: params.getParam(
              'department',
              ParamType.String,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            storehousestatus: params.getParam(
              'storehousestatus',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: NaryadsWidget.routeName,
          path: NaryadsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Naryads')
              : NaryadsWidget(),
        ),
        
        FFRoute(
          name: NaryadsOfflineWidget.routeName,
          path: NaryadsOfflineWidget.routePath,
          requireAuth: true,
          builder: (context, params) => NaryadsOfflineWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: ApprovementWidget.routeName,
          path: ApprovementWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ApprovementWidget(
            
          ),
        ),
        FFRoute(
          name: MileageWidget.routeName,
          path: MileageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MileageWidget(
            equipid: params.getParam(
              'equipid',
              ParamType.String,
            ),
            lastmileage: params.getParam(
              'lastmileage',
              ParamType.int,
            ),
            lastmotohour: params.getParam(
              'lastmotohour',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: InspectionsShablonWidget.routeName,
          path: InspectionsShablonWidget.routePath,
          requireAuth: true,
          builder: (context, params) => InspectionsShablonWidget(
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: CreateFormWidget.routeName,
          path: CreateFormWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateFormWidget(
            equipId: params.getParam(
              'equipId',
              ParamType.int,
            ),
            departmentid: params.getParam(
              'departmentid',
              ParamType.int,
            ),
            brandname: params.getParam(
              'brandname',
              ParamType.String,
            ),
            modelname: params.getParam(
              'modelname',
              ParamType.String,
            ),
            number: params.getParam(
              'number',
              ParamType.String,
            ),
            nazvanie: params.getParam(
              'nazvanie',
              ParamType.String,
            ),
            description: params.getParam(
              'description',
              ParamType.String,
            ),
            categoryid: params.getParam(
              'categoryid',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            probeg: params.getParam(
              'probeg',
              ParamType.int,
            ),
            motohours: params.getParam(
              'motohours',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: CreateQuestionsWidget.routeName,
          path: CreateQuestionsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateQuestionsWidget(
            type: params.getParam(
              'type',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: MaintenanceWidget.routeName,
          path: MaintenanceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MaintenanceWidget(),
        ),
        FFRoute(
          name: MaintenanceDetailedWidget.routeName,
          path: MaintenanceDetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MaintenanceDetailedWidget(
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ApprovementDetailedWidget.routeName,
          path: ApprovementDetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ApprovementDetailedWidget(
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EditDefectWidget.routeName,
          path: EditDefectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditDefectWidget(
            equipId: params.getParam(
              'equipId',
              ParamType.String,
            ),
            nazvanie: params.getParam(
              'nazvanie',
              ParamType.String,
            ),
            description: params.getParam(
              'description',
              ParamType.String,
            ),
            categoryid: params.getParam(
              'categoryid',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            probeg: params.getParam(
              'probeg',
              ParamType.int,
            ),
            motohours: params.getParam(
              'motohours',
              ParamType.int,
            ),
            media: params.getParam(
              'media',
              ParamType.JSON,
            ),
            spareparts: params.getParam<SparePartsStruct>(
              'spareparts',
              ParamType.DataStruct,
              isList: true,
              structBuilder: SparePartsStruct.fromSerializableMap,
            ),
            todo: params.getParam<TodoStruct>(
              'todo',
              ParamType.DataStruct,
              isList: true,
              structBuilder: TodoStruct.fromSerializableMap,
            ),
            defectid: params.getParam(
              'defectid',
              ParamType.String,
            ),
            sparepart1: params.getParam<dynamic>(
              'sparepart1',
              ParamType.JSON,
              isList: true,
            ),
            todo1: params.getParam<dynamic>(
              'todo1',
              ParamType.JSON,
              isList: true,
            ),
            brandname: params.getParam(
              'brandname',
              ParamType.String,
            ),
            modelname: params.getParam(
              'modelname',
              ParamType.String,
            ),
            number: params.getParam(
              'number',
              ParamType.String,
            ),
            page: params.getParam(
              'page',
              ParamType.int,
            ),
            users: params.getParam<String>(
              'users',
              ParamType.String,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: CreateNaryadFromDefectWidget.routeName,
          path: CreateNaryadFromDefectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateNaryadFromDefectWidget(
            spareparts: params.getParam<SparePartsStruct>(
              'spareparts',
              ParamType.DataStruct,
              isList: true,
              structBuilder: SparePartsStruct.fromSerializableMap,
            ),
            todo: params.getParam<TodoStruct>(
              'todo',
              ParamType.DataStruct,
              isList: true,
              structBuilder: TodoStruct.fromSerializableMap,
            ),
            defectid: params.getParam(
              'defectid',
              ParamType.String,
            ),
            defectName: params.getParam(
              'defectName',
              ParamType.String,
            ),
            equipmentid: params.getParam(
              'equipmentid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StoreHouseWidget.routeName,
          path: StoreHouseWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseWidget(),
        ),
        FFRoute(
          name: SparePartsWarehouseWidget.routeName,
          path: SparePartsWarehouseWidget.routePath,
          requireAuth: true,
          builder: (context, params) => const SparePartsWarehouseWidget(),
        ),
        FFRoute(
          name: SparePartProfileWidget.routeName,
          path: SparePartProfileWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SparePartProfileWidget(
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StoreHouseDetailedWidget.routeName,
          path: StoreHouseDetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseDetailedWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            srokdostavki: params.getParam(
              'srokdostavki',
              ParamType.String,
            ),
            status: params.getParam(
              'status',
              ParamType.String,
            ),

          ),
        ),
        FFRoute(
          name: ProcurementDetailedWidget.routeName,
          path: ProcurementDetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProcurementDetailedWidget(
            
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          

          ),
        ),
        FFRoute(
          name: StoreHouseEditTMCWidget.routeName,
          path: StoreHouseEditTMCWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseEditTMCWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StoreHouseZakupTMCWidget.routeName,
          path: StoreHouseZakupTMCWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseZakupTMCWidget(
            json: params.getParam<dynamic>(
              'json',
              ParamType.JSON,
              isList: true,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StoreHouseZakupTMCALLWidget.routeName,
          path: StoreHouseZakupTMCALLWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseZakupTMCALLWidget(
            json: params.getParam<dynamic>(
              'json',
              ParamType.JSON,
              isList: true,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: RaportWidget.routeName,
          path: RaportWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Raport')
              : RaportWidget(),
        ),
        FFRoute(
          name: RaportSelectDriverWidget.routeName,
          path: RaportSelectDriverWidget.routePath,
          requireAuth: true,
          builder: (context, params) => RaportSelectDriverWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: LoadingPageWidget.routeName,
          path: LoadingPageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => LoadingPageWidget(),
        ),
        FFRoute(
          name: CreateNaryadWidget.routeName,
          path: CreateNaryadWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateNaryadWidget(
            spareparts: params.getParam<SparePartsStruct>(
              'spareparts',
              ParamType.DataStruct,
              isList: true,
              structBuilder: SparePartsStruct.fromSerializableMap,
            ),
            todo: params.getParam<TodoStruct>(
              'todo',
              ParamType.DataStruct,
              isList: true,
              structBuilder: TodoStruct.fromSerializableMap,
            ),
            defectid: params.getParam(
              'defectid',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            equipmentid: params.getParam(
              'equipmentid',
              ParamType.String,
            ),
            equipname: params.getParam(
              'equipname',
              ParamType.String,
            ),
            equipplatenumber: params.getParam(
              'equipplatenumber',
              ParamType.String,
            ),
            defectName: params.getParam(
              'defectName',
              ParamType.String,
            ),
            defectId: params.getParam(
              'defectId',
              ParamType.String,
            ),
            mesto: params.getParam(
              'mesto',
              ParamType.String,
            ),
            assignee: params.getParam<String>(
              'assignee',
              ParamType.String,
              isList: true,
            ),
            priemwik: params.getParam(
              'priemwik',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            defectstatus: params.getParam(
              'defectstatus',
              ParamType.String,
            ),
            defectdate: params.getParam(
              'defectdate',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CreateNaryadMaintenanceWidget.routeName,
          path: CreateNaryadMaintenanceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateNaryadMaintenanceWidget(
            spareparts: params.getParam<SparePartsStruct>(
              'spareparts',
              ParamType.DataStruct,
              isList: true,
              structBuilder: SparePartsStruct.fromSerializableMap,
            ),
            todo: params.getParam<TodoStruct>(
              'todo',
              ParamType.DataStruct,
              isList: true,
              structBuilder: TodoStruct.fromSerializableMap,
            ),
            defectid: params.getParam(
              'defectid',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            equipmentid: params.getParam(
              'equipmentid',
              ParamType.String,
            ),
            equipname: params.getParam(
              'equipname',
              ParamType.String,
            ),
            equipplatenumber: params.getParam(
              'equipplatenumber',
              ParamType.String,
            ),
            defectName: params.getParam(
              'defectName',
              ParamType.String,
            ),
            defectId: params.getParam(
              'defectId',
              ParamType.String,
            ),
            mesto: params.getParam(
              'mesto',
              ParamType.String,
            ),
            assignee: params.getParam<String>(
              'assignee',
              ParamType.String,
              isList: true,
            ),
            priemwik: params.getParam(
              'priemwik',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            defectstatus: params.getParam(
              'defectstatus',
              ParamType.String,
            ),
            defectdate: params.getParam(
              'defectdate',
              ParamType.String,
            ),
            maintenanceId: params.getParam(
              'maintenanceId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DefectsCopyWidget.routeName,
          path: DefectsCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DefectsCopyWidget(),
        ),
        FFRoute(
          name: ChooseDriverWidget.routeName,
          path: ChooseDriverWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseDriverWidget(
            iscurrent: params.getParam(
              'iscurrent',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: DefectNaryadWidget.routeName,
          path: DefectNaryadWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DefectNaryadWidget(
            platenumber: params.getParam(
              'platenumber',
              ParamType.String,
            ),
            equipmentname: params.getParam(
              'equipmentname',
              ParamType.String,
            ),
            equipmentid: params.getParam(
              'equipmentid',
              ParamType.String,
            ),
            mesto: params.getParam(
              'mesto',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            assignee: params.getParam<String>(
              'assignee',
              ParamType.String,
              isList: true,
            ),
            priemwik: params.getParam(
              'priemwik',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ProjectWidget.routeName,
          path: ProjectWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProjectWidget(),
        ),
        FFRoute(
          name: ProjectdetailedWidget.routeName,
          path: ProjectdetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProjectdetailedWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: SelectProjectMonitoringWidget.routeName,
          path: SelectProjectMonitoringWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SelectProjectMonitoringWidget(
            equipmentId: params.getParam(
              'equipmentId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ChooseDriveWidget.routeName,
          path: ChooseDriveWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseDriveWidget(
            nn: params.getParam(
              'nn',
              ParamType.int,
            ),
          ),
        ),
        
        FFRoute(
          name: EquipmentsDetailedCopyWidget.routeName,
          path: EquipmentsDetailedCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EquipmentsDetailedCopyWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            tab: params.getParam(
              'tab',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ProcurementWidget.routeName,
          path: ProcurementWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProcurementWidget(
           
          ),
        ),
        FFRoute(
          name: SlideWidget.routeName,
          path: SlideWidget.routePath,
          requireAuth: true,
          builder: (context, params) => SlideWidget(),
        ),
        FFRoute(
          name: EditNaryadWidget.routeName,
          path: EditNaryadWidget.routePath,
          requireAuth: true,
          builder: (context, params) => EditNaryadWidget(
            spareparts: params.getParam<SparePartsStruct>(
              'spareparts',
              ParamType.DataStruct,
              isList: true,
              structBuilder: SparePartsStruct.fromSerializableMap,
            ),
            todo: params.getParam<TodoStruct>(
              'todo',
              ParamType.DataStruct,
              isList: true,
              structBuilder: TodoStruct.fromSerializableMap,
            ),
            defectid: params.getParam(
              'defectid',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            equipmentid: params.getParam(
              'equipmentid',
              ParamType.String,
            ),
            equipname: params.getParam(
              'equipname',
              ParamType.String,
            ),
            equipplatenumber: params.getParam(
              'equipplatenumber',
              ParamType.String,
            ),
            defectName: params.getParam(
              'defectName',
              ParamType.String,
            ),
            defectId: params.getParam(
              'defectId',
              ParamType.String,
            ),
            mesto: params.getParam(
              'mesto',
              ParamType.String,
            ),
            assignee: params.getParam<String>(
              'assignee',
              ParamType.String,
              isList: true,
            ),
            priemwik: params.getParam(
              'priemwik',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
            defectstatus: params.getParam(
              'defectstatus',
              ParamType.String,
            ),
            defectdate: params.getParam(
              'defectdate',
              ParamType.String,
            ),
            naryadid: params.getParam(
              'naryadid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CreateDefectCopyWidget.routeName,
          path: CreateDefectCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateDefectCopyWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: LoadingPageCopyWidget.routeName,
          path: LoadingPageCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => LoadingPageCopyWidget(),
        ),
        FFRoute(
          name: ExpenseJournalWidget.routeName,
          path: ExpenseJournalWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ExpenseJournalWidget(),
        ),
        FFRoute(
          name: CtoWidget.routeName,
          path: CtoWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CtoWidget(),
        ),
        FFRoute(
          name: CTOdetailedWidget.routeName,
          path: CTOdetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CTOdetailedWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: CreateCTOWidget.routeName,
          path: CreateCTOWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateCTOWidget(
            brandname: params.getParam(
              'brandname',
              ParamType.String,
            ),
            modelname: params.getParam(
              'modelname',
              ParamType.String,
            ),
            number: params.getParam(
              'number',
              ParamType.String,
            ),
            asset: params.getParam(
              'asset',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CreateCTOMaintenanceWidget.routeName,
          path: CreateCTOMaintenanceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateCTOMaintenanceWidget(
            brandname: params.getParam(
              'brandname',
              ParamType.String,
            ),
            modelname: params.getParam(
              'modelname',
              ParamType.String,
            ),
            number: params.getParam(
              'number',
              ParamType.String,
            ),
            asset: params.getParam(
              'asset',
              ParamType.String,
            ),
            nazvanie: params.getParam(
              'nazvanie',
              ParamType.String,
            ),
            maintenanceId: params.getParam(
              'maintenanceId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: KpEditWidget.routeName,
          path: KpEditWidget.routePath,
          requireAuth: true,
          builder: (context, params) => KpEditWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: DefectCTOWidget.routeName,
          path: DefectCTOWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DefectCTOWidget(
            platenumber: params.getParam(
              'platenumber',
              ParamType.String,
            ),
            equipmentname: params.getParam(
              'equipmentname',
              ParamType.String,
            ),
            equipmentid: params.getParam(
              'equipmentid',
              ParamType.String,
            ),
            mesto: params.getParam(
              'mesto',
              ParamType.String,
            ),
            name: params.getParam(
              'name',
              ParamType.String,
            ),
            assignee: params.getParam<String>(
              'assignee',
              ParamType.String,
              isList: true,
            ),
            priemwik: params.getParam(
              'priemwik',
              ParamType.String,
            ),
            date: params.getParam(
              'date',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: KpAcceptWidget.routeName,
          path: KpAcceptWidget.routePath,
          requireAuth: true,
          builder: (context, params) => KpAcceptWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: ChooseassetCTOWidget.routeName,
          path: ChooseassetCTOWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseassetCTOWidget(),
        ),
        FFRoute(
          name: ReglamentsDetailedWidget.routeName,
          path: ReglamentsDetailedWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ReglamentsDetailedWidget(
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: MediaViewerWidget.routeName,
          path: MediaViewerWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MediaViewerWidget(
            data: params.getParam(
              'data',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: CreateDefectFromReglamentWidget.routeName,
          path: CreateDefectFromReglamentWidget.routePath,
          requireAuth: true,
          builder: (context, params) => CreateDefectFromReglamentWidget(
            equipId: params.getParam(
              'equipId',
              ParamType.String,
            ),
            brandname: params.getParam(
              'brandname',
              ParamType.String,
            ),
            probeg: params.getParam(
              'probeg',
              ParamType.int,
            ),
            motohours: params.getParam(
              'motohours',
              ParamType.int,
            ),
            reglamentid: params.getParam(
              'reglamentid',
              ParamType.String,
            ),
            structureIndex: params.getParam(
              'structureIndex',
              ParamType.int,
            ),
            questionIndex: params.getParam(
              'questionIndex',
              ParamType.int,
            ),
          ),
        ),
        FFRoute(
          name: ReglamentsWidget.routeName,
          path: ReglamentsWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Reglaments')
              : ReglamentsWidget(),
        ),
        FFRoute(
          name: ChooseassetNaryadWidget.routeName,
          path: ChooseassetNaryadWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ChooseassetNaryadWidget(),
        ),
        FFRoute(
          name: StoreHouseInvoiceWidget.routeName,
          path: StoreHouseInvoiceWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseInvoiceWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            itemsData: params.getParam(
              'itemsData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: MaintenanceNaryadWidget.routeName,
          path: MaintenanceNaryadWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MaintenanceNaryadWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            itemsData: params.getParam(
              'itemsData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: MaintenanceCTOWidget.routeName,
          path: MaintenanceCTOWidget.routePath,
          requireAuth: true,
          builder: (context, params) => MaintenanceCTOWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            itemsData: params.getParam(
              'itemsData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: StoreHouseWriteOffWidget.routeName,
          path: StoreHouseWriteOffWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseWriteOffWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            itemsData: params.getParam(
              'itemsData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: StoreHouseReceiveWidget.routeName,
          path: StoreHouseReceiveWidget.routePath,
          requireAuth: true,
          builder: (context, params) => StoreHouseReceiveWidget(
            json: params.getParam(
              'json',
              ParamType.JSON,
            ),
            id: params.getParam(
              'id',
              ParamType.String,
            ),
            itemsData: params.getParam(
              'itemsData',
              ParamType.JSON,
            ),
            invoices: params.getParam(
              'invoices',
              ParamType.JSON,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/authLogin';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Welcome_page.png',
                    fit: BoxFit.fitHeight,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child, name: state.name);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
class AppMetricaObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = route.settings.name;
    if (screenName != null) {
      AppMetrica.reportEvent(screenName);
    }
  }
}

class FirebaseScreenObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = route.settings.name;
    
    if (screenName != null) {
      // Отправляем стандартное событие просмотра экрана
      FirebaseAnalytics.instance.logEvent(
        name: screenName,
      );
      print('Firebase Analytics: logged screen $screenName');
    }
  }

  // Можно также добавить didPop, если хотите отслеживать возвраты назад
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final screenName = previousRoute?.settings.name;
    if (screenName != null) {
      FirebaseAnalytics.instance.logScreenView(screenName: screenName);
    }
  }
}
