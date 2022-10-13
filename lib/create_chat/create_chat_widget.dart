//import '../auth/auth_util.dart';
import '../auth/firebase_user_provider.dart';
//import '../backend/backend.dart';
import '../chat_page/chat_page_widget.dart';
import '../flutter_flow/chat/index.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
//import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class CreateChatWidget extends StatefulWidget {
  const CreateChatWidget({Key? key}) : super(key: key);

  @override
  _CreateChatWidgetState createState() => _CreateChatWidgetState();
}

class _CreateChatWidgetState extends State<CreateChatWidget> {
  Map<UsersRecord, bool> checkboxListTileValueMap = {};
  List<UsersRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  TextEditingController? textController;
  ChatsRecord? groupChat;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
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
          buttonSize: 24,
          icon: Icon(
            Icons.chevron_left_rounded,
            color: Color(0xFF09567A),
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: AlignmentDirectional(-0.5, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Create Group Chat',
                style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33000000),
                      )
                    ],
                    borderRadius: BorderRadius.circular(0),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF95A1AC),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(24, 14, 0, 0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Color(0xFF95A1AC),
                          size: 24,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
              if (loggedIn)
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: AuthUserStreamWidget(
                      child: StreamBuilder<List<UsersRecord>>(
                        stream: queryUsersRecord(
                          queryBuilder: (usersRecord) => usersRecord.where(
                              'phone_number',
                              isNotEqualTo: currentPhoneNumber),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          List<UsersRecord> listViewUsersRecordList = snapshot
                              .data!
                              .where((u) => u.uid != currentUserUid)
                              .toList();
                          if (listViewUsersRecordList.isEmpty) {
                            return Image.asset(
                              'assets/images/1_5YVaB8PadusRWhEVQJLIHw.gif',
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewUsersRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewUsersRecord =
                                  listViewUsersRecordList[listViewIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPageWidget(
                                          chatUser: listViewUsersRecord,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 0,
                                          color: Color(0xFFDBE2E7),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 2, 2, 2),
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image.network(
                                                  listViewUsersRecord.photoUrl!,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2, 0, 0, 0),
                                              child: CheckboxListTile(
                                                value: checkboxListTileValueMap[
                                                        listViewUsersRecord] ??=
                                                    false,
                                                onChanged: (newValue) => setState(
                                                    () => checkboxListTileValueMap[
                                                            listViewUsersRecord] =
                                                        newValue!),
                                                title: Text(
                                                  valueOrDefault<String>(
                                                    listViewUsersRecord
                                                        .displayName,
                                                    '[friend]',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                subtitle: Text(
                                                  functions.modifyPhoneNumbers(
                                                      listViewUsersRecord
                                                          .phoneNumber!)!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF81878F),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                tileColor: Color(0xFFF5F5F5),
                                                activeColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryColor,
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
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional(0.7, 0.8),
            child: FFButtonWidget(
              onPressed: () async {
                groupChat = await FFChatManager.instance.createChat(
                  checkboxListTileCheckedItems.map((e) => e.reference).toList(),
                );
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPageWidget(
                      chatRef: groupChat?.reference,
                    ),
                  ),
                );

                final chatsCreateData = createChatsRecordData(
                  chatIcon: '',
                  groupName: 'Group Chat',
                );
                await ChatsRecord.collection.doc().set(chatsCreateData);

                setState(() {});
              },
              text: 'Create Chat',
              options: FFButtonOptions(
                width: 150,
                height: 50,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).title3.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
