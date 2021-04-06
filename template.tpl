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
  "Cookiebot", 
  "Seekport Crawler",
  
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
