// adding new code here...

import '../add_chat_user/add_chat_user_widget.dart';
import '../add_expense/add_expense_widget.dart';
import '../all_chats/all_chats_widget.dart';
//import '../backend/backend.dart';
import '../chat_details/chat_details_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({
    Key? key,
    this.chatUser,
    this.chatRef,
  }) : super(key: key);

  final UsersRecord? chatUser;
  final DocumentReference? chatRef;

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget> {
  FFChatInfo? _chatInfo;
  bool isGroupChat() {
    if (widget.chatUser == null) {
      return true;
    }
    if (widget.chatRef == null) {
      return false;
    }
    return _chatInfo?.isGroupChat ?? false;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FFChatManager.instance
        .getChatInfo(
      otherUserRecord: widget.chatUser,
      chatReference: widget.chatRef,
    )
        .listen((info) {
      if (mounted) {
        setState(() => _chatInfo = info);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatsRecord>(
      stream: ChatsRecord.getDocument(widget.chatRef!),
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
        final chatPageChatsRecord = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.chevron_left_rounded,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 24,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: AllChatsWidget(),
                  ),
                );
              },
            ),
            title: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: StreamBuilder<ChatsRecord>(
                    stream: ChatsRecord.getDocument(widget.chatRef!),
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
                      final containerChatsRecord = snapshot.data!;
                      return InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: ChatDetailsWidget(
                                chatDetails: chatPageChatsRecord.chatName,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            maxHeight: 40,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: StreamBuilder<ChatsRecord>(
                              stream: ChatsRecord.getDocument(
                                  chatPageChatsRecord.reference),
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
                                final textChatsRecord = snapshot.data!;
                                return Text(
                                  chatPageChatsRecord.groupName!,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                      ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.person_add_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddChatUserWidget(
                        chat: _chatInfo!.chatRecord,
                      ),
                    ),
                  );
                },
              ),
            ],
            centerTitle: false,
            elevation: 0,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                StreamBuilder<FFChatInfo>(
                  stream: FFChatManager.instance.getChatInfo(
                    otherUserRecord: widget.chatUser,
                    chatReference: widget.chatRef,
                  ),
                  builder: (context, snapshot) => snapshot.hasData
                      ? FFChatPage(
                          chatInfo: snapshot.data!,
                          allowImages: true,
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          timeDisplaySetting: TimeDisplaySetting.visibleOnTap,
                          currentUserBoxDecoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          otherUsersBoxDecoration: BoxDecoration(
                            color: Color(0xFFF2F1F1),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          currentUserTextStyle: GoogleFonts.getFont(
                            'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            fontStyle: FontStyle.normal,
                          ),
                          otherUsersTextStyle: GoogleFonts.getFont(
                            'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                          inputHintTextStyle: GoogleFonts.getFont(
                            'Montserrat',
                            color: Color(0xFF95A1AC),
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                          inputTextStyle: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                          emptyChatWidget: Image.asset(
                            'assets/images/messagesEmpty@2x.png',
                            width: MediaQuery.of(context).size.width * 0.76,
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.87, 0.79),
                  child: FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primaryColor,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 55,
                    fillColor: FlutterFlowTheme.of(context).primaryColor,
                    icon: Icon(
                      Icons.attach_money_sharp,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 30,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: AddExpenseWidget(
                            addExpenseUsers: chatPageChatsRecord.reference,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
