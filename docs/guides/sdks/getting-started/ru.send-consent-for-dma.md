---
title: Отправить согласие на соответствие DMA
slug: send-consent-for-dma-compliance
category:
  uri: SDK AppsFlyer
parent:
  uri: получение запущено
privacy:
  view: публичный
position: 12
---

В рамках законодательства ЕС [Закон о цифровом маркетинге](https://commission.europa.eu/strategy-and-policy/priorities-2019-2024/europe-fit-digital-age/digital-markets-act-ensuring-fair-and-open-digital-markets_en) (ДМА) Прежде чем использовать персональные данные от сторонних сервисов для рекламы, компании больших технологий должны получить согласие от европейских конечных пользователей.

соблюсти законодательство, Google и Amazon требуют от клиентов AppsFlyer включать конкретные поля согласия при отправке событий, которые происходят от конечных пользователей ЕС на эти платформы. он AppsFlyer SDK (v6.13.0+) может собирать и отправлять необходимые данные согласия с каждым событием для удовлетворения этого требования.

> 📘 Заметка
>
> Все страны ЕС подчиняются ВВПР и DMA, а также странам, не входящим в ЕС, таким, как Соединенное Королевство и Швейцария.

Смотрите руководства по следующим платформам:

<style>
  .button-container {
  	display: flex;
  }
  . utton {
    display: flex;
    justify-content: center;
    выравнивание элементов: центр;
    ширина: 200px;
	  радиус границы: 6px;
    Закладка: 8px;
    правый край: 4px;
	}
  . utton:before {  
  	margin-right: 4px;  
  }
  .button. ndroid {  
    border: solid 2px #3DDC84;  
  }
  . utton.reactnative {  
    border: solid 2px #FF8C00;  
  }
  .button. os {  
  	border-radius: 6px;  
    padding: 8px;  
    границы: твердый 2px #7D7D7D;  
  }
   . utton. nity {  
    border: solid 2px #3DDC84;  
    border-color: var(--project-primary-color);  
  }
  . os:before {  
        содержимое: url("<https://files.readme.io/19fdc72-apple-icon.svg")>;  
  }
  . ndroid:before {  
        content: url("<https://files.readme.io/d7dc5a3-android-icon.svg")>;  
  }
. nity:before {  
    content: url("<https://files.readme.io/59acdf6-unity-icon.svg")>;  
}
. eactnative:before {  
   content: url("<https://files.readme.io/3e1288d-reactnative-icon.svg")>;  
}
. lutter:before {  
    content: url("<https://files.readme.io/1f70175-flutter-icon.svg")>;  
}  
</style>

<div class="button-container"><a class="button android" href="https://dev.appsflyer.com/hc/docs/android-send-consent-for-dma-compliance">Android SDK&nbsp;&nbsp;</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance">iOS SDK</a></div>
