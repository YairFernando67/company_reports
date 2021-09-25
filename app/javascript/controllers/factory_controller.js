import { Controller } from 'stimulus';

export default class extends Controller {

  initialize() {
    $('nav.light-blue').removeClass(["light-blue", "darken-2"])
    $('nav').css("background-color", "#6A48EA");
  }
}
