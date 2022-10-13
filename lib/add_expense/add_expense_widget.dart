import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '../flutter_flow/custom_functions.dart' as functions;
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AddExpenseWidget extends StatefulWidget {
  const AddExpenseWidget({
    Key? key,
    this.addExpenseUsers,
    this.chatID,
  }) : super(key: key);

  final DocumentReference? addExpenseUsers;
  final DocumentReference? chatID;

  @override
  _AddExpenseWidgetState createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  Map<UsersRecord, bool> checkboxListTileValueMap = {};
  List<UsersRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  TextEditingController? miniValueController;
  PagingController<DocumentSnapshot?, UsersRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  String? choiceChipsValue;
  TextEditingController? masterValueController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    masterValueController = TextEditingController();
    miniValueController = TextEditingController();
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    miniValueController?.dispose();
    masterValueController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatsRecord>>(
      future: ChatsRecord.search(
        term: '4xyM12SQ6I2dRO545uNY',
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        List<ChatsRecord> addExpenseChatsRecordList = snapshot.data!;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Align(
              alignment: AlignmentDirectional(1, 0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional(0, 0),
                  children: [
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2,
                          sigmaY: 2,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x25000000),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                      child: Stack(
                        children: [
                          Material(
                            color: Colors.transparent,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFEDF6F9),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 18, 0, 0),
                                      child: Text(
                                        'Add Expense',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 40, 0, 2),
                                      child: Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 1, 0, 0),
                                            child: FlutterFlowChoiceChips(
                                              options: [
                                                ChipData('   Request   '),
                                                ChipData('   Pay   ')
                                              ],
                                              onChanged: (val) => setState(() =>
                                                  choiceChipsValue =
                                                      val?.first),
                                              selectedChipStyle: ChipStyle(
                                                backgroundColor:
                                                    Color(0xFF09567A),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 20,
                                                          lineHeight: 2,
                                                        ),
                                                iconColor: Colors.white,
                                                iconSize: 50,
                                                elevation: 1,
                                              ),
                                              unselectedChipStyle: ChipStyle(
                                                backgroundColor:
                                                    Color(0xFF81ECEC),
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0x7757636C),
                                                      lineHeight: 1,
                                                    ),
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                iconSize: 20,
                                                elevation: 1,
                                              ),
                                              chipSpacing: 15,
                                              multiselect: false,
                                              alignment: WrapAlignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 30, 16, 0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 80,
                                          constraints: BoxConstraints(
                                            maxWidth: double.infinity,
                                            maxHeight: double.infinity,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.7, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                20, 0, 15, 0),
                                                    child: Text(
                                                      '\$',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 30,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 30, 0),
                                                      child: TextFormField(
                                                        controller:
                                                            masterValueController,
                                                        onChanged: (_) =>
                                                            EasyDebounce
                                                                .debounce(
                                                          'masterValueController',
                                                          Duration(
                                                              milliseconds:
                                                                  100),
                                                          () async {
                                                            setState(() => FFAppState()
                                                                    .MasterValue =
                                                                double.parse(
                                                                    masterValueController!
                                                                        .text));
                                                          },
                                                        ),
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          hintText: '0.00',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    fontSize:
                                                                        40,
                                                                  ),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          errorBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0x00000000),
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      4.0),
                                                            ),
                                                          ),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  fontSize: 40,
                                                                ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        keyboardType:
                                                            const TextInputType
                                                                    .numberWithOptions(
                                                                signed: true,
                                                                decimal: true),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: PagedListView<
                                          DocumentSnapshot<Object?>?,
                                          UsersRecord>(
                                        pagingController: () {
                                          final Query<Object?> Function(
                                                  Query<Object?>) queryBuilder =
                                              (usersRecord) => usersRecord
                                                  .orderBy('display_name');
                                          if (_pagingController != null) {
                                            final query = queryBuilder(
                                                UsersRecord.collection);
                                            if (query != _pagingQuery) {
                                              // The query has changed
                                              _pagingQuery = query;
                                              _streamSubscriptions
                                                  .forEach((s) => s?.cancel());
                                              _streamSubscriptions.clear();
                                              _pagingController!.refresh();
                                            }
                                            return _pagingController!;
                                          }

                                          _pagingController = PagingController(
                                              firstPageKey: null);
                                          _pagingQuery = queryBuilder(
                                              UsersRecord.collection);
                                          _pagingController!
                                              .addPageRequestListener(
                                                  (nextPageMarker) {
                                            queryUsersRecordPage(
                                              queryBuilder: (usersRecord) =>
                                                  usersRecord
                                                      .orderBy('display_name'),
                                              nextPageMarker: nextPageMarker,
                                              pageSize: 25,
                                              isStream: true,
                                            ).then((page) {
                                              _pagingController!.appendPage(
                                                page.data,
                                                page.nextPageMarker,
                                              );
                                              final streamSubscription = page
                                                  .dataStream
                                                  ?.listen((data) {
                                                final itemIndexes =
                                                    _pagingController!.itemList!
                                                        .asMap()
                                                        .map((k, v) => MapEntry(
                                                            v.reference.id, k));
                                                data.forEach((item) {
                                                  final index = itemIndexes[
                                                      item.reference.id];
                                                  final items =
                                                      _pagingController!
                                                          .itemList!;
                                                  if (index != null) {
                                                    items.replaceRange(index,
                                                        index + 1, [item]);
                                                    _pagingController!
                                                        .itemList = {
                                                      for (var item in items)
                                                        item.reference: item
                                                    }.values.toList();
                                                  }
                                                });
                                                setState(() {});
                                              });
                                              _streamSubscriptions
                                                  .add(streamSubscription);
                                            });
                                          });
                                          return _pagingController!;
                                        }(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                UsersRecord>(
                                          // Customize what your widget looks like when it's loading the first page.
                                          firstPageProgressIndicatorBuilder:
                                              (_) => Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                              ),
                                            ),
                                          ),

                                          itemBuilder:
                                              (context, _, listViewIndex) {
                                            final listViewUsersRecord =
                                                _pagingController!
                                                    .itemList![listViewIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 0, 16, 0),
                                              child: Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 2, 8, 2),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 25,
                                                        height: 25,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          'https://picsum.photos/seed/574/600',
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              listViewUsersRecord
                                                                  .displayName!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              functions.modifyPhoneNumbers(
                                                                  listViewUsersRecord
                                                                      .phoneNumber!)!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize: 8,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.45, 0.6),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        30,
                                                                        0,
                                                                        4,
                                                                        0),
                                                            child: Text(
                                                              '\$',
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.55, 0.3),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        3,
                                                                        0),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  miniValueController,
                                                              autofocus: true,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                hintText: functions
                                                                    .miniValueFunction(
                                                                        double.parse(
                                                                            masterValueController!.text))
                                                                    .toString(),
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2,
                                                                enabledBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                errorBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                                focusedErrorBorder:
                                                                    UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            4.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            4.0),
                                                                  ),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              keyboardType:
                                                                  const TextInputType
                                                                          .numberWithOptions(
                                                                      signed:
                                                                          true,
                                                                      decimal:
                                                                          true),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Theme(
                                                          data: ThemeData(
                                                            unselectedWidgetColor:
                                                                Color(
                                                                    0xFF95A1AC),
                                                          ),
                                                          child:
                                                              CheckboxListTile(
                                                            value: checkboxListTileValueMap[
                                                                    listViewUsersRecord] ??=
                                                                true,
                                                            onChanged: (newValue) =>
                                                                setState(() =>
                                                                    checkboxListTileValueMap[
                                                                            listViewUsersRecord] =
                                                                        newValue!),
                                                            tileColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            activeColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                            dense: false,
                                                            controlAffinity:
                                                                ListTileControlAffinity
                                                                    .trailing,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.8, 0.82),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Done',
                              options: FFButtonOptions(
                                width: 100,
                                height: 50,
                                color: Color(0xFF09567A),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      fontSize: 18,
                                    ),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1, -1),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30,
                              borderWidth: 1,
                              buttonSize: 60,
                              icon: Icon(
                                Icons.close_rounded,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 30,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
