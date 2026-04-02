import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'store_house_receive_model.dart';
export 'store_house_receive_model.dart';

class StoreHouseReceiveWidget extends StatefulWidget {
  const StoreHouseReceiveWidget({
    super.key,
    required this.json,
    required this.id,
    required this.itemsData,
    this.invoices,
  });

  final dynamic json;
  final String? id;
  final dynamic itemsData;
  final dynamic invoices;

  static String routeName = 'StoreHouseReceive';
  static String routePath = '/storeHouseReceive';

  @override
  State<StoreHouseReceiveWidget> createState() =>
      _StoreHouseReceiveWidgetState();
}

class _StoreHouseReceiveWidgetState extends State<StoreHouseReceiveWidget> {
  late StoreHouseReceiveModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreHouseReceiveModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().itemsOutOfStock =
          functions.groupAndSumTMC(widget.json).toList().cast<dynamic>();
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
          ),
          title: Text(
            'Оприходование',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.85,
                  child: custom_widgets.InventoryReceiveForm(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.85,
                    token: currentAuthenticationToken!,
                    workspaceId: FFAppState().workspace,
                    storehouseOrderId: widget.id!,
                    itemsData: widget.itemsData!,
                    invoicesData: widget.invoices!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
