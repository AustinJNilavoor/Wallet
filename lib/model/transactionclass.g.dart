// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction()
      ..amount = fields[0] as double
      ..isExpense = fields[1] as bool
      ..date = fields[2] as DateTime
      ..category = fields[3] as String
      ..source = fields[4] as String
      ..isTicked = fields[5] as bool
      ..balance = fields[6] as double
      ..notes = fields[7] as String
      ..lendTotal = fields[8] as double;
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.isExpense)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.source)
      ..writeByte(5)
      ..write(obj.isTicked)
      ..writeByte(6)
      ..write(obj.balance)
      ..writeByte(7)
      ..write(obj.notes)
      ..writeByte(8)
      ..write(obj.lendTotal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
