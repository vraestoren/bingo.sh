#!/bin/bash

params=null
api="https://invest.divweb.ru/api"
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"

authenticate() {
    params="vk_access_token_settings=${5:-}&vk_app_id=7766223&vk_are_notifications_enabled=${6:-0}&vk_is_app_user=${7:-0}&vk_is_favorite=${8:-0}&vk_language=${9:-ru}&vk_platform=${10:-desktop_web}&vk_ref=$4&vk_ts=$3&vk_user_id=$2&sign=$1"
}

_get() {
    curl -s -X GET "$api/$1"    \
        -H "User-Agent: $user_agent" \
        -H "xvk: $params"
}

_post() {
    curl -s -X POST "$api/$1"   \
        -H "User-Agent: $user_agent" \
        -H "xvk: $params"       \
        -d "$2"
}

app_init() {
    _get "init/"
}

get_popular() {
    _get "getPopular/"
}

get_new() {
    _get "getNew/"
}

like_bingo() {
    _post "like/$1" '{"like": '${2:-true}'}'
}

report_bingo() {
    _post "claim/$1" '{"reason": "'$2'", "comment": "'${3:-}'"}'
}

delete_bingo() {
    _get "delete/$1"
}
