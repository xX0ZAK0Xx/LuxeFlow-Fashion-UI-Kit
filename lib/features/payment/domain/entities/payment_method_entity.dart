import 'package:equatable/equatable.dart';

class PaymentMethodEntity extends Equatable {
  final String id;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String cardType; // e.g. Visa, Mastercard
  final bool isDefault;

  const PaymentMethodEntity({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id, cardHolderName, cardNumber, expiryDate, cvv, cardType, isDefault];

  PaymentMethodEntity copyWith({
    String? id,
    String? cardHolderName,
    String? cardNumber,
    String? expiryDate,
    String? cvv,
    String? cardType,
    bool? isDefault,
  }) => PaymentMethodEntity(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      cardType: cardType ?? this.cardType,
      isDefault: isDefault ?? this.isDefault,
    );
}
