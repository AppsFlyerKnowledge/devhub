---
title: "Developer Journey"
slug: "dj-getting-started"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
excerpt: "SDK integration wizard"
hidden: false
order: 0
---

Let [Developer Journey](https://dj.dev.appsflyer.com/?utm_source=devhub&utm_medium=dj-getting-started) (our SDK integration wizard) guide you through the SDK integration process.

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Get started with our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?utm_source=devhub&utm_medium=dj-getting-started');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_getting_started', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

You simply provide some credentials and customization choices, and the wizard generates code snippets to be copied and pasted into your project. After the implementation phase, you will follow guided testing and troubleshooting. 

The Developer Journey requires:

- [Your application ID ](https://support.appsflyer.com/hc/en-us/articles/207377436-Adding-an-app-to-AppsFlyer#enter-app-details)
- [Your AppsFlyer Dev Key](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key)
- [AppsFlyer v2 authentication token ](https://support.appsflyer.com/hc/en-us/articles/360004562377-Managing-API-and-Server-to-server-S2S-tokens#reaching-the-tokens-page)  
  (Required only if you wish to follow the automatic testing flow)

Currently the Developer Journey only supports:

- Operation systems
  - Android
  - iOS
- Flows
  - SDK [installation](https://dev.appsflyer.com/hc/docs/sdk-installation) and [integration](https://dev.appsflyer.com/hc/docs/sdk-integration)
  - [In-app events](https://dev.appsflyer.com/hc/docs/in-app-events-sdk)
  - [Deep Linking](https://dev.appsflyer.com/hc/docs/dl_work_flow)