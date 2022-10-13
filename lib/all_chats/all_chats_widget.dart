//import '../backend/backend.dart';
import '../chat_page/chat_page_widget.dart';
import '../create_chat/create_chat_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import '../settings/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AllChatsWidget extends StatefulWidget {
  const AllChatsWidget({Key? key}) : super(key: key);

  @override
  _AllChatsWidgetState createState() => _AllChatsWidgetState();
}

class _AllChatsWidgetState extends State<AllChatsWidget> {
  PagingController<DocumentSnapshot?, ChatsRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.settings_sharp,
            color: Color(0xFF09567A),
            size: 25,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                child: SettingsWidget(),
              ),
            );
          },
        ),
        title: Text(
          'All Chats',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 2, 10, 0),
              child: InkWell(
                onLongPress: () async {
                  HapticFeedback.lightImpact();
                },
                child: PagedListView<DocumentSnapshot<Object?>?, ChatsRecord>(
                  pagingController: () {
                    final Query<Object?> Function(Query<Object?>) queryBuilder =
                        (chatsRecord) => chatsRecord;
                    if (_pagingController != null) {
                      final query = queryBuilder(ChatsRecord.collection);
                      if (query != _pagingQuery) {
                        // The query has changed
                        _pagingQuery = query;
                        _streamSubscriptions.forEach((s) => s?.cancel());
                        _streamSubscriptions.clear();
                        _pagingController!.refresh();
                      }
                      return _pagingController!;
                    }

                    _pagingController = PagingController(firstPageKey: null);
                    _pagingQuery = queryBuilder(ChatsRecord.collection);
                    _pagingController!.addPageRequestListener((nextPageMarker) {
                      queryChatsRecordPage(
                        queryBuilder: (chatsRecord) => chatsRecord,
                        nextPageMarker: nextPageMarker,
                        pageSize: 25,
                        isStream: true,
                      ).then((page) {
                        _pagingController!.appendPage(
                          page.data,
                          page.nextPageMarker,
                        );
                        final streamSubscription =
                            page.dataStream?.listen((data) {
                          final itemIndexes = _pagingController!.itemList!
                              .asMap()
                              .map((k, v) => MapEntry(v.reference.id, k));
                          data.forEach((item) {
                            final index = itemIndexes[item.reference.id];
                            final items = _pagingController!.itemList!;
                            if (index != null) {
                              items.replaceRange(index, index + 1, [item]);
                              _pagingController!.itemList = {
                                for (var item in items) item.reference: item
                              }.values.toList();
                            }
                          });
                          setState(() {});
                        });
                        _streamSubscriptions.add(streamSubscription);
                      });
                    });
                    return _pagingController!;
                  }(),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  builderDelegate: PagedChildBuilderDelegate<ChatsRecord>(
                    // Customize what your widget looks like when it's loading the first page.
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Image.asset(
                      'assets/images/no-call-no-text-donald-trump-jr.gif',
                    ),
                    itemBuilder: (context, _, listViewIndex) {
                      final listViewChatsRecord =
                          _pagingController!.itemList![listViewIndex];
                      return InkWell(
                        onLongPress: () async {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Party\'s over?'),
                                    content: Text(
                                        'Are you sure you want to DELETE this chat?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Oops no!'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Yep :)'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            await listViewChatsRecord.reference.delete();
                          } else {
                            return;
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(3, 5, 3, 10),
                            child: StreamBuilder<ChatsRecord>(
                              stream: ChatsRecord.getDocument(
                                  listViewChatsRecord.reference),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                      ),
                                    ),
                                  );
                                }
                                final chatPreviewChatsRecord = snapshot.data!;
                                return StreamBuilder<FFChatInfo>(
                                  stream: FFChatManager.instance.getChatInfo(
                                      chatRecord: chatPreviewChatsRecord),
                                  builder: (context, snapshot) {
                                    final chatInfo = snapshot.data ??
                                        FFChatInfo(chatPreviewChatsRecord);
                                    return FFChatPreview(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPageWidget(
                                            chatUser:
                                                chatInfo.otherUsers.length == 1
                                                    ? chatInfo
                                                        .otherUsersList.first
                                                    : null,
                                            chatRef:
                                                chatInfo.chatRecord.reference,
                                          ),
                                        ),
                                      ),
                                      lastChatText:
                                          chatInfo.chatPreviewMessage(),
                                      lastChatTime: chatPreviewChatsRecord
                                          .lastMessageTime,
                                      seen: chatPreviewChatsRecord
                                          .lastMessageSeenBy!
                                          .contains(currentUserReference),
                                      title: chatInfo.chatPreviewTitle(),
                                      userProfilePic: chatInfo.chatPreviewPic(),
                                      color: Color(0xFFEEF0F5),
                                      unreadColor: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      titleTextStyle: GoogleFonts.getFont(
                                        'Montserrat',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                      dateTextStyle: GoogleFonts.getFont(
                                        'Montserrat',
                                        color: Color(0x73000000),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                      previewTextStyle: GoogleFonts.getFont(
                                        'Raleway',
                                        color: Color(0x73000000),
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              2, 2, 2, 2),
                                      borderRadius: BorderRadius.circular(0),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.9, 1),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateChatWidget(),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.add_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 25,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateChatWidget(),
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
          ],
        ),
      ),
    );
  }
}
