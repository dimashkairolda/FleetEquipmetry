import 'package:Equipmetry/approvement/approvement/approvement_widget.dart';
import 'package:Equipmetry/procurement/procurement/procurement_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/app_state.dart';
import '/cto/cto/cto_widget.dart';
import '/expense_journal/expense_journal/expense_journal_widget.dart';
import '/naryads/naryads/naryads_widget.dart';
import '/profile/defects/defects/defects_widget.dart';
import '/profile/defects/maintenance/maintenance_widget.dart';
import '/project/project/project_widget.dart';
import '/raport/raport/raport_widget.dart';
import '/reglaments/reglaments/reglaments_widget.dart';
import '/store_house/spare_parts_warehouse/spare_parts_warehouse_widget.dart';
import '/store_house/store_house/store_house_widget.dart';
import '/sync/equipments_tree/equipments_tree_widget.dart';

import 'bottom_nav_config.dart';

/// Opens the screen for a catalog module (same targets as the bottom bar / profile shortcuts).
Future<void> navigateToBottomNavModule(BuildContext context, String id) async {
  switch (id) {
    case 'Raport':
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(builder: (_) => const RaportWidget()),
      );
      break;
    case 'Defects':
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(builder: (_) => const DefectsWidget()),
      );
      break;
    case 'Reglaments':
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(builder: (_) => const ReglamentsWidget()),
      );
      break;
    case 'Naryads':
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(builder: (_) => const NaryadsWidget()),
      );
      break;
    case kProfileBottomNavModuleId:
      context.pushNamed('profilePage');
      break;
    case 'EquipmentsTree':
      context.pushNamed(EquipmentsTreeWidget.routeName);
      FFAppState().searchOutput = [];
      FFAppState().isShowFullList = true;
      break;
    case 'Maintenance':
      context.pushNamed(MaintenanceWidget.routeName);
      break;
    case 'ExpenseJournal':
      context.pushNamed(ExpenseJournalWidget.routeName);
      break;
    case 'Project':
      context.pushNamed(ProjectWidget.routeName);
      break;
    case 'StoreHouse':
      context.pushNamed(StoreHouseWidget.routeName);
      break;
    case 'sparePartsWarehouse':
      context.pushNamed(SparePartsWarehouseWidget.routeName);
      break;
    case 'CTO':
      context.pushNamed(CtoWidget.routeName);
      break;
    case 'Procurement':
      context.pushNamed(ProcurementWidget.routeName);
      break;
    case 'Approvement':
      context.pushNamed(ApprovementWidget.routeName);
      break;
    default:
      break;
  }
}
