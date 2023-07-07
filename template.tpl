___TERMS_OF_SERVICE___

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
  "displayName": "Simple Bot Detector",
  "categories": [
    "UTILITY"
  ],
  "description": "creates a marker for known rendering bots from search engines like Google, Bing, Baidu, Yandex  or services like Lighthouse, Ahrefs and others that identify in the user agent string",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "setupFields",
    "displayName": "Advanced Configuration",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "additionalMarkers",
        "displayName": "Additional Bot Markers",
        "simpleValueType": true,
        "canBeEmptyString": true,
        "lineCount": 5,
        "textAsList": true,
        "valueHint": "add additional user-agent markers like \"SomeBot\" (one per row)",
        "help": "if you use certain rendering tools yourself or suspect hits from known rendering bots that this variable does not detect, add a string that is contained in the bot´s user-agent string in a separate row."
      },
      {
        "type": "RADIO",
        "name": "rbInputType",
        "displayName": "User Agent Detection",
        "radioItems": [
          {
            "value": "header",
            "displayValue": "Get User Agent from Request Header",
            "help": "searches for bot marker strings in the user-agent request header"
          },
          {
            "value": "variable",
            "displayValue": "Set Input Variable",
            "help": "select your own variable and compare its value instead of the user-agent from the request header"
          }
        ],
        "simpleValueType": true,
        "help": "the user agent is detected from the request header by default. You can override this by choosing a variable that contains the user agent string from a parameter or event data if requests are not received directly from a browser."
      },
      {
        "type": "TEXT",
        "name": "inputVar",
        "displayName": "Input Variable",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "rbInputType",
            "paramValue": "variable",
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "includeUserAgent",
        "checkboxText": "Include User Agent for Potential Bots",
        "simpleValueType": true,
        "defaultValue": false
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const getRequestHeader = require('getRequestHeader');
var ua_org;

if ((data.rbInputType === "variable") && data.inputVar && data.inputVar != "") 
  ua_org = data.inputVar;
else
  ua_org = getRequestHeader('user-agent');
  
var ua = ua_org.toLowerCase();

var bots_ua = [
  //user-agents for known rendering crawlers from search engines and other services   
  "Googlebot", 
  "AdsBot-Google",
  "Mediapartners-Google",
  "Google Search Console",
  "Chrome-Lighthouse",
  "DuckDuckBot",
  "JobboerseBot",
  "woobot",
  "PingdomPageSpeed",
  "PagePeeker",
  "Refindbot",
  "HubSpot",
  "Yandex",
  "Investment Crawler",
  "BingPreview",
  "Bingbot",
  "Baiduspider",
  "Sogou",
  "SISTRIX",
  "facebookexternalhit",
  "Site-Shot",
  "wkhtmltoimage",
  "SMTBot", 
  "PetalBot", 
  "AhrefsBot", 
  "avalex",
  "RyteBot", 
  "SemrushBot",
  "Cookiebot", 
  "Seekport Crawler",
  "Cocolyzebot", 
  "Veoozbot", 
  "YisouSpider",
  "Elisabot",
  "ev-crawler",
  "screeenly-bot", 
  "Cincraw",
  "Applebot",
  "headline.com",
  "SeekportBot",
  "BitSightBot",
  "BrightEdge",
  "Google-InspectionTool",

  //poorly configured headless tools
  "HeadlessChrome",
  "MSIE 5.0",
  "PhantomJS"
];

if (data.additionalMarkers.length > 0) 
  bots_ua = bots_ua.concat(data.additionalMarkers);

var mrk;
for (var i=0;i<bots_ua.length;i++) {
  var bt = bots_ua[i].trim();
  if ((bt != "") && (ua.indexOf(bt.toLowerCase()) >= 0)) {mrk = "Bot ("+bt+")"; break;} 
}

if (!mrk && ((ua.indexOf('crawler') >= 0) || (ua.indexOf('spider') >= 0) ||  
             ((ua.indexOf('bot') >= 0) && (ua.indexOf('cubot') < 0)))) {
  mrk = "Potential Bot";
  if (data.includeUserAgent) mrk += " ("+ua_org+")";
}

return mrk || "OK";


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
                    "string": "user-agent"
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
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2.4.2021, 18:00:31


