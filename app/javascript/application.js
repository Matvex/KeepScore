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
});