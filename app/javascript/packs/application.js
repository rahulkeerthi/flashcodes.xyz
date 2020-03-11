require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


import "bootstrap";
import { initUpdateNavbarOnScroll } from '../components/navbar';
import { tooltips } from '../components/tooltips';
import $ from 'jquery';


document.addEventListener('turbolinks:load', () => {
  initUpdateNavbarOnScroll();

});

const userPoints = $('.progress-bar').data().points;

if (userPoints == 0.0) {
  $('.toast').toast('show')
}
initUpdateNavbarOnScroll();


// document.addEventListener('turbolinks:load', () => {
//   tooltips();
// });
