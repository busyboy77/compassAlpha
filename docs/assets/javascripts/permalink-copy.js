/* Heading permalink: copy the deep link to the clipboard on click, with a brief toast.
   Event-delegated on document so it survives Material's instant navigation. */
(function () {
  function flash(message) {
    var toast = document.createElement("div");
    toast.textContent = message;
    toast.setAttribute(
      "style",
      "position:fixed;left:50%;bottom:2rem;transform:translateX(-50%);" +
        "background:#1f2a36;color:#fff;padding:.5rem .9rem;border-radius:.4rem;" +
        "font-size:.8rem;line-height:1;z-index:2147483647;opacity:0;" +
        "transition:opacity .15s ease;box-shadow:0 2px 10px rgba(0,0,0,.35)"
    );
    document.body.appendChild(toast);
    requestAnimationFrame(function () {
      toast.style.opacity = "1";
    });
    setTimeout(function () {
      toast.style.opacity = "0";
      setTimeout(function () {
        toast.remove();
      }, 220);
    }, 1400);
  }

  document.addEventListener(
    "click",
    function (event) {
      var anchor = event.target.closest && event.target.closest("a.headerlink");
      if (!anchor) return;
      var hash = anchor.getAttribute("href");
      if (!hash) return;
      var url = location.origin + location.pathname + hash;
      if (navigator.clipboard && navigator.clipboard.writeText) {
        event.preventDefault();
        navigator.clipboard.writeText(url).then(
          function () {
            flash("Link copied to clipboard");
          },
          function () {
            // Clipboard blocked — fall back to normal anchor navigation.
            location.hash = hash;
          }
        );
      }
      // No clipboard API: let the default anchor behaviour run (sets the hash).
    },
    false
  );
})();
