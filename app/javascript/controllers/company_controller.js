import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = [ "companyCard" ]

  initialize() {
    console.log("Init Company controller")
    $('.dropdown-trigger').dropdown();
    $(document).on('turbolinks:load', function() {
      console.log("Page cjamge")
      $(".company-card").addClass("animated fadeIn")
    });
  }

  cardTransition() {
    console.log("Card transition")
    console.log($(".company-card"))
  }
}