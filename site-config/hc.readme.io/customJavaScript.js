$(window).on("pageLoad", function (e, state) {
  /* Landing page listeners */
  /* document.addEventListener("mouseover", (e) => {
      if (e.target.classList.contains("landing-page__item-link"))
        e.target.style.color = "grey";
    });
    document.addEventListener("mouseout", (e) => {
      if (e.target.classList.contains("landing-page__item-link"))
        e.target.style.color = "#434446";
    }); */

  /* Dynamic styling */

  // All rights reserved + date
  setTimeout(() => {
    const copyrights = document.getElementById("copyrights");
    if (copyrights)
      copyrights.textContent = `©${new Date().getFullYear()} AppsFlyer Ltd.  All rights reserved.`;
  }, 0);

  const links = document.querySelectorAll(
    '.markdown-body a:not([class*="heading-anchor-icon"])'
  );
  links.forEach((link) => {
    link.style.color = "#3670B8";
  });
  if (!document.querySelector(".af-language-selector")) {
    const header = document.querySelector("h1").parentNode;
    const selectorContainer = document.createElement("div");
    const selector = `
  <div class="af-language-selector">
      <div class="language"><div class="language-button"><i class="fas fa-globe"></i><span class="language-selector">${(() => {
        switch (location.host) {
          case "zh.dev.appsflyer.com":
            return "简体中文";
          case "fr.dev.appsflyer.com":
            return "Français";
          case "id.dev.appsflyer.com":
            return "Bahasa Indonesia";
          case "ja.dev.appsflyer.com":
            return "日本語";
          case "ko.dev.appsflyer.com":
            return "한국어";
          case "es.dev.appsflyer.com":
            return "Español";
          case "pt.dev.appsflyer.com":
            return "Português";
          case "ru.dev.appsflyer.com":
            return "Русский";
          case "vi.dev.appsflyer.com":
            return "Tiếng Việt";
          case "dev.appsflyer.com":
            return "English";
        }
      })()}</span></div>
      <div class="af-dropdown-menu hidden">
      <a href="https://dev.appsflyer.com${location.pathname}"><span ${
      location.host == "dev.appsflyer.com"
        ? `class="language-english selected"`
        : `class="language-english"`
    }>English</span></a>
          <a href="https://zh.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "zh.dev.appsflyer.com"
        ? `class="language-chinese selected"`
        : `class="language-chinese"`
    }>简体中文</span></a>
  <a href="https://fr.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "fr.dev.appsflyer.com"
        ? `class="language-french selected"`
        : `class="language-french"`
    }>Français</span></a>
  <a href="https://id.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "id.dev.appsflyer.com"
        ? `class="language-indonesian selected"`
        : `class="language-indonesian"`
    }>Bahasa Indonesia</span></a>
  <a href="https://ja.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "ja.dev.appsflyer.com"
        ? `class="language-japanese selected"`
        : `class="language-japanese"`
    }>日本語</span></a>
  <a href="https://ko.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "ko.dev.appsflyer.com"
        ? `class="language-korean selected"`
        : `class="language-korean"`
    }>한국어</span></a>
  <a href="https://es.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "es.dev.appsflyer.com"
        ? `class="language-spanish selected"`
        : `class="language-spanish"`
    }>Español</span></a>
  <a href="https://pt.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "pt.dev.appsflyer.com"
        ? `class="language-portuguese selected"`
        : `class="language-portuguese"`
    }>Português</span></a>
  <a href="https://ru.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "ru.dev.appsflyer.com"
        ? `class="language-russian selected"`
        : `class="language-russian"`
    }>Русский</span></a>
  <a href="https://vi.dev.appsflyer.com${location.pathname}"><span ${
      location.host == "vi.dev.appsflyer.com"
        ? `class="language-vietnamese selected"`
        : `class="language-vietnamese"`
    }>Tiếng Việt</span></a>
      </div>
  </div>
  `;

    selectorContainer.innerHTML = selector;
    header.insertBefore(selectorContainer, document.querySelector("h1"));
    function handleLanguageHover(e) {
      const dd = document.querySelector(".af-dropdown-menu");
      if (e.target.classList.contains("language-selector")) {
        if (dd.classList.contains("hidden")) {
          dd.classList.remove("hidden");
          return;
        }
        dd.classList.add("hidden");
      }
      dd.classList.add("hidden");
    }
    document.addEventListener("click", handleLanguageHover);
    document.querySelectorAll(".toc-children li a").forEach((el) => {
      el.setAttribute(
        "href",
        `#${encodeURIComponent(
          el.textContent
            .replace(/ /g, "-")
            .replace(/[\s\"\(\)\:]/g, "")
            .toLowerCase()
        )}`
      );
    });
  }

  /* const codes = document.querySelectorAll('.markdown-body pre').forEach(code => {
                code.style.marginTop = "8px";
            }); */
  // const sections = document.querySelectorAll("#hub-sidebar-content ul:not(.subpages) li[class]").forEach(e => console.log(window.getComputedStyle(e,'::after')));
  /*
    let prevRatio = 0;
    // define observer options
    const options = {
      root: null, // relative to document viewport 
      rootMargin: '-2px', // margin around root. Values are similar to css property. Unitless values not allowed
      threshold: 1.0 // visible amount of item shown in relation to root
    };
    
    
  
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        const id = entry.target?.getAttribute("id");
        // console.log(id);
        if (id && entry.rootBounds.top + 20 > entry.boundingClientRect.y) {
          // console.log();
          // prevRatio = entry.intersectionRatio;
          const tocMatch = document.querySelector(`.toc-list a[href="#${id}"]`);
          const tocLinks = document.querySelectorAll(".toc-list a:not(.tocHeader)");
          const tocHeader = document.querySelector(".tocHeader");
          if(tocMatch) {
            const tocRest = Array.from(tocLinks).filter(
              (el) => el.getAttribute("href") !== tocMatch.getAttribute("href")
            );
            tocRest.forEach((el) => {
                el.style.color = "#434446";
                el.style.fontWeight = "normal";
              });
            tocHeader.style.fontWeight = "bold";
              tocHeader.style.color = "black";
              tocMatch.style.color = "#00C2FF";
              tocMatch.style.fontWeight = "bold";
          }
          // console.log(tocTarget);
          // console.log(tocTarget.textContent);
        }
      });
    }, options);
    
    document.querySelectorAll(".heading-anchor").forEach(h => observer.observe(h));
    */

  function handleHashChange(e) {
    const newURL = new URL(e.newURL);
    const hash = newURL.hash;
    const tocLinks = document.querySelectorAll(".toc-list a:not(.tocHeader)");
    const tocHeader = document.querySelector(".tocHeader");
    const tocMatch = Array.from(tocLinks).find(
      (el) => el.getAttribute("href") === hash
    );
    const tocRest = Array.from(tocLinks).filter(
      (el) => el.getAttribute("href") !== hash
    );
    tocHeader.style.fontWeight = "bold";
    tocHeader.style.color = "black";
    tocMatch.style.color = "#00C2FF";
    tocMatch.style.fontWeight = "bold";
    tocRest.forEach((el) => {
      el.style.color = "#434446";
      el.style.fontWeight = "normal";
    });
  }
  window.addEventListener("hashchange", handleHashChange);
});
