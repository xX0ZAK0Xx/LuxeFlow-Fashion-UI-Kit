import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String id;
  final String label;
  final String address;
  final bool isDefault;

  const ShippingAddressEntity({
    required this.id,
    required this.label,
    required this.address,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [id, label, address, isDefault];

  ShippingAddressEntity copyWith({
    String? id,
    String? label,
    String? address,
    bool? isDefault,
  }) {
    return ShippingAddressEntity(
      id: id ?? this.id,
      label: label ?? this.label,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
