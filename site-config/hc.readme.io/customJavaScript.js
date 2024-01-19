$(window).on("pageLoad", function (e, state) {
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
