$('a[href][rel="external"]').live('click', function() {
  window.open(this.href,'','');
  return false;
});

jQuery(document).ready(function($) {
  $("#tweets").tweet({
    username: "@plugfr",
    avatar_size: 16,
    count: 5,
    loading_text: "Chargement ..."
  });
});