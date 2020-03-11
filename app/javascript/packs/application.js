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

// const userLevel = $('.progress-bar').data().level;
// console.log(userLevel);

// userLevel.addEventListener('change', function(){
// })

// const userLevel = document.querySelector('#levelPara')

// userLevel.addEventListener('change', (event) => {
//   console.log(event)
// })


initUpdateNavbarOnScroll();


// document.addEventListener('turbolinks:load', () => {
//   tooltips();
// });
