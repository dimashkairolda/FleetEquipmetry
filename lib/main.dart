import 'package:Equipmetry/firebase_options.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/custom_auth/auth_util.dart';
import 'auth/custom_auth/custom_auth_user_provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Equipmetry/approvement/approvement/approvement_widget.dart';
import 'package:Equipmetry/procurement/procurement/procurement_widget.dart';
import '/flutter_flow/bottom_nav_config.dart';
import '/flutter_flow/bottom_nav_primary_tab_scope.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppMetrica.activate(const AppMetricaConfig(
      "7630ee06-70bc-4ef1-a920-ff59db9718a0",
      logs: true));

  await authManager.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<Equip2AuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = equip2AuthUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });

    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Equip 2',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('ru'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({
    super.key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  });

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Raport';
  late Widget? _currentPage;
  late String _bottomNavSignature;

  @override
  void initState() {
    super.initState();
    _applyInitialTab();
    _currentPage = widget.page;
    _bottomNavSignature = FFAppState().bottomNavModuleIds.join('|');
    FFAppState().addListener(_onAppStateChanged);
  }

  void _applyInitialTab() {
    final tabIds = FFAppState().bottomNavModuleIds;
    final initial = widget.initialPage ?? 'Raport';
    _currentPageName =
        tabIds.contains(initial) ? initial : tabIds.first;
  }

  void _onAppStateChanged() {
    if (!mounted) return;
    final sig = FFAppState().bottomNavModuleIds.join('|');
    if (sig == _bottomNavSignature) return;
    _bottomNavSignature = sig;
    final tabIds = FFAppState().bottomNavModuleIds;
    if (!tabIds.contains(_currentPageName)) {
      safeSetState(() {
        _currentPageName = tabIds.isNotEmpty ? tabIds.first : 'Raport';
        _currentPage = null;
      });
    } else {
      safeSetState(() {});
    }
  }

  @override
  void dispose() {
    FFAppState().removeListener(_onAppStateChanged);
    super.dispose();
  }

  Widget _bodyForTab(String id) {
    switch (id) {
      case 'Raport':
        return const RaportWidget();
      case 'Defects':
        return const DefectsWidget();
      case 'Reglaments':
        return const ReglamentsWidget();
      case 'Naryads':
        return const NaryadsWidget();
      case 'profilePage':
        return const ProfilePageWidget();
      case 'EquipmentsTree':
        return const EquipmentsTreeWidget();
      case 'Maintenance':
        return const MaintenanceWidget();
      case 'ExpenseJournal':
        return const ExpenseJournalWidget();
      case 'Project':
        return const ProjectWidget();
      case 'StoreHouse':
        return const StoreHouseWidget();
      case 'sparePartsWarehouse':
        return const SparePartsWarehouseWidget();
      case 'CTO':
        return const CtoWidget();
      case 'Procurement':
        return const ProcurementWidget();
      case 'Approvement':
        return const ApprovementWidget();
      default:
        return const RaportWidget();
    }
  }

  BottomNavigationBarItem _navItem(
    BuildContext context,
    BottomNavModuleMeta meta,
  ) {
    final icon = meta.useFaIcon
        ? FaIcon(
            meta.icon,
            size: 22.0,
          )
        : Icon(
            meta.icon,
            size: 24.0,
          );
    return BottomNavigationBarItem(
      icon: icon,
      label: meta.label,
      tooltip: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabIds = FFAppState().bottomNavModuleIds;
    final items = <BottomNavigationBarItem>[];
    for (final id in tabIds) {
      final meta = bottomNavMetaFor(id);
      if (meta != null) {
        items.add(_navItem(context, meta));
      }
    }
    var currentIndex = tabIds.indexOf(_currentPageName);
    if (currentIndex < 0) {
      currentIndex = 0;
    }

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: BottomNavPrimaryTabScope(
        isPrimaryTab: tabIds.contains(_currentPageName),
        child: _currentPage ?? _bodyForTab(_currentPageName),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabIds[i];
          MyApp.analytics.logEvent(
            name: tabIds[i],
          );
          AppMetrica.reportEvent(tabIds[i]);
        }),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: items,
      ),
    );
  }
}
