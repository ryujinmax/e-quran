import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/data/model/surat_model.dart';
import 'package:flutter_ahlul_quran_app/data/service_api.dart';
import 'package:http/http.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit(this.apiService) : super(SurahInitial());

  final ApiService apiService;

  void getAllSurah() async {
    emit(SurahLoading());
    final result = await apiService.getAllSurah();
    result.fold(
        (l) => SurahError(message: l), (r) => SurahLoaded(listSurah: r));
  }
}
