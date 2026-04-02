import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'detailed_inspections_copy_copy_model.dart';
export 'detailed_inspections_copy_copy_model.dart';

class DetailedInspectionsCopyCopyWidget extends StatefulWidget {
  const DetailedInspectionsCopyCopyWidget({
    super.key,
    this.json,
  });

  final List<dynamic>? json;

  static String routeName = 'detailedInspectionsCopyCopy';
  static String routePath = '/detailedInspectionsCopyCopy';

  @override
  State<DetailedInspectionsCopyCopyWidget> createState() =>
      _DetailedInspectionsCopyCopyWidgetState();
}

class _DetailedInspectionsCopyCopyWidgetState
    extends State<DetailedInspectionsCopyCopyWidget> {
  late DetailedInspectionsCopyCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedInspectionsCopyCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
              FFAppState().inspections = [];
              FFAppState().formresult1 = [];
              safeSetState(() {});
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              final as = widget.json?.toList() ?? [];

              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: as.length,
                itemBuilder: (context, asIndex) {
                  final asItem = as[asIndex];
                  return Container(
                    height: 200.0,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
