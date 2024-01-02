import 'dart:convert';

const BASE_URL = "http://159.223.111.107:3009";

const headersApi = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json'
};

final encondingApi = Encoding.getByName('utf-8');

const url_login_usuario = "${BASE_URL}/login_admin";
