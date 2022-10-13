import 'dart:async';

//import 'package:from_css_color/from_css_color.dart';

//import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'transactions_record.g.dart';

abstract class TransactionsRecord
    implements Built<TransactionsRecord, TransactionsRecordBuilder> {
  static Serializer<TransactionsRecord> get serializer =>
      _$transactionsRecordSerializer;

  @BuiltValueField(wireName: 'transaction_id')
  String? get transactionId;

  @BuiltValueField(wireName: 'chat_id')
  String? get chatId;

  @BuiltValueField(wireName: 'requestor_uid')
  String? get requestorUid;

  @BuiltValueField(wireName: 'payer_uid')
  String? get payerUid;

  @BuiltValueField(wireName: 'expense_amount')
  double? get expenseAmount;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(TransactionsRecordBuilder builder) => builder
    ..transactionId = ''
    ..chatId = ''
    ..requestorUid = ''
    ..payerUid = ''
    ..expenseAmount = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static TransactionsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      TransactionsRecord(
        (c) => c
          ..transactionId = snapshot.data['transaction_id']
          ..chatId = snapshot.data['chat_id']
          ..requestorUid = snapshot.data['requestor_uid']
          ..payerUid = snapshot.data['payer_uid']
          ..expenseAmount = snapshot.data['expense_amount']?.toDouble()
          ..ffRef = TransactionsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<TransactionsRecord>> search(
          {String? term,
          FutureOr<LatLng>? location,
          int? maxResults,
          double? searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'transactions',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  TransactionsRecord._();
  factory TransactionsRecord(
          [void Function(TransactionsRecordBuilder) updates]) =
      _$TransactionsRecord;

  static TransactionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createTransactionsRecordData({
  String? transactionId,
  String? chatId,
  String? requestorUid,
  String? payerUid,
  double? expenseAmount,
}) {
  final firestoreData = serializers.toFirestore(
    TransactionsRecord.serializer,
    TransactionsRecord(
      (t) => t
        ..transactionId = transactionId
        ..chatId = chatId
        ..requestorUid = requestorUid
        ..payerUid = payerUid
        ..expenseAmount = expenseAmount,
    ),
  );

  return firestoreData;
}
