import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText(text) async {
    final image = MemoryImage(text);
    final pdf = Document();

    pdf.addPage(Page(
      build: (context) => Center(
        child: Image(image),
      ),
    ));

    return saveDocument(name: 'PaymentReceipt.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir2 = await getExternalStorageDirectory();
    final file = File('${dir2!.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}
