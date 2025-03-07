﻿___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "TikTok _ttp Generator",
  "categories": [
    "UTILITY",
    "ADVERTISING",
    "CONVERSIONS"
  ],
  "__wm": "VGVtcGxhdGUtQXV0aG9yX0ZhY2Vib29rRmJwR2VuZXJhdG9yLVNpbW8tQWhhdmE\u003d",
  "description": "This variable generates a value that can be used for TikTok\u0027s _ttp cookie.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "Use this template to generate a new \u003cstrong\u003e_ttp\u003c/strong\u003e cookie value used by TikTok (\u003ca href\u003d\"https://business-api.tiktok.com/portal/docs?id\u003d1771100936446977\"\u003ereference\u003c/a\u003e). You can use the \u003ca href\u003d\"https://tagmanager.google.com/gallery/#/owners/gtm-templates-simo-ahava/templates/cookie-monster\"\u003eCookie Monster\u003c/a\u003e tag template, for example, to set the cookie in the server response.\u003cbr\u003e\u003cbr\u003e"
  },
  {
    "type": "CHECKBOX",
    "name": "returnExisting",
    "checkboxText": "Return existing _ttp cookie value if available",
    "simpleValueType": true,
    "help": "Check this box to first see if _ttp has already been set. If it has, return its value instead of generating a new one."
  }
]


___SANDBOXED_JS_FOR_SERVER___

const computeEffectiveTldPlusOne = require('computeEffectiveTldPlusOne');
const generateRandom = require('generateRandom');
const getCookieValues = require('getCookieValues');
const getEventData = require('getEventData');
const getRequestHeader = require('getRequestHeader');

const ttp = getCookieValues('_ttp');

if (data.returnExisting && ttp.length) return ttp[0];

const characters =
  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
let result = '';
for (let i = 0; i < 27; i++) {
  const randomIndex = generateRandom(0, characters.length - 1);
  result += characters.charAt(randomIndex);
}
return result;


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "page_location"
              }
            ]
          }
        },
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_ttp"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: If return existing checkbox is marked, return it the value if it exists in
    cookie
  code: |-
    const expectedResult = 'test';
    mock('getCookieValues', [expectedResult]);

    mockData.returnExisting = true;

    const variableResult = runCode(mockData);

    assertThat(variableResult).isEqualTo(variableResult);
- name: If return existing checkbox is marked, generate and return a random value
    if it doesn't exist in cookie
  code: |-
    mockData.returnExisting = true;

    mock('getCookieValues', []);

    const variableResult = runCode(mockData);

    assertThat(variableResult).isString();
    assertThat(variableResult).hasLength(resultLength);
- name: If return existing checkbox is NOT marked, return random string
  code: |-
    const cookieValue = 'test';
    mock('getCookieValues', [cookieValue]);

    const variableResult = runCode(mockData);

    assertThat(variableResult).isNotEqualTo(cookieValue);
    assertThat(variableResult).isString();
    assertThat(variableResult).hasLength(resultLength);
setup: |-
  const mockData = {};

  const resultLength = 27;


___NOTES___

Created on 09/11/2021, 11:46:23


