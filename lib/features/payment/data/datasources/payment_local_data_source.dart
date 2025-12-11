import '../../domain/entities/payment_method_entity.dart';


abstract class PaymentLocalDataSource {
  Future<List<PaymentMethodEntity>> getMethods();
  Future<void> addMethod(PaymentMethodEntity method);
  Future<void> deleteMethod(String id);
  Future<void> setDefaultMethod(String id);
}

class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  final List<PaymentMethodEntity> _methods = [
    const PaymentMethodEntity(
      id: '1',
      cardHolderName: 'John Doe',
      cardNumber: '**** **** **** 4242',
      expiryDate: '12/25',
      cvv: '123',
      cardType: 'Visa',
      isDefault: true,
    ),
    const PaymentMethodEntity(
      id: '2',
      cardHolderName: 'John Doe',
      cardNumber: '**** **** **** 5555',
      expiryDate: '10/24',
      cvv: '456',
      cardType: 'Mastercard',
    ),
  ];

  @override
  Future<List<PaymentMethodEntity>> getMethods() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_methods);
  }

  @override
  Future<void> addMethod(PaymentMethodEntity method) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _methods.add(method);
  }

  @override
  Future<void> deleteMethod(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _methods.removeWhere((m) => m.id == id);
  }

  @override
  Future<void> setDefaultMethod(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (var i = 0; i < _methods.length; i++) {
        if (_methods[i].id == id) {
            _methods[i] = _methods[i].copyWith(isDefault: true);
        } else {
            _methods[i] = _methods[i].copyWith(isDefault: false);
        }
    }
  }
}
