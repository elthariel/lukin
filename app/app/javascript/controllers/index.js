import { Application } from "@hotwired/stimulus";
import { registerControllers } from "stimulus-vite-helpers";

// Start the Stimulus application.
const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

// Controller files must be named *_controller.js.
const controllers = import.meta.glob("./**/*_controller.js", { eager: true });
registerControllers(application, controllers);
