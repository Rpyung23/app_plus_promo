import 'dart:convert';

const BASE_URL = "http://159.223.111.107:3009";

const headersApi = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json'
};

final encondingApi = Encoding.getByName('utf-8');

const url_login_client = "${BASE_URL}/login_client";

const url_login_vendedor = "${BASE_URL}/login_admin";

const url_create_client = "${BASE_URL}/create_client";

const url_create_vendedor = "${BASE_URL}/create_admin";
