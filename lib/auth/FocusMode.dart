// import 'package:flutterflow_ui/flutterflow_ui.dart';
//
// // import '/flutter_flow/flutter_flow_icon_button.dart';
// // import '/flutter_flow/flutter_flow_theme.dart';
// // import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'FoucsModeModel.dart';
// export 'FoucsModeModel.dart';
//
// class FoucsMode extends StatefulWidget {
//   const FoucsMode({super.key});
//
//   @override
//   State<FoucsMode> createState() => _FoucsModeState();
// }
//
// class _FoucsModeState extends State<FoucsMode> {
//   late FoucsModeModel _model;
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => FoucsModeModel());
//   }
//
//   @override
//   void dispose() {
//     _model.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: const Color(0xFFD6D6D6),
//         appBar: AppBar(
//           backgroundColor: const Color(0xFFD6D6D6),
//           automaticallyImplyLeading: true,
//           leading: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: FlutterFlowIconButton(
//               borderColor: FlutterFlowTheme.of(context).primaryText,
//               borderRadius: 30.0,
//               borderWidth: 1.0,
//               buttonSize: 30.0,
//               fillColor: Colors.white,
//               icon: Icon(
//                 Icons.arrow_back_ios_rounded,
//                 color: FlutterFlowTheme.of(context).primaryText,
//                 size: 15.0,
//               ),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//               },
//
//             ),
//           ),
//           title: Text(
//             'Focus Mode Settings',
//             style: FlutterFlowTheme.of(context).bodyMedium.override(
//               fontFamily: 'Readex Pro',
//               fontSize: 24.0,
//               letterSpacing: 0.0,
//               fontWeight: FontWeight.w200,
//             ),
//           ),
//           actions: const [],
//           centerTitle: true,
//           elevation: 0.0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Align(
//                 alignment: const AlignmentDirectional(0.0, -1.0),
//                 child: Padding(
//                   padding:
//                   const EdgeInsetsDirectional.fromSTEB(50.0, 40.0, 50.0, 20.0),
//                   child: Container(
//                     width: 441.0,
//                     height: 176.0,
//                     decoration: BoxDecoration(
//                       color: FlutterFlowTheme.of(context).secondaryBackground,
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(20.0),
//                         bottomRight: Radius.circular(20.0),
//                         topLeft: Radius.circular(20.0),
//                         topRight: Radius.circular(20.0),
//                       ),
//                       border: Border.all(
//                         color: const Color(0xFFD6D6D6),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsetsDirectional.fromSTEB(
//                                   0.0, 30.0, 0.0, 0.0),
//                               child: Container(
//                                 width: 274.0,
//                                 height: 124.0,
//                                 decoration: BoxDecoration(
//                                   color: FlutterFlowTheme.of(context)
//                                       .secondaryBackground,
//                                 ),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     SwitchListTile.adaptive(
//                                       value: _model.activateFocusModeValue1 ??=
//                                       true,
//                                       onChanged: (newValue) async {
//                                         setState(() =>
//                                         _model.activateFocusModeValue1 =
//                                             newValue);
//                                       },
//                                       title: Text(
//                                         'Activate Focus Mode',
//                                         style: FlutterFlowTheme.of(context)
//                                             .displayMedium
//                                             .override(
//                                           fontFamily: 'Outfit',
//                                           fontSize: 16.0,
//                                           letterSpacing: 0.0,
//                                         ),
//                                       ),
//                                       tileColor: FlutterFlowTheme.of(context)
//                                           .secondaryBackground,
//                                       activeColor: Colors.white,
//                                       activeTrackColor: const Color(0xFF80E18A),
//                                       dense: true,
//                                       controlAffinity:
//                                       ListTileControlAffinity.trailing,
//                                       shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(0.0),
//                                           bottomRight: Radius.circular(0.0),
//                                           topLeft: Radius.circular(0.0),
//                                           topRight: Radius.circular(0.0),
//                                         ),
//                                       ),
//                                     ),
//                                     SwitchListTile.adaptive(
//                                       value: _model.activateFocusModeValue2 ??=
//                                       true,
//                                       onChanged: (newValue) async {
//                                         setState(() =>
//                                         _model.activateFocusModeValue2 =
//                                             newValue);
//                                       },
//                                       title: Text(
//                                         'Hide Bars',
//                                         style: FlutterFlowTheme.of(context)
//                                             .displayMedium
//                                             .override(
//                                           fontFamily: 'Outfit',
//                                           fontSize: 16.0,
//                                           letterSpacing: 0.0,
//                                         ),
//                                       ),
//                                       subtitle: Text(
//                                         'Status Bar and Navigation Bar',
//                                         style: FlutterFlowTheme.of(context)
//                                             .labelMedium
//                                             .override(
//                                           fontFamily: 'Readex Pro',
//                                           fontSize: 9.0,
//                                           letterSpacing: 0.0,
//                                         ),
//                                       ),
//                                       tileColor: FlutterFlowTheme.of(context)
//                                           .secondaryBackground,
//                                       activeColor: Colors.white,
//                                       activeTrackColor: const Color(0xFF80E18A),
//                                       dense: true,
//                                       controlAffinity:
//                                       ListTileControlAffinity.trailing,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 297.0,
//                 height: 27.0,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFD6D6D6),
//                 ),
//                 child: Text(
//                   'Customize your focus Mode from FocusFlow',
//                   textAlign: TextAlign.center,
//                   style: FlutterFlowTheme.of(context).bodyMedium.override(
//                     fontFamily: 'Readex Pro',
//                     fontSize: 12.0,
//                     letterSpacing: 0.0,
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
