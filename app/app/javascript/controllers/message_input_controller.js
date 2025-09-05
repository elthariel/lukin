import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "input", "send"];

  connect() {
    console.log("this.formTarget: ", this.formTarget);
    console.log("this.sendTarget: ", this.sendTarget);

    this.formTarget.addEventListener("turbo:submit-start", (e) => {
      this.submitStart(e);
    });
    this.formTarget.addEventListener("turbo:submit-end", (e) => {
      this.submitEnd(e);
    });
  }

  submit() {
    this.formTarget.requestSubmit();
  }

  type(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      if (this.inputTarget.value.trim() === "") {
        event.preventDefault();
        return;
      }

      event.preventDefault();
      this.submit();
    }
  }

  submitStart(e) {
    if (this.inputTarget.value.length == 0) {
      e.detail.formSubmission.stop();
      return;
    }
    this.sendTarget.classList.add("btn-disabled");
  }

  submitEnd(e) {
    this.sendTarget.classList.remove("btn-disabled");
    if (e.detail.success) {
      this.inputTarget.value = "";
    }
  }
}
