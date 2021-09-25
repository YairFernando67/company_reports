import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = [ "companyCard" ]

  initialize() {
    $('.dropdown-trigger').dropdown();
    $(document).on('turbolinks:load', function() {
      $(".company-card").addClass("animated fadeIn")
    });
  }

  cardTransition() {
  }
}
