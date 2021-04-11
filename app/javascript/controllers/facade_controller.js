import { Controller } from 'stimulus';

export default class extends Controller {

  static targets = ["form", "summary", "description"]

  initialize() {
    // console.log(this.formTarget)
    // console.log("facade")
  }

  createCalendar() {
    let summary = $(this.summaryTarget).val()
    let description = $(this.descriptionTarget).val()
    let url = $(this.formTarget).attr("action")
    let serializeForm = $(this.formTarget).serialize()
    console.log(summary)
    console.log(description)
    console.log(url)
    console.log(serializeForm)
    $.ajax({
      type: "POST",
      url:url,
      data: {summary, description},
      success: function(r){
        console.log("Response", r)
        console.log(this)
        window.current_this = this
        hideCalendarFrom()
      },
      error: function(xhr, textStatus, errorThrown) {
        console.log(xhr.responseJSON)
      }
    })
  }

  showCalendarFrom() {
    console.log("Show form")
    $(this.formTarget).removeClass("hidden")
  }

  hideCalendarFrom() {
    console.log("Hide form")
    $(".calendar-form").addClass("hidden")
  }
}
