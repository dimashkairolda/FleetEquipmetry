import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'vlozheni_model.dart';
export 'vlozheni_model.dart';

class VlozheniWidget extends StatefulWidget {
  const VlozheniWidget({
    super.key,
    this.todo,
    this.todo2,
  });

  final List<dynamic>? todo;
  final List<String>? todo2;

  static String routeName = 'vlozheni';
  static String routePath = '/vlozheni';

  @override
  State<VlozheniWidget> createState() => _VlozheniWidgetState();
}

class _VlozheniWidgetState extends State<VlozheniWidget> {
  late VlozheniModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VlozheniModel());

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
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF3466E7),
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();

              safeSetState(() {});
            },
          ),
          title: Text(
            'Вложения',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'SFProText',
                  color: Color(0xFF3466E7),
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 1.0,
        ),
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (widget.todo != null && (widget.todo)!.isNotEmpty) {
                return Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(11.5, 15.0, 11.5, 0.0),
                  child: Builder(
                    builder: (context) {
                      final todo = widget.todo?.toList() ?? [];

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: todo.length,
                        itemBuilder: (context, todoIndex) {
                          final todoItem = todo[todoIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FlutterFlowExpandedImageView(
                                    image: Image.network(
                                      todoItem.toString(),
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: todoItem.toString(),
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: todoItem.toString(),
                              transitionOnUserGestures: true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  todoItem.toString(),
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(11.5, 15.0, 11.5, 0.0),
                  child: Builder(
                    builder: (context) {
                      final todo = widget.todo2?.toList() ?? [];

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: todo.length,
                        itemBuilder: (context, todoIndex) {
                          final todoItem = todo[todoIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FlutterFlowExpandedImageView(
                                    image: Image.network(
                                      functions
                                          .stringToJson(todoItem)
                                          .toString(),
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: functions
                                        .stringToJson(todoItem)
                                        .toString(),
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: functions.stringToJson(todoItem).toString(),
                              transitionOnUserGestures: true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  functions.stringToJson(todoItem).toString(),
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
