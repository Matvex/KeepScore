import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["formWrapper"]
  static values = { hasErrors: Boolean }

  connect() {
    if (this.hasErrorsValue) {
      this.openForm()
    }
  }

  toggleForm() {
    const wrapper = this.formWrapperTarget
    if (wrapper.style.maxHeight === "0px" || !wrapper.style.maxHeight) {
      this.openForm()
    } else {
      wrapper.style.maxHeight = "0"
    }
  }

  openForm() {
    const wrapper = this.formWrapperTarget
    wrapper.style.maxHeight = wrapper.scrollHeight + "px"
  }
}