import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../blocs/payment_bloc.dart';
import '../widgets/add_card_sheet.dart';
import '../../../../core/constants/app_icons.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  
  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(LoadPaymentMethods());
  }

  void _addCard(String number, String expiry, String type, String holder) {
    // Logic to add card via Bloc
    final newCard = PaymentMethodEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardNumber: number,
      expiryDate: expiry,
      cardType: type,
      cardHolderName: holder,
      cvv: 'xxx', // Typically not stored, but for dummy entity
    );
    context.read<PaymentBloc>().add(AddPaymentMethodEvent(newCard));
  }

  void _showAddCardSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) => AddCardSheet(
          scrollController: scrollController,
          onAddCard: _addCard,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentLoaded) {
            if (state.methods.isEmpty) {
              return const Center(child: Text('No payment methods saved'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.methods.length,
              itemBuilder: (context, index) {
                final card = state.methods[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPaymentCard(context, card),
                );
              },
            );
          } else if (state is PaymentError) {
             return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCardSheet,
        child: const Icon(AppIcons.add),
      ),
    );

  Widget _buildPaymentCard(BuildContext context, PaymentMethodEntity card) => Dismissible(
      key: Key(card.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(AppIcons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
         context.read<PaymentBloc>().add(DeletePaymentMethodEvent(card.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(AppIcons.creditCard, color: Colors.blue, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.cardType,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(card.cardNumber, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(card.expiryDate, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            if (card.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Default',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            else
              IconButton(
                icon: Icon(AppIcons.deleteOutline, color: Colors.grey[400]),
                onPressed: () {
                   context.read<PaymentBloc>().add(DeletePaymentMethodEvent(card.id));
                },
              ),
          ],
        ),
      ),
    );
}
