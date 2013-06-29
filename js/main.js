$('a[href][rel="external"]').live('click', function() {
  window.open(this.href,'','');
  return false;
});

jQuery(document).ready(function($) {
  $('.mel').each(function (i) {
    var temp = $(this).html();
    temp = temp.replace(/\/\//g,"@");
    temp = temp.replace(/\*/g,".");
    $(this).html(temp);
  })
});