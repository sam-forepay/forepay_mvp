//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
//import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _chatName = prefs.getString('ff_chatName')?.ref ?? _chatName;
  }

  late SharedPreferences prefs;

  DocumentReference? _chatName;
  DocumentReference? get chatName => _chatName;
  set chatName(DocumentReference? _value) {
    if (_value == null) {
      return;
    }
    _chatName = _value;
    prefs.setString('ff_chatName', _value.path);
  }

  double MasterValue = 0.0;

  List<DocumentReference> chatUsersTest = [];
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
