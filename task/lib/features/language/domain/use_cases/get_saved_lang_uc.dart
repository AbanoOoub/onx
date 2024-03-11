import 'package:dartz/dartz.dart';
import 'package:task/features/language/domain/repositories/language_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetSavedLangUC implements UseCase<String, NoParams> {
  final LanguageRepository languageRepository;

  GetSavedLangUC({required this.languageRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await languageRepository.getSavedLang();
}