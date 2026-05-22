import 'package:dartz/dartz.dart';

typedef ServerResponse<T> = Future<Either<String, T>>;
