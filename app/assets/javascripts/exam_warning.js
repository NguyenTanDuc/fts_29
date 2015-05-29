$(document).ready(function(){
  $('input[name=btn_submit]').click(function(){
    window.btn_clicked = true;
  });
  window.onbeforeunload = function(){
    if(!window.btn_clicked){
      return "You are not submit yet, your answer can't save after leave this page."
    }
  };
});
