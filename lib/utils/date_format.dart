import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'date_format.g.dart';

@riverpod
String formatDate(FormattedWasOnlineRef , ref, DateTime dataTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final checkDate = DateTime(dataTime.year, dataTime.month, dataTime.day);
  final time = DateFormat('HH:mm').format(dataTime);
  if (checkDate == today) {
    return "today ${time}"; }
  if (checkDate == yesterday) {
    return "yesterday ${time}"; }
  final date = DateFormat('d MMM', 'uk').format(dataTime);
  return "${date} ${time}";
}