import '/flutter_flow/bottom_nav_config.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavSettingsWidget extends StatefulWidget {
  const BottomNavSettingsWidget({super.key});

  static String routeName = 'BottomNavSettings';
  static String routePath = '/bottomNavSettings';

  @override
  State<BottomNavSettingsWidget> createState() =>
      _BottomNavSettingsWidgetState();
}

class _BottomNavSettingsWidgetState extends State<BottomNavSettingsWidget> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List<String>.from(FFAppState().bottomNavModuleIds);
  }

  bool _isModuleAllowed(BottomNavModuleMeta meta) {
    if (meta.aclPath == null) return true;
    return functions
            .getAclValue(FFAppState().result, meta.aclPath!)
            .toString() !=
        '111';
  }

  void _persist(List<String> next) {
    final sanitized = FFAppState.sanitizeBottomNavModuleIds(next);
    setState(() => _selectedIds = sanitized);
    FFAppState().bottomNavModuleIds = sanitized;
  }

  void _addId(String id) {
    if (_selectedIds.contains(id)) return;
    if (_selectedIds.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не более 5 разделов на панели'),
        ),
      );
      return;
    }
    _persist([..._selectedIds, id]);
  }

  void _removeAt(int index) {
    if (_selectedIds[index] == kProfileBottomNavModuleId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Профиль нельзя убрать с нижней панели'),
        ),
      );
      return;
    }
    if (_selectedIds.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Оставьте хотя бы один раздел'),
        ),
      );
      return;
    }
    final next = List<String>.from(_selectedIds)..removeAt(index);
    _persist(next);
  }

  @override
  Widget build(BuildContext context) {
    final allowedCatalog =
        kAllBottomNavModules.where(_isModuleAllowed).toList();

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'Нижняя панель',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'SFProText',
                letterSpacing: 0,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Text(
            'На панели (до 5, «Профиль» всегда остаётся; перетащите для порядка)',
            style: FlutterFlowTheme.of(context).labelMedium,
          ),
          const SizedBox(height: 8),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: _selectedIds.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex -= 1;
              final next = List<String>.from(_selectedIds);
              final id = next.removeAt(oldIndex);
              next.insert(newIndex, id);
              _persist(next);
            },
            itemBuilder: (context, index) {
              final id = _selectedIds[index];
              final meta = bottomNavMetaFor(id);
              return Card(
                key: ValueKey<String>('bar-$id'),
                margin: const EdgeInsets.only(bottom: 8),
                color: FlutterFlowTheme.of(context).secondaryBackground,
                child: ListTile(
                  leading: ReorderableDragStartListener(
                    index: index,
                    child: Icon(
                      Icons.drag_handle,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                  title: Text(
                    meta?.label ?? id,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          fontSize: 14,
                        ),
                  ),
                  trailing: id == kProfileBottomNavModuleId
                      ? Icon(
                          Icons.lock_outline,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 22,
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: FlutterFlowTheme.of(context).error,
                          ),
                          onPressed: () => _removeAt(index),
                        ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Все разделы (как в профиле)',
            style: FlutterFlowTheme.of(context).labelMedium,
          ),
          const SizedBox(height: 8),
          ...allowedCatalog.map((meta) {
            final onBar = _selectedIds.contains(meta.id);
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              color: FlutterFlowTheme.of(context).secondaryBackground,
              child: ListTile(
                leading: meta.useFaIcon
                    ? FaIcon(
                        meta.icon,
                        size: 20,
                        color: FlutterFlowTheme.of(context).primaryText,
                      )
                    : Icon(
                        meta.icon,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 22,
                      ),
                title: Text(
                  meta.label,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SFProText',
                        fontSize: 14,
                      ),
                ),
                subtitle: meta.id == kProfileBottomNavModuleId
                    ? Text(
                        'Всегда на панели',
                        style: FlutterFlowTheme.of(context).bodySmall,
                      )
                    : onBar
                        ? Text(
                            'На панели',
                            style: FlutterFlowTheme.of(context).bodySmall,
                          )
                        : null,
                trailing: meta.id == kProfileBottomNavModuleId
                    ? Icon(
                        Icons.lock_outline,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      )
                    : onBar
                        ? Icon(
                            Icons.check_circle,
                            color: FlutterFlowTheme.of(context).primary,
                          )
                        : Icon(
                            Icons.add_circle_outline,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                onTap: meta.id == kProfileBottomNavModuleId || onBar
                    ? null
                    : () => _addId(meta.id),
              ),
            );
          }),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                _persist(List<String>.from(kDefaultBottomNavModuleIds));
              },
              child: const Text('Сбросить по умолчанию'),
            ),
          ),
        ],
      ),
    );
  }
}
