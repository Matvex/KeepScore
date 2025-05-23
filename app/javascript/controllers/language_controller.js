import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["switch", "form"]

  connect() {
    if (this.hasSwitchTarget) {
      this.switchTarget.addEventListener("change", this.switchLanguage.bind(this))
    }
  }

  switchLanguage() {
    const form = this.formTarget
    const url = new URL(form.action)
    url.searchParams.set("locale", this.switchTarget.checked ? "lv" : "en")
    window.Turbo.visit(url.toString())
  }
}
