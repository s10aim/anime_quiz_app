import { Controller } from '@hotwired/stimulus'
import { Modal } from 'bootstrap'

export default class extends Controller {
  connect() {
    this.modal = new Modal(document.getElementById('quiz-report-modal'), {
      keyboard: false,
    })
  }

  showModal() {
    this.modal.show()
  }

  hideModal() {
    this.modal.hide()
  }

  submitEnd(e) {
    if (e.detail.success)
      setTimeout(() => {
        this.hideModal()
      }, 3000)
  }
}
