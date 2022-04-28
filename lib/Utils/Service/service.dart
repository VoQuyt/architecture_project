/*
  Rest api, local data, native api
*/

library lib_service;

import 'dart:io';

import 'package:architecture_project/Config/config.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

part 'Local_Data/database.dart';
part 'Local_Data/share_reference.dart';
part 'Rest_Api/rest_api.dart';
