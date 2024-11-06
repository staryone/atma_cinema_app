import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

Future<void> createPdf(
  TextEditingController nameController,
  String ticketId,
  DateTime airingDate,
  String time,
  String paymentId,
  String paymentMethod,
  DateTime purchaseDate,
  String id,
  BuildContext context,
  List<CustomRow> elements,
) async {
  final doc = pw.Document();
  final formattedPurchaseDate = DateFormat('d MMMM yyyy').format(purchaseDate);

  // Calculate the grand total
  double grandTotal = elements.fold(0, (sum, row) => sum + row.total);

  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    margin: pw.EdgeInsets.all(32),
  );

  // Create the table widget without a total column
  pw.Widget table = itemColumn(elements);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      build: (pw.Context context) {
        return [
          pw.Header(
            level: 0,
            child: pw.Text('INVOICE', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Buyer: ${nameController.text}"),
                  pw.Text("Ticket ID: $ticketId"),
                  pw.Text("Airing date: ${DateFormat('d MMMM yyyy').format(airingDate)}"),
                  pw.Text("Time: $time"),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          table,
          pw.Divider(),
          // Display the calculated grand total at the bottom
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("TOTAL PAYMENT", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("Rp ${grandTotal.toStringAsFixed(2)}"),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Payment ID: $paymentId"),
              pw.Text("Payment Method: $paymentMethod"),
              pw.Text("Purchase date: $formattedPurchaseDate"),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text("*This invoice is valid and processed by computer*", style: pw.TextStyle(color: PdfColor.fromHex("#FF0000"))),
        ];
      },
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PreviewScreen(doc: doc)),
  );
}


class CustomRow {
  final String description;
  final String numberOfSeat;
  final String tax;
  final String price;

  CustomRow(this.description, this.numberOfSeat, this.tax, this.price);

  double get total => double.parse(tax) + (double.parse(price) * int.parse(numberOfSeat));
}

pw.Widget itemColumn(List<CustomRow> elements) {
  return pw.Table(
    border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey),
    children: [
      // Header Row
      pw.TableRow(
        decoration: pw.BoxDecoration(
          color: PdfColor.fromHex("#001F54"),
        ),
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text("DESCRIPTION", style: pw.TextStyle(color: PdfColors.white)),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text("NUMBER OF SEAT", style: pw.TextStyle(color: PdfColors.white)),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text("TAX", style: pw.TextStyle(color: PdfColors.white)),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(8),
            child: pw.Text("PRICE", style: pw.TextStyle(color: PdfColors.white)),
          ),
        ],
      ),
      // Data Rows
      for (var row in elements)
        pw.TableRow(
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Text(row.description),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Text(row.numberOfSeat),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Text(row.tax),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(8),
              child: pw.Text(row.price),
            ),
          ],
        ),
    ],
  );
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({Key? key, required this.doc}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: const Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
      ),
    );
  }
}
