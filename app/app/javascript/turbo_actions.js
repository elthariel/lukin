import { Turbo } from "@hotwired/turbo-rails";

Turbo.StreamActions.scroll = function () {
  this.targetElements.forEach((targetElement) => {
    targetElement.lastElementChild.scrollIntoView({ behavior: "smooth" });
  });
};
