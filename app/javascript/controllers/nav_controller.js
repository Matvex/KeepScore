import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    const currentPath = window.location.pathname
    this.linkTargets.forEach(link => {
      const linkPath = new URL(link.href).pathname
      if (currentPath.startsWith(linkPath)) {
        link.classList.add("active")
      } else {
        link.classList.remove("active")
      }
    })
  }
}
