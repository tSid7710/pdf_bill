import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'constants.dart';
import 'pdf_mobile.dart';
import 'textfieldbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? customerName;
  String? email;
  String? phone;
  String? company;
  String? address;

  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics.drawString(
        "Bill Receipt", PdfStandardFont(PdfFontFamily.helvetica, 30),
        bounds: const Rect.fromLTWH(190, 0, 500, 40));
    page.graphics.drawString(
        "Customer Details :", PdfStandardFont(PdfFontFamily.helvetica, 28),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(15, 60, 500, 40));
    page.graphics.drawString(
        "$customerName", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(15, 95, 500, 40));
    page.graphics.drawString(
        "$email", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(15, 125, 500, 40));
    page.graphics.drawString(
        "+91 $phone", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(15, 160, 500, 40));
    page.graphics.drawString(
        "Company Details :", PdfStandardFont(PdfFontFamily.helvetica, 28),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(15, 205, 500, 40));
    page.graphics.drawString(
        "$company", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(15, 240, 500, 40));
    page.graphics.drawString(
        "$address", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(15, 270, 500, 40));

    PdfGrid grid = PdfGrid();

//Add the columns to the grid
    grid.columns.add(count: 4);

//Add header to the grid
    grid.headers.add(1);

//Add the rows to the grid
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Items';
    header.cells[1].value = 'Quantity';
    header.cells[2].value = 'Cost';
    header.cells[3].value = 'Total';

//Add rows to grid
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = 'Item1';
    row.cells[1].value = '1';
    row.cells[2].value = '1265.4';
    row.cells[3].value = '1265.4';

    row = grid.rows.add();
    row.cells[0].value = 'Item2';
    row.cells[1].value = '2';
    row.cells[2].value = '1500.4';
    row.cells[3].value = '3000.8';

//Set the grid style
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 15, right: 3, top: 5, bottom: 5),
        // backgroundBrush: PdfBrushes.blue,
        // textBrush: PdfBrushes.white,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 25));

//Draw the grid
    grid.draw(page: page, bounds: const Rect.fromLTWH(0, 350, 500, 0));
    page.graphics.drawString(
        "Total = Rs.", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(300, 500, 500, 40));
    page.graphics.drawString(
        "3126.2", PdfStandardFont(PdfFontFamily.helvetica, 22),
        bounds: const Rect.fromLTWH(410, 500, 500, 40));

    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffbfc0c0),
      appBar: AppBar(
        title: const Text('PDF Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Customer Details',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Customer Name', style: kLabelDecoration),
                    TextBox(
                      hint: 'Customer Name',
                      changedText: (String? value) {
                        customerName = value;
                      },
                    ),
                    const Text('Email id', style: kLabelDecoration),
                    TextBox(
                        hint: 'Email',
                        changedText: (String? value) {
                          email = value;
                        }),
                    const Text('Phone Number', style: kLabelDecoration),
                    TextBox(
                        hint: 'Phone Number',
                        changedText: (String? value) {
                          phone = value;
                        }),
                    const Text('Company Name', style: kLabelDecoration),
                    TextBox(
                        hint: 'Company Name',
                        changedText: (String? value) {
                          company = value;
                        }),
                    const Text('Address', style: kLabelDecoration),
                    TextBox(
                        hint: 'Address',
                        changedText: (String? value) {
                          address = value;
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () async {
                    _createPdf();
                  },
                  child: const Text('Generate Bill'),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
