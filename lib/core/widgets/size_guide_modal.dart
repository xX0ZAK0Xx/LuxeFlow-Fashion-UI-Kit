import 'package:flutter/material.dart';

class SizeGuideModal extends StatelessWidget {
  const SizeGuideModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Size Guide', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Size')),
                  DataColumn(label: Text('Chest')),
                  DataColumn(label: Text('Waist')),
                  DataColumn(label: Text('Hips')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('S')),
                    DataCell(Text('86-91 cm')),
                    DataCell(Text('71-76 cm')),
                    DataCell(Text('86-91 cm')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('M')),
                    DataCell(Text('96-101 cm')),
                    DataCell(Text('81-86 cm')),
                    DataCell(Text('96-101 cm')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('L')),
                    DataCell(Text('106-111 cm')),
                    DataCell(Text('91-96 cm')),
                    DataCell(Text('106-111 cm')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('XL')),
                    DataCell(Text('116-121 cm')),
                    DataCell(Text('101-106 cm')),
                    DataCell(Text('116-121 cm')),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
