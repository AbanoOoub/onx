import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/usecases/usecase.dart';
import 'package:task/features/language/domain/repositories/language_repo.dart';

class ChangeLangUC implements UseCase<bool, String> {
  final LanguageRepository languageRepository;

  ChangeLangUC({required this.languageRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await languageRepository.changeLanguage(langCode: langCode);
}
