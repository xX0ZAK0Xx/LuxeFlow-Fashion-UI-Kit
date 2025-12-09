import '../../domain/entities/shipping_address_entity.dart';

abstract class ShippingLocalDataSource {
  Future<List<ShippingAddressEntity>> getAddresses();
  Future<void> addAddress(ShippingAddressEntity address);
  Future<void> deleteAddress(String id);
  Future<void> setDefaultAddress(String id);
}

class ShippingLocalDataSourceImpl implements ShippingLocalDataSource {
  final List<ShippingAddressEntity> _addresses = [
    const ShippingAddressEntity(
      id: '1',
      label: 'Home',
      address: '123 Main St, New York, NY 10001',
      isDefault: true,
    ),
    const ShippingAddressEntity(
      id: '2',
      label: 'Office',
      address: '456 Business Blvd, San Francisco, CA 94107',
      isDefault: false,
    ),
  ];

  @override
  Future<List<ShippingAddressEntity>> getAddresses() async {
    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_addresses);
  }

  @override
  Future<void> addAddress(ShippingAddressEntity address) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _addresses.add(address);
  }

  @override
  Future<void> deleteAddress(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _addresses.removeWhere((a) => a.id == id);
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Implementation to set default logic (toggle others off)
    // For simplicity, refetching will just show updated dummy data state if we maintained it properly.
    // In-memory list update:
    for (var i = 0; i < _addresses.length; i++) {
        if (_addresses[i].id == id) {
            _addresses[i] = _addresses[i].copyWith(isDefault: true);
        } else {
            _addresses[i] = _addresses[i].copyWith(isDefault: false);
        }
    }
  }
}
