import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux_starter/data/file_storage.dart';
import 'package:flutter_redux_starter/data/models/serializers.dart';
import 'package:flutter_redux_starter/redux/auth/auth_state.dart';
import 'package:flutter_redux_starter/redux/ui/ui_state.dart';
import 'package:meta/meta.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  Future<File> saveAuthState(AuthState state) async {
    var data = serializers.serializeWith(AuthState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<AuthState> loadAuthState() async {
    String data = await fileStorage.load();
    return serializers.deserializeWith(AuthState.serializer, json.decode(data));
  }

  Future<File> saveUIState(UIState state) async {
    var data = serializers.serializeWith(UIState.serializer, state);
    return await fileStorage.save(json.encode(data));
  }

  Future<UIState> loadUIState() async {
    String data = await fileStorage.load();
    return serializers.deserializeWith(UIState.serializer, json.decode(data));
  }

  Future<FileSystemEntity> delete() async {
    return await fileStorage.exisits().then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exisits();
  }
}