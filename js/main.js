$('a[href][rel="external"]').live('click', function() {
  window.open(this.href,'','');
  return false;
});

jQuery(document).ready(function($) {
  $("#tweets").tweet({
    username: "@plugfr",
    count: 8,
    loading_text: "Chargement ..."
  });
});