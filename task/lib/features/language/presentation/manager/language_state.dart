part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class ChangeLangState extends LanguageState {
  final String langCode;

  ChangeLangState({required this.langCode});
}
