import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';

abstract class LanguageRepository{
  Future<Either<Failure,String>> getSavedLang();
  Future<Either<Failure, bool>> changeLanguage({required String langCode});
}