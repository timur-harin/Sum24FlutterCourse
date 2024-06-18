// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:provider/provider.dart';

// import 'sessions_manager_model.dart';
// export 'sessions_manager_model.dart';

// class SessionsManagerWidget extends StatefulWidget {
//   const SessionsManagerWidget({super.key});

//   @override
//   State<SessionsManagerWidget> createState() => _SessionsManagerWidgetState();
// }

// class _SessionsManagerWidgetState extends State<SessionsManagerWidget> {
//   late SessionsManagerModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => SessionsManagerModel());

//     _model.textController1 ??= TextEditingController();
//     _model.textFieldFocusNode1 ??= FocusNode();

//     _model.textController2 ??= TextEditingController();
//     _model.textFieldFocusNode2 ??= FocusNode();

//     _model.textController3 ??= TextEditingController();
//     _model.textFieldFocusNode3 ??= FocusNode();
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Color(0xFFFFFFDD),
//         appBar: AppBar(
//           backgroundColor: Color(0x85FFFFDD),
//           automaticallyImplyLeading: true,
//           actions: [],
//           flexibleSpace: FlexibleSpaceBar(
//             title: Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
//               child: TextFormField(
//                 controller: _model.textController3,
//                 focusNode: _model.textFieldFocusNode3,
//                 autofocus: true,
//                 obscureText: false,
//                 decoration: InputDecoration(
//                   labelText: 'Sesstion title',
//                   labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
//                         fontFamily: 'Inter',
//                         letterSpacing: 0,
//                       ),
//                   hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
//                         fontFamily: 'Inter',
//                         letterSpacing: 0,
//                       ),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: FlutterFlowTheme.of(context).alternate,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: FlutterFlowTheme.of(context).primary,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   errorBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: FlutterFlowTheme.of(context).error,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedErrorBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: FlutterFlowTheme.of(context).error,
//                       width: 2,
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 style: FlutterFlowTheme.of(context).bodyMedium.override(
//                       fontFamily: 'Inter',
//                       letterSpacing: 0,
//                     ),
//                 validator: _model.textController3Validator.asValidator(context),
//               ),
//             ),
//             background: ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 'https://picsum.photos/id/115/600',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             centerTitle: true,
//             expandedTitleScale: 1.0,
//             titlePadding: EdgeInsets.all(14),
//           ),
//           toolbarHeight: 20,
//           elevation: 4,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(0, -1),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Container(
//                         width: 308,
//                         height: 49,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).tertiary,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: AlignmentDirectional(-1, 0),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: TextFormField(
//                                       controller: _model.textController1,
//                                       focusNode: _model.textFieldFocusNode1,
//                                       autofocus: true,
//                                       obscureText: false,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter Time',
//                                         hintStyle: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                               fontFamily: 'Inter',
//                                               letterSpacing: 0,
//                                             ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color(0x890299FF),
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .primary,
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         errorBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .error,
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         focusedErrorBorder:
//                                             UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .error,
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         contentPadding: EdgeInsets.all(8),
//                                       ),
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             fontFamily: 'Inter',
//                                             letterSpacing: 0,
//                                           ),
//                                       keyboardType: TextInputType.number,
//                                       validator: _model.textController1Validator
//                                           .asValidator(context),
//                                       inputFormatters: [_model.textFieldMask1],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: AlignmentDirectional(1, 0),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(6),
//                                   child: FFButtonWidget(
//                                     onPressed: () {
//                                       print('Button pressed ...');
//                                     },
//                                     text: 'X',
//                                     options: FFButtonOptions(
//                                       height: 40,
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           24, 0, 24, 0),
//                                       iconPadding:
//                                           EdgeInsetsDirectional.fromSTEB(
//                                               0, 0, 0, 0),
//                                       color: Color(0x580299FF),
//                                       textStyle: FlutterFlowTheme.of(context)
//                                           .titleSmall
//                                           .override(
//                                             fontFamily: 'Inter',
//                                             color: Colors.white,
//                                             letterSpacing: 0,
//                                           ),
//                                       elevation: 3,
//                                       borderSide: BorderSide(
//                                         width: 1,
//                                       ),
//                                       borderRadius: BorderRadius.circular(24),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(6),
//                       child: Container(
//                         width: 308,
//                         height: 49,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).secondary,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: AlignmentDirectional(-1, 0),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: TextFormField(
//                                       controller: _model.textController2,
//                                       focusNode: _model.textFieldFocusNode2,
//                                       autofocus: true,
//                                       obscureText: false,
//                                       decoration: InputDecoration(
//                                         hintText: 'Enter Time',
//                                         hintStyle: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                               fontFamily: 'Inter',
//                                               letterSpacing: 0,
//                                             ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: Color(0x890299FF),
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .primary,
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         errorBorder: UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .error,
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         focusedErrorBorder:
//                                             UnderlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: FlutterFlowTheme.of(context)
//                                                 .error,
//                                             width: 0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         contentPadding: EdgeInsets.all(8),
//                                       ),
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             fontFamily: 'Inter',
//                                             letterSpacing: 0,
//                                           ),
//                                       keyboardType: TextInputType.number,
//                                       validator: _model.textController2Validator
//                                           .asValidator(context),
//                                       inputFormatters: [_model.textFieldMask2],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: AlignmentDirectional(1, 0),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(6),
//                                   child: FFButtonWidget(
//                                     onPressed: () {
//                                       print('Button pressed ...');
//                                     },
//                                     text: 'X',
//                                     options: FFButtonOptions(
//                                       height: 40,
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           24, 0, 24, 0),
//                                       iconPadding:
//                                           EdgeInsetsDirectional.fromSTEB(
//                                               0, 0, 0, 0),
//                                       color: Color(0x56FF6A73),
//                                       textStyle: FlutterFlowTheme.of(context)
//                                           .titleSmall
//                                           .override(
//                                             fontFamily: 'Inter',
//                                             color: Colors.white,
//                                             letterSpacing: 0,
//                                           ),
//                                       elevation: 3,
//                                       borderSide: BorderSide(
//                                         width: 1,
//                                       ),
//                                       borderRadius: BorderRadius.circular(24),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Spacer(),
//               Padding(
//                 padding: EdgeInsets.all(4),
//                 child: Container(
//                   width: 232,
//                   height: 71,
//                   decoration: BoxDecoration(
//                     color: Color(0x740299FF),
//                     borderRadius: BorderRadius.circular(8),
//                     shape: BoxShape.rectangle,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: FFButtonWidget(
//                           onPressed: () {
//                             print('Button pressed ...');
//                           },
//                           text: 'START\n',
//                           options: FFButtonOptions(
//                             height: 40,
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//                             iconPadding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                             color: FlutterFlowTheme.of(context).tertiary,
//                             textStyle: FlutterFlowTheme.of(context)
//                                 .titleSmall
//                                 .override(
//                                   fontFamily: 'Inter',
//                                   letterSpacing: 0,
//                                 ),
//                             elevation: 3,
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: FFButtonWidget(
//                           onPressed: () {
//                             print('Button pressed ...');
//                           },
//                           text: 'ADD\n',
//                           options: FFButtonOptions(
//                             height: 40,
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//                             iconPadding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                             color: FlutterFlowTheme.of(context).tertiary,
//                             textStyle: FlutterFlowTheme.of(context)
//                                 .titleSmall
//                                 .override(
//                                   fontFamily: 'Inter',
//                                   letterSpacing: 0,
//                                 ),
//                             elevation: 3,
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
