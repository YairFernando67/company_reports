import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["form", "summary", "description"]

  initialize() {
  }

  createCalendar() {
    let summary = $(this.summaryTarget).val()
    let description = $(this.descriptionTarget).val()
    let url = $(this.formTarget).attr("action")
    $.ajax({
      type: "POST",
      url:url,
      data: {summary, description},
      error: function(xhr, textStatus, errorThrown) {
        console.log(xhr.responseJSON)
      }
    })
  }

  toggleCalendarFrom() {
    $(this.formTarget).toggleClass("hidden")
  }
}
