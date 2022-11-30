import { initSweetalert } from '../plugins/init_sweetalert';

initSweetalert('#icon-fav', {
  title: "Are you sure?",
  text: "This action cannot be reversed",
  icon: "warning"
}, (value) => {
  console.log(value);
  if (value) {
    const link = document.querySelector('#delete-link');
    link.click();
  }
});
