import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["form"]

  initialize() {
    // console.log(this.formTarget)
    // console.log("facade")
  }


  showCalendarFrom() {
    console.log("Show form")
    $(this.formTarget).removeClass("hidden")
  }
}
