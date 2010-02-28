$('a[href][rel="external"]').live('click', function() {
  window.open(this.href,'','');
  return false;
});
