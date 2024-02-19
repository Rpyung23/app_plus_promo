import 'dart:convert';

const BASE_URL = "http://66.240.205.86:3010";

const headersApi = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json'
};

final encondingApi = Encoding.getByName('utf-8');

const url_static = "${BASE_URL}/static";

const url_login_client = "${BASE_URL}/login_client";

const url_login_vendedor = "${BASE_URL}/login_admin";

const url_create_client = "${BASE_URL}/create_client";

const url_create_vendedor = "${BASE_URL}/create_admin";

const url_create_cupon = "${BASE_URL}/create_cupon";

const url_list_cupon = "${BASE_URL}/read_all_cupon";

const url_list_client_cupon = "${BASE_URL}/read_all_client_cupon";

const url_list_client_cupon_categoria =
    "${BASE_URL}/read_all_client_category_cupon";

const url_upload_foto = "${BASE_URL}/upload_foto";

const url_update_cupon = "${BASE_URL}/update_cupon";

const url_consumir_cupon = "${BASE_URL}/consumir_cupon";

const url_profile_client = "${BASE_URL}/profile_client";

const url_profile_usuario = "${BASE_URL}/profile_usuario";

const url_categorie = "${BASE_URL}/categories";
