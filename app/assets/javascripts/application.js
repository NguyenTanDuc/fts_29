// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require application_jquery

$(document).ready(function(){
  $(document).bind("ajaxSend", function(){
    $("body").addClass("loading-background")
    $("a,input").click(function(event){
      event.preventDefault();
    });
    $(".loading").fadeIn(1500);
    }).bind("ajaxComplete", function(){
      $("body").removeClass("loading-background")
      $(".loading").fadeOut(2000);
  }); 
  $(function(){    
    if($("h2[name=countdown]").attr("value") != null){
      var seconds = $("h2[name=countdown]").attr("value");
    }
    var interval = setInterval(function(){
      var hours = Math.floor(seconds/3600);
      var minutesLeft = Math.floor((seconds) - (hours*3600));
      var minutes = Math.floor(minutesLeft/60);
      var remainingSeconds = seconds % 60;
      if(hours < 10){
        hours = "0" + hours;
      }
      if(minutes < 10){
        minutes = "0" + minutes;
      }
      if(remainingSeconds < 10){
        remainingSeconds = "0" + remainingSeconds; 
      }     
      $("h2[name=countdown]").html(hours + " : " + minutes + " : " + remainingSeconds);
      if(seconds <= 0){
        clearInterval(interval);
        $("h2[name=countdown]").html("Completed");
        alert("Time up");
        if($("input[name=btn_submit]").length){
          $("input[name=btn_submit]").click();
        }
        else{          
          var exam_id = $("h2[name=countdown]").attr("id");
          $.ajax({
            url : "exams/" + exam_id,
            type : "patch",
            data : "complete=" + exam_id              
          }).done(function(){
            location.reload();
          });        
        }          
      }
      else{
        seconds--;
      }
    }, 1000);
  });
});

$(document).on("click", "input[type=checkbox]", function () {
  $("input[type=checkbox]").not($(this)).prop("checked", false);
});
