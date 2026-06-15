import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../domain/models/donation_history_entry.dart';
import '../domain/models/user_profile_model.dart';

// ─── Public entry point ───────────────────────────────────────────────────────

Future<void> generateAndShareDonationPdf({
  required UserProfileModel profile,
  required List<DonationHistoryEntry> history,
}) async {
  final doc = pw.Document(
    title: 'Blood Setu — Donation History',
    author: 'Blood Setu',
  );

  final bold = pw.Font.helveticaBold();
  final regular = pw.Font.helvetica();
  final now = DateTime.now();
  final dateFmt = DateFormat('dd MMM yyyy');
  final td = profile.totalDonations;

  final logoBytes = (await rootBundle.load('assets/app_logo.png'))
      .buffer
      .asUint8List();
  final logoImage = pw.MemoryImage(logoBytes);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      header: (_) => _header(
        bold: bold,
        regular: regular,
        now: now,
        dateFmt: dateFmt,
        logoImage: logoImage,
      ),
      footer: (ctx) => _footer(ctx, regular: regular),
      build: (_) => [
        pw.Padding(
          padding: const pw.EdgeInsets.fromLTRB(32, 24, 32, 32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _sectionLabel('DONOR INFORMATION', bold),
              pw.SizedBox(height: 10),
              _donorCard(
                profile: profile,
                td: td,
                bold: bold,
                regular: regular,
                dateFmt: dateFmt,
              ),
              pw.SizedBox(height: 22),
              _sectionLabel('DONOR BADGES', bold),
              pw.SizedBox(height: 10),
              _badgesRow(td: td, bold: bold, regular: regular),
              pw.SizedBox(height: 22),
              _sectionLabel('DONATIONS  (${history.length})', bold),
              pw.SizedBox(height: 10),
              _table(
                history: history,
                bold: bold,
                regular: regular,
                dateFmt: dateFmt,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  await Printing.sharePdf(
    bytes: await doc.save(),
    filename: 'blood_setu_donations_${DateFormat('yyyyMMdd').format(now)}.pdf',
  );
}

// ─── Header ───────────────────────────────────────────────────────────────────

pw.Widget _header({
  required pw.Font bold,
  required pw.Font regular,
  required DateTime now,
  required DateFormat dateFmt,
  required pw.MemoryImage logoImage,
}) {
  const red = _red;
  const white = PdfColors.white;

  return pw.Container(
    color: red,
    padding: const pw.EdgeInsets.fromLTRB(32, 22, 32, 20),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        // Left: app name + report label
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'BLOOD SETU',
              style: pw.TextStyle(
                font: bold,
                fontSize: 22,
                color: white,
                letterSpacing: 2.0,
              ),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              'Emergency Blood Donation Platform',
              style: pw.TextStyle(font: regular, fontSize: 9, color: _white70),
            ),
            pw.SizedBox(height: 12),
            pw.Container(width: 180, height: 0.75, color: _white30),
            pw.SizedBox(height: 10),
            pw.Text(
              'DONATION HISTORY REPORT',
              style: pw.TextStyle(
                font: bold,
                fontSize: 11,
                color: white,
                letterSpacing: 1.2,
              ),
            ),
            pw.Text(
              'Generated: ${dateFmt.format(now)}',
              style: pw.TextStyle(font: regular, fontSize: 9, color: _white70),
            ),
          ],
        ),
        // Right: app logo
        pw.Container(
          width: 62,
          height: 62,
          decoration: const pw.BoxDecoration(
            color: PdfColors.white,
            shape: pw.BoxShape.circle,
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Image(logoImage, fit: pw.BoxFit.contain),
          ),
        ),
      ],
    ),
  );
}

// ─── Footer ───────────────────────────────────────────────────────────────────

