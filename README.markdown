Ceci est le futur/nouveau site du [PLUG](http://plugfr.org/)

Il utilise [Jekyll](http://jekyllrb.com) pour être "compilé" en un ensemble de fichiers statiques que l'on peut héberger facilement

Le contenu est importé depuis l'ancien site sous SPIP, exporté en XML via phpMyAdmin. Le fichier est dans `./pub/spip/spip_articles.xml`
Le script Ruby ayant servi à parser l'export XML (issu de phpMyAdmin) se trouve dans `./pub/spip/migration_plug.rb`
Les fichiers générés par ce script ont été passablement modifiés à la main après coup, mais il peut avoir une valeur pédagogique.

Certains contenus (images, pdf, …) ont été copiés dans le dossier `./pub` pour pouvoir être reliés aux articles. Ça n'est pas exhaustif.