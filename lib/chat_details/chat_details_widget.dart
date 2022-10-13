//import '../auth/auth_util.dart';
//import '../backend/backend.dart';
//import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
//import '../flutter_flow/upload_media.dart';
import 'dart:ui';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatDetailsWidget extends StatefulWidget {
  const ChatDetailsWidget({
    Key? key,
    this.chatDetails,
  }) : super(key: key);

  final DocumentReference? chatDetails;

  @override
  _ChatDetailsWidgetState createState() => _ChatDetailsWidgetState();
}

class _ChatDetailsWidgetState extends State<ChatDetailsWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 20),
          end: Offset(0, 0),
        ),
      ],
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 40),
          end: Offset(0, 0),
        ),
      ],
    ),
  };
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  TextEditingController? chatNameController;
  ChatsRecord? groupChat;
  PagingController<DocumentSnapshot?, UsersRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  ChatsRecord? leaveChat;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    chatNameController = TextEditingController();
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    chatNameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatsRecord>>(
      stream: queryChatsRecord(
        singleRecord: true,
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
        List<ChatsRecord> chatDetailsChatsRecordList = snapshot.data!;
        // Return an empty Container when the document does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final chatDetailsChatsRecord = chatDetailsChatsRecordList.isNotEmpty
            ? chatDetailsChatsRecordList.first
            : null;
        return Scaffold(
          key: scaffoldKey,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
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
                        Container(
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
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Text(
                                    'Chat Details',
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
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xFF09567A),
                                            ),
                                          ),
                                          child: Visibility(
                                            visible: chatDetailsChatsRecord!
                                                        .chatIcon !=
                                                    null &&
                                                chatDetailsChatsRecord!
                                                        .chatIcon !=
                                                    '',
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 2, 2, 2),
                                              child: InkWell(
                                                onTap: () async {
                                                  final selectedMedia =
                                                      await selectMediaWithSourceBottomSheet(
                                                    context: context,
                                                    allowPhoto: true,
                                                  );
                                                  if (selectedMedia != null &&
                                                      selectedMedia.every((m) =>
                                                          validateFileFormat(
                                                              m.storagePath,
                                                              context))) {
                                                    setState(() =>
                                                        isMediaUploading =
                                                            true);
                                                    var downloadUrls =
                                                        <String>[];
                                                    try {
                                                      showUploadMessage(
                                                        context,
                                                        'Uploading file...',
                                                        showLoading: true,
                                                      );
                                                      downloadUrls =
                                                          (await Future.wait(
                                                        selectedMedia.map(
                                                          (m) async =>
                                                              await uploadData(
                                                                  m.storagePath,
                                                                  m.bytes),
                                                        ),
                                                      ))
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      isMediaUploading = false;
                                                    }
                                                    if (downloadUrls.length ==
                                                        selectedMedia.length) {
                                                      setState(() =>
                                                          uploadedFileUrl =
                                                              downloadUrls
                                                                  .first);
                                                      showUploadMessage(
                                                          context, 'Success!');
                                                    } else {
                                                      setState(() {});
                                                      showUploadMessage(context,
                                                          'Failed to upload media');
                                                      return;
                                                    }
                                                  }

                                                  final chatsUpdateData =
                                                      createChatsRecordData(
                                                    chatIcon: uploadedFileUrl,
                                                  );
                                                  await chatDetailsChatsRecord!
                                                      .reference
                                                      .update(chatsUpdateData);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: Image.network(
                                                    uploadedFileUrl,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (uploadedFileUrl == null ||
                                            uploadedFileUrl == '')
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'Add image',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF09567A),
                                                  ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 15),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0x00FFFFFF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            40, 0, 40, 0),
                                        child: TextFormField(
                                          controller: chatNameController,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            'chatNameController',
                                            Duration(milliseconds: 20),
                                            () async {
                                              final chatsUpdateData =
                                                  createChatsRecordData(
                                                groupName:
                                                    chatNameController!.text,
                                              );
                                              await chatDetailsChatsRecord!
                                                  .reference
                                                  .update(chatsUpdateData);
                                            },
                                          ),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      lineHeight: 2,
                                                    ),
                                            hintText: chatDetailsChatsRecord!
                                                .groupName,
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      lineHeight: 2,
                                                    ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            filled: true,
                                            fillColor: Color(0x1CFFFFFF),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 2, 20, 2),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Text(
                                    '\$ 100,207.09',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF101213),
                                          fontSize: 40,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ).animateOnPageLoad(animationsMap[
                                      'textOnPageLoadAnimation1']!),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    'Total transaction value',
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ).animateOnPageLoad(animationsMap[
                                      'textOnPageLoadAnimation2']!),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            groupChat = await FFChatManager
                                                .instance
                                                .addGroupMembers(
                                              chatDetailsChatsRecord!,
                                              chatDetailsChatsRecord!.users!
                                                  .toList(),
                                            );

                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.add_rounded,
                                            color: Color(0xFF09567A),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 30, 0, 20),
                                        child: Container(
                                          width: double.infinity,
                                          height: 150,
                                          constraints: BoxConstraints(
                                            maxWidth: double.infinity,
                                            maxHeight: 80,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color(0x00FFFFFF),
                                            shape: BoxShape.rectangle,
                                          ),
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15, 2, 15, 0),
                                            child: PagedListView<
                                                DocumentSnapshot<Object?>?,
                                                UsersRecord>(
                                              pagingController: () {
                                                final Query<Object?> Function(
                                                        Query<Object?>)
                                                    queryBuilder =
                                                    (usersRecord) =>
                                                        usersRecord.orderBy(
                                                            'display_name');
                                                if (_pagingController != null) {
                                                  final query = queryBuilder(
                                                      UsersRecord.collection);
                                                  if (query != _pagingQuery) {
                                                    // The query has changed
                                                    _pagingQuery = query;
                                                    _streamSubscriptions
                                                        .forEach(
                                                            (s) => s?.cancel());
                                                    _streamSubscriptions
                                                        .clear();
                                                    _pagingController!
                                                        .refresh();
                                                  }
                                                  return _pagingController!;
                                                }

                                                _pagingController =
                                                    PagingController(
                                                        firstPageKey: null);
                                                _pagingQuery = queryBuilder(
                                                    UsersRecord.collection);
                                                _pagingController!
                                                    .addPageRequestListener(
                                                        (nextPageMarker) {
                                                  queryUsersRecordPage(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord.orderBy(
                                                                'display_name'),
                                                    nextPageMarker:
                                                        nextPageMarker,
                                                    pageSize: 25,
                                                    isStream: true,
                                                  ).then((page) {
                                                    _pagingController!
                                                        .appendPage(
                                                      page.data,
                                                      page.nextPageMarker,
                                                    );
                                                    final streamSubscription =
                                                        page.dataStream
                                                            ?.listen((data) {
                                                      final itemIndexes =
                                                          _pagingController!
                                                              .itemList!
                                                              .asMap()
                                                              .map((k, v) =>
                                                                  MapEntry(
                                                                      v.reference
                                                                          .id,
                                                                      k));
                                                      data.forEach((item) {
                                                        final index =
                                                            itemIndexes[item
                                                                .reference.id];
                                                        final items =
                                                            _pagingController!
                                                                .itemList!;
                                                        if (index != null) {
                                                          items.replaceRange(
                                                              index,
                                                              index + 1,
                                                              [item]);
                                                          _pagingController!
                                                              .itemList = {
                                                            for (var item
                                                                in items)
                                                              item.reference:
                                                                  item
                                                          }.values.toList();
                                                        }
                                                      });
                                                      setState(() {});
                                                    });
                                                    _streamSubscriptions.add(
                                                        streamSubscription);
                                                  });
                                                });
                                                return _pagingController!;
                                              }(),
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              builderDelegate:
                                                  PagedChildBuilderDelegate<
                                                      UsersRecord>(
                                                // Customize what your widget looks like when it's loading the first page.
                                                firstPageProgressIndicatorBuilder:
                                                    (_) => Center(
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                    ),
                                                  ),
                                                ),

                                                itemBuilder: (context, _,
                                                    listViewIndex) {
                                                  final listViewUsersRecord =
                                                      _pagingController!
                                                              .itemList![
                                                          listViewIndex];
                                                  return Card(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    color: Color(0x0039D2C0),
                                                    elevation: 0,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            'https://picsum.photos/seed/808/600',
                                                          ),
                                                        ),
                                                        Text(
                                                          listViewUsersRecord
                                                              .displayName!,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 8,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 5, 15, 0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 158,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 1, 0, 1),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 0, 0),
                                                  child: Text(
                                                    'Group Activity',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 15, 0),
                                                      child: Icon(
                                                        Icons
                                                            .attach_money_rounded,
                                                        color:
                                                            Color(0xFF09567A),
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 0, 0, 2),
                                          child: Container(
                                            width: double.infinity,
                                            height: 1,
                                            decoration: BoxDecoration(
                                              color: Color(0x2DC8C8C8),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 1, 0, 1),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(15, 0, 0, 0),
                                                  child: Text(
                                                    'Photos & Videos',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 15, 0),
                                                      child: Icon(
                                                        Icons.image_outlined,
                                                        color:
                                                            Color(0xFF09567A),
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15, 2, 0, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 1,
                                            decoration: BoxDecoration(
                                              color: Color(0x2DC8C8C8),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 1, 0, 1),
                                            child: InkWell(
                                              onTap: () async {
                                                leaveChat = await FFChatManager
                                                    .instance
                                                    .removeGroupMembers(
                                                  chatDetailsChatsRecord!,
                                                  [currentUserReference!],
                                                );

                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15, 0, 0, 0),
                                                    child: Text(
                                                      'Exit group',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1, 0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    15, 0),
                                                        child: Icon(
                                                          Icons.login_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          size: 24,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                              color: FlutterFlowTheme.of(context).primaryColor,
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
        );
      },
    );
  }
}
