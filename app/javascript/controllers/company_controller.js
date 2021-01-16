import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = [ "companyCard" ]

  initialize() {
    console.log("Init Company controller")
    $('.dropdown-trigger').dropdown();
  }

  cardTransition() {
    console.log("Card transition")
    console.log($(".company-card"))
  }
}