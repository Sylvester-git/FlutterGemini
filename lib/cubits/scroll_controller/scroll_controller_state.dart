// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ScrollControllerState extends Equatable {
  final ScrollController scrollController;

  const ScrollControllerState({required this.scrollController});


  @override
  List<Object?> get props => [
        scrollController,
      ];
}
