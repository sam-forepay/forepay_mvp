// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TransactionsRecord> _$transactionsRecordSerializer =
    new _$TransactionsRecordSerializer();

class _$TransactionsRecordSerializer
    implements StructuredSerializer<TransactionsRecord> {
  @override
  final Iterable<Type> types = const [TransactionsRecord, _$TransactionsRecord];
  @override
  final String wireName = 'TransactionsRecord';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TransactionsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.transactionId;
    if (value != null) {
      result
        ..add('transaction_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.chatId;
    if (value != null) {
      result
        ..add('chat_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.requestorUid;
    if (value != null) {
      result
        ..add('requestor_uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.payerUid;
    if (value != null) {
      result
        ..add('payer_uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.expenseAmount;
    if (value != null) {
      result
        ..add('expense_amount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  TransactionsRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TransactionsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'transaction_id':
          result.transactionId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'chat_id':
          result.chatId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'requestor_uid':
          result.requestorUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'payer_uid':
          result.payerUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'expense_amount':
          result.expenseAmount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$TransactionsRecord extends TransactionsRecord {
  @override
  final String? transactionId;
  @override
  final String? chatId;
  @override
  final String? requestorUid;
  @override
  final String? payerUid;
  @override
  final double? expenseAmount;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$TransactionsRecord(
          [void Function(TransactionsRecordBuilder)? updates]) =>
      (new TransactionsRecordBuilder()..update(updates))._build();

  _$TransactionsRecord._(
      {this.transactionId,
      this.chatId,
      this.requestorUid,
      this.payerUid,
      this.expenseAmount,
      this.ffRef})
      : super._();

  @override
  TransactionsRecord rebuild(
          void Function(TransactionsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionsRecordBuilder toBuilder() =>
      new TransactionsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionsRecord &&
        transactionId == other.transactionId &&
        chatId == other.chatId &&
        requestorUid == other.requestorUid &&
        payerUid == other.payerUid &&
        expenseAmount == other.expenseAmount &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, transactionId.hashCode), chatId.hashCode),
                    requestorUid.hashCode),
                payerUid.hashCode),
            expenseAmount.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionsRecord')
          ..add('transactionId', transactionId)
          ..add('chatId', chatId)
          ..add('requestorUid', requestorUid)
          ..add('payerUid', payerUid)
          ..add('expenseAmount', expenseAmount)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class TransactionsRecordBuilder
    implements Builder<TransactionsRecord, TransactionsRecordBuilder> {
  _$TransactionsRecord? _$v;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  String? _chatId;
  String? get chatId => _$this._chatId;
  set chatId(String? chatId) => _$this._chatId = chatId;

  String? _requestorUid;
  String? get requestorUid => _$this._requestorUid;
  set requestorUid(String? requestorUid) => _$this._requestorUid = requestorUid;

  String? _payerUid;
  String? get payerUid => _$this._payerUid;
  set payerUid(String? payerUid) => _$this._payerUid = payerUid;

  double? _expenseAmount;
  double? get expenseAmount => _$this._expenseAmount;
  set expenseAmount(double? expenseAmount) =>
      _$this._expenseAmount = expenseAmount;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  TransactionsRecordBuilder() {
    TransactionsRecord._initializeBuilder(this);
  }

  TransactionsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transactionId = $v.transactionId;
      _chatId = $v.chatId;
      _requestorUid = $v.requestorUid;
      _payerUid = $v.payerUid;
      _expenseAmount = $v.expenseAmount;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TransactionsRecord;
  }

  @override
  void update(void Function(TransactionsRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionsRecord build() => _build();

  _$TransactionsRecord _build() {
    final _$result = _$v ??
        new _$TransactionsRecord._(
            transactionId: transactionId,
            chatId: chatId,
            requestorUid: requestorUid,
            payerUid: payerUid,
            expenseAmount: expenseAmount,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
