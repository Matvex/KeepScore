// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", function() {
  const languageSwitch = document.getElementById("language-switch");

  if (languageSwitch) {
    languageSwitch.addEventListener("change", function() {
      const form = document.getElementById("language-switch-form");
      const url = new URL(form.action);
      url.searchParams.set("locale", languageSwitch.checked ? "lv" : "en");
      Turbo.visit(url.toString());
    });
  }

  const links = document.querySelectorAll(".nav-link");
  const currentPath = window.location.pathname;

  links.forEach(link => {
    const linkPath = new URL(link.href).pathname;
    if (currentPath.startsWith(linkPath)) {
      link.classList.add("active");
    } else {
      link.classList.remove("active");
    }
  });
});