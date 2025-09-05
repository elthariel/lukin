import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.frame.loaded.then(() => {
      this.frameLoaded();
    });
  }

  get frame() {
    return this.element.querySelector("turbo-frame");
  }

  frameLoaded() {
    let lastMessage = this.element.querySelector(".message:last-of-type");
    if (lastMessage) {
      lastMessage.scrollIntoView({ behavior: "smooth" });
    }
  }
}