pw.Widget _footer(pw.Context ctx, {required pw.Font regular}) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 10),
    decoration: const pw.BoxDecoration(
      border: pw.Border(top: pw.BorderSide(color: _grey200, width: 0.75)),
    ),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Blood Setu — Emergency Blood Donation Platform, Bangladesh',
          style: pw.TextStyle(font: regular, fontSize: 8, color: _grey500),
        ),
        pw.Text(
          'Page ${ctx.pageNumber} of ${ctx.pagesCount}',
          style: pw.TextStyle(font: regular, fontSize: 8, color: _grey500),
        ),
      ],
    ),
  );
}

// ─── Section label ────────────────────────────────────────────────────────────

pw.Widget _sectionLabel(String title, pw.Font bold) {
  return pw.Row(
    children: [
      pw.Container(width: 3, height: 14, color: _red),
      pw.SizedBox(width: 8),
      pw.Text(
        title,
        style: pw.TextStyle(
          font: bold,
          fontSize: 10,
          color: _red,
          letterSpacing: 0.8,
        ),
      ),
    ],
  );
}

// ─── Donor info card ─────────────────────────────────────────────────────────

pw.Widget _donorCard({
  required UserProfileModel profile,
  required int td,
  required pw.Font bold,
  required pw.Font regular,
  required DateFormat dateFmt,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(14),
    decoration: const pw.BoxDecoration(
      color: _grey100,
      borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        // Blood group badge
        pw.Container(
          width: 62,
          height: 62,
          decoration: const pw.BoxDecoration(
            color: _red,
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  profile.bloodGroup ?? '?',
                  style: pw.TextStyle(
                    font: bold,
                    fontSize: 20,
                    color: PdfColors.white,
                  ),
                ),
                pw.Text(
                  'BLOOD',
                  style: pw.TextStyle(
                    font: regular,
                    fontSize: 6,
                    color: _white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        pw.SizedBox(width: 16),
        // 3×2 info grid
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Expanded(
                    child: _cell(
                      'Full Name',
                      profile.fullName ?? '—',
                      bold,
                      regular,
                    ),
                  ),
                  pw.Expanded(
                    child: _cell(
                      'Blood Group',
                      profile.bloodGroup ?? '—',
                      bold,
                      regular,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: _cell(
                      'Total Donations',
                      '$td donation${td != 1 ? 's' : ''}',
                      bold,
                      regular,
                    ),
                  ),
                  pw.Expanded(
                    child: _cell('Donor Badge', _tierLabel(td), bold, regular),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: _cell(
                      'Location',
                      '${profile.thana ?? ''}, ${profile.district ?? ''}',
                      bold,
                      regular,
                    ),
                  ),
                  pw.Expanded(
                    child: _cell(
                      'Last Donation',
                      profile.lastDonation != null
                          ? dateFmt.format(profile.lastDonation!)
                          : '—',
                      bold,
                      regular,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

pw.Widget _cell(String label, String value, pw.Font bold, pw.Font regular) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        label.toUpperCase(),
        style: pw.TextStyle(
          font: regular,
          fontSize: 7,
          color: _grey500,
          letterSpacing: 0.4,
        ),
      ),
      pw.SizedBox(height: 2),
      pw.Text(
        value,
        style: pw.TextStyle(font: bold, fontSize: 10, color: _grey800),
      ),
    ],
  );
}

// ─── Badges row ───────────────────────────────────────────────────────────────

pw.Widget _badgesRow({
  required int td,
  required pw.Font bold,
  required pw.Font regular,
}) {
  const badges = [
    _Badge('Bronze Helper', '1+ donations', 1, _bronze),
    _Badge('Silver Guardian', '6+ donations', 6, _silver),
    _Badge('Gold Lifesaver', '12+ donations', 12, _gold),
    _Badge('Platinum Hero', '25+ donations', 25, _platinum),
  ];

  return pw.Row(
    children: badges.asMap().entries.map((e) {
      final i = e.key;
      final b = e.value;
      final unlocked = td >= b.threshold;
      return pw.Expanded(
        child: pw.Container(
          margin: pw.EdgeInsets.only(right: i < 3 ? 8 : 0),
          padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: pw.BoxDecoration(
            color: unlocked ? b.color : _grey200,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                unlocked ? 'UNLOCKED' : 'LOCKED',
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 7,
                  color: unlocked ? _white70 : _grey500,
                  letterSpacing: 0.4,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                b.name,
                style: pw.TextStyle(
                  font: bold,
                  fontSize: 9,
                  color: unlocked ? PdfColors.white : _grey500,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                b.rangeLabel,
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 8,
                  color: unlocked ? _white70 : _grey500,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

// ─── Donations table ──────────────────────────────────────────────────────────

pw.Widget _table({
  required List<DonationHistoryEntry> history,
  required pw.Font bold,
  required pw.Font regular,
  required DateFormat dateFmt,
}) {
  final headerCells = [
    '#',
    'Date',
    'Hospital / Location',
    'Blood Group',
    'Status',
  ];

  return pw.Table(
    border: pw.TableBorder.all(color: _grey200, width: 0.5),
    columnWidths: const {
      0: pw.FixedColumnWidth(28),
      1: pw.FlexColumnWidth(2.0),
      2: pw.FlexColumnWidth(3.5),
      3: pw.FlexColumnWidth(1.4),
      4: pw.FlexColumnWidth(1.5),
    },
    children: [
      // Header
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: _red),
        children: headerCells
            .map(
              (h) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 7,
                ),
                child: pw.Text(
                  h,
                  style: pw.TextStyle(
                    font: bold,
                    fontSize: 9,
                    color: PdfColors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            )
            .toList(),
      ),
      // Rows
      ...history.asMap().entries.map((e) {
        final i = e.key;
        final entry = e.value;
        final n = history.length - i;
        final rowBg = i.isEven ? _grey50 : PdfColors.white;

        return pw.TableRow(
          decoration: pw.BoxDecoration(color: rowBg),
          children: [
            _tableCell('$n', bold, _red),
            _tableCell(dateFmt.format(entry.date), regular, _grey800),
            _tableCell(entry.hospital, regular, _grey800),
            _tableCell(entry.bloodGroup, bold, _red),
            _tableCell(entry.status, bold, _green),
          ],
        );
      }),
    ],
  );
}

pw.Widget _tableCell(String text, pw.Font font, PdfColor color) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 7),
    child: pw.Text(
      text,
      style: pw.TextStyle(font: font, fontSize: 9, color: color),
    ),
  );
}

// ─── Tier helpers ─────────────────────────────────────────────────────────────

String _tierLabel(int td) {
  if (td >= 25) return 'Platinum Hero';
  if (td >= 12) return 'Gold Lifesaver';
  if (td >= 6) return 'Silver Guardian';
  if (td >= 1) return 'Bronze Helper';
  return 'Unranked';
}

// ─── Constants ────────────────────────────────────────────────────────────────

const _red = PdfColor(0.898, 0.224, 0.208); // #E53935
const _white70 = PdfColor(1, 1, 1, 0.70);
const _white30 = PdfColor(1, 1, 1, 0.30);
const _grey50 = PdfColor(0.980, 0.980, 0.980); // #FAFAFA
const _grey100 = PdfColor(0.961, 0.961, 0.961); // #F5F5F5
const _grey200 = PdfColor(0.933, 0.933, 0.933); // #EEEEEE
const _grey500 = PdfColor(0.620, 0.620, 0.620); // #9E9E9E
const _grey800 = PdfColor(0.259, 0.259, 0.259); // #424242
const _green = PdfColor(0.263, 0.627, 0.278); // #43A047
const _bronze = PdfColor(0.722, 0.451, 0.200); // #B87333
const _silver = PdfColor(0.627, 0.627, 0.627); // #A0A0A0
const _gold = PdfColor(0.855, 0.647, 0.125); // #DAA520
const _platinum = PdfColor(0.329, 0.431, 0.478); // #546E7A

class _Badge {
  const _Badge(this.name, this.rangeLabel, this.threshold, this.color);
  final String name;
  final String rangeLabel;
  final int threshold;
  final PdfColor color;
}
