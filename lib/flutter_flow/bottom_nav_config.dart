import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Metadata for items that can appear on the bottom navigation bar.
class BottomNavModuleMeta {
  const BottomNavModuleMeta({
    required this.id,
    required this.label,
    this.aclPath,
    required this.icon,
    this.useFaIcon = false,
  });

  final String id;
  final String label;

  /// When set, module is shown only if [functions.getAclValue] is not `'111'`.
  final String? aclPath;
  final IconData icon;
  final bool useFaIcon;
}

/// Always kept on the bottom bar (entry point to settings and overflow modules).
const String kProfileBottomNavModuleId = 'profilePage';

/// Default five tabs (current app behavior).
const List<String> kDefaultBottomNavModuleIds = <String>[
  'Raport',
  'Defects',
  'Reglaments',
  'Naryads',
  'profilePage',
];

/// All modules: main tabs plus the same destinations as on the profile page.
const List<BottomNavModuleMeta> kAllBottomNavModules = <BottomNavModuleMeta>[
  BottomNavModuleMeta(id: 'Raport', label: 'Мониторинг', icon: Icons.car_crash),
  BottomNavModuleMeta(
    id: 'Defects',
    label: 'Дефекты',
    icon: Icons.list_alt_outlined,
  ),
  BottomNavModuleMeta(
    id: 'Reglaments',
    label: 'Регламенты',
    icon: Icons.build_rounded,
  ),
  BottomNavModuleMeta(
    id: 'Naryads',
    label: 'Наряды',
    icon: FontAwesomeIcons.ticketSimple,
    useFaIcon: true,
  ),
  BottomNavModuleMeta(
    id: 'profilePage',
    label: 'Профиль',
    icon: Icons.person,
  ),
  BottomNavModuleMeta(
    id: 'EquipmentsTree',
    label: 'Парк оборудования',
    icon: Icons.account_circle_outlined,
  ),
  BottomNavModuleMeta(
    id: 'Maintenance',
    label: 'График обслуживания',
    aclPath: '/api/v1/workspace/service/maintenances/pre/preview',
    icon: Icons.timer_outlined,
  ),
  BottomNavModuleMeta(
    id: 'ExpenseJournal',
    label: 'Журнал расходов',
    aclPath: '/api/v1/workspace/service/maintenances/pre/preview',
    icon: Icons.moving,
  ),
  BottomNavModuleMeta(
    id: 'Project',
    label: 'Проектные заявки',
    aclPath: '/api/v1/workspace/projects',
    icon: Icons.article,
  ),
  BottomNavModuleMeta(
    id: 'StoreHouse',
    label: 'Ремонтное обеспечение',
    aclPath: '/api/v1/workspace/storehouse/orders/preview',
    icon: Icons.toc_sharp,
  ),
  BottomNavModuleMeta(
    id: 'sparePartsWarehouse',
    label: 'Склад запчастей',
    aclPath: '/api/v1/workspace/storehouse/orders/preview',
    icon: Icons.build_circle_outlined,
  ),
  BottomNavModuleMeta(
    id: 'CTO',
    label: 'СТО',
    aclPath: '/api/v1/workspace/application/preview',
    icon: Icons.settings_sharp,
  ),
  BottomNavModuleMeta(
    id: 'Procurement',
    label: 'Доска объявлений',
    aclPath: '/api/v1/workspace/procurement/preview',
    icon: Icons.manage_search,
  ),
  BottomNavModuleMeta(
    id: 'Approvement',
    label: 'Согласование',
    aclPath: '/api/v1/workspace/approval/preview',
    icon: Icons.checklist_rounded,
  ),
];

final Set<String> kValidBottomNavModuleIds =
    kAllBottomNavModules.map((e) => e.id).toSet();

BottomNavModuleMeta? bottomNavMetaFor(String id) {
  for (final m in kAllBottomNavModules) {
    if (m.id == id) return m;
  }
  return null;
}
