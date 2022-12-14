# Simple Bot Detector
**Custom Variable Template for Server-Side Google Tag Manager**

Detection for Known Rendering Bot User Agents 

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/simple-bot-detector)

---

## Bot Detection via User Agent
A good part of the client-side bot marker for Google Analytics (https://www.markus-baersch.de/blog/headless-browser-in-google-analytics-erkennen/) is based on detection of known bots using the user agent. At least this part can and should be used on the server as a substitute in case of missing detection in the browser as well. 

While the method should generally be applicable in any server-side tagging scenario where data can be received and distributed, this template is designed for use with a server-side Google Tag Manager container. It can be imported in GTM under "Templates" -> "New" - "Import File".

With this template, a lot of known bots can already be detected without further configuration. But the result of the Bot Detector Variable can also be used for detection and exclusion of further bots, by optionally showing potential bots together with their complete user agent in the result. If you regularly look at the list of "Potential Bots" and add identifiers to the configuration as additional bots, these are then assigned to the class of "safely detected" bots. In this way, you can "sharpen" the exclusion initially and then regularly check and readjust if necessary.

## Using the Bot Marker
Import the variable template for the "Simple Bot Detector" into a server-side Tag Manager container. You can then use it to create a variable that detects bots. In general, no configuration is required... but possible.

For this purpose, a list of additional strings can be defined, which can be used to detect **additional bots** by comparing them with the user agent. However, the template already contains a quite extensive list of known bots from search engines and others, which are recognized without entries in this field.

As a further option, you can use a user agent string that is not read from the request, but from an arbitrary variable. This is useful if the incoming requests do not come directly from the browser and the user agent is added as a parameter or in the request´s payload and should therefore be read from a variable.

If the evaluation of the user agent is to be used to identify other potential bots directly from the Bot Detector result, it is also possible to specify that the user agent  potential bots (see below) should be added to the result.

## Results of the Bot Detector
* **Known bots**: If a string from the identifier of known bots is found in the user agent, _"Bot (botname)"_ is returned as result. The name matches the string that was searched for. An example would be _"Bot (GoogleBot)"_.

* **Potential bots**: in the next step, the user agent gets searched for "bot", "crawler" or "spider" and strings such as "Cubot" (smartphone brand) are taken into account. If a match is found, _"Potential Bot"_ or _"Potential Bot (User Agent)"_ is the result, depending on the setting described above. If the option is active, the user agent is specified in full, so that a decision can be made as to whether to include the entry in list of self-defined bot markers in order to reliably classify them as a bots. Alternatively, you could extract the user agent in a separate variable from the header or event data and pass it to Google Analytics together with the bot marker (e.g. as user-defined property; see below).

* ==Everything else==: If both of the above checks fail, the result is _"OK"_.

## How to Use the Results in SSGTM
Like all variables, you can use their value to add to or control tracking. Examples:

* Create exclude triggers for bots: If you generally don't want bots to show up in a service like Google Analytics, you can create an exclusion trigger in the server-side Tag Manager container. Either everything that does not have "OK" as a value can serve as a trigger or, for example, only values that begin with _"Bot ("_ and are thus clearly recognized as a machine

* For firing triggers: If you want to collect bot hits in a separate property or e.g. in a separate BigQuery table, a tag serving for this purpose can also be provided with an explicit firing trigger

* Search table for separate tracking ID for "confessing" bots: define separate properties for bots or potential bots for Universal Analytics or Data Streams for GA4 with a search table variable. As with triggers, the different values can be used to "distribute" the properties as desired
- Bot markers can be passed to GA4 as user property / event property: While it is not intended for Universal Analytics to change the hits with a server-side tag, at least with GA4 you can add further User Defined Properties on event or user level and thus e.g. provide each hit with a Bot Marker. This can be used to separate people from bots in different segments instead of working in different properties
