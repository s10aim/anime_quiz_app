import { Controller } from '@hotwired/stimulus'
import { disableBodyScroll, enableBodyScroll } from 'body-scroll-lock'

export default class extends Controller {
  connect() {
    this.hamburgerTarget = document.getElementById('menu-btn-check')
  }

  toggle(e) {
    if (e.target.checked) {
      disableBodyScroll(this.hamburgerTarget)
    } else {
      enableBodyScroll(this.hamburgerTarget)
    }
  }
}
