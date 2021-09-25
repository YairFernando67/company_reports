import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["form", "summary", "description", "btnCreateCalendar"]

  summaryChange(e) {
    let summary = e.target.value
    if (summary.length > 0) {
      $(this.btnCreateCalendarTarget).removeClass("disabled")
    } else {
      $(this.btnCreateCalendarTarget).addClass("disabled")
    }
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
