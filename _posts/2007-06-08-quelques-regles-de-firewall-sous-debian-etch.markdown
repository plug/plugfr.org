---
title: "Quelques règles de firewall sous Debian (etch)"
layout: post
categories: divers
spip_id: 108
---
Après avoir installé une toute nouvelle Debian Etch et installé quelques services, j'ai eu besoin de quelques règles de firewall pour filtrer un peu ce qui circule.

Sous Debian, c'est [NetFilter](http://www.netfilter.org/) qui est installé par défaut, et il n'y a pas de règles actives.

Il y a la commande "**iptables**" qui permet de gérer les règles directement en ligne de commande, mais elles ne sont pas mémorisées et rechargées au prochain redémarrage. Il faut alors les écrire dans un fichier qui sera utilisé à chaque boot.

Pour cela il y a 2 optiques :
-# utiliser un script de démarrage, par exemple /etc/init.d/firewall
-# utiliser un script lié aux interfaces réseaux

### Un script lié aux interfaces réseaux ###

La seconde méthode correspond aux nouvelles recommandations de Debian depuis Sarge. Elle consiste à ré-initialiser les règles du firewall à chaque rechargement de l'interface réseau. Cependant, elle est un peu moins connue et pratiquée que la première. On verra donc ça plus tard.

### Un script de démarrage ###

La première méthode est la plus classique. Elle consiste à créer un script shell dans le dossier */etc/init.d/*, à le rendre exécutable et à régler la séquence d'initialisation pour qu'elle en prenne compte.

J'ai donc créé un fichier */etc/init.d/firewall* que j'ai rendu exécutable par  
<code>#chmod +x /etc/init.d/firewall</code>

J'ai ensuite informé le système qu'il devait l'exécuter aux changements de runlevel (typiquement démarrage et extinction de la machine, mais pas uniquement) avec   
<code>#cd /etc/init.d
#update-rc.d firewall defaults</code>

Ensuite nous avons encore 2 choix :
-# placer directement les règles iptables dans le fichier */etc/init.d/firewall*
-# placer les règles dans un fichier de config qui sera utilisée par le script */etc/init.d/firewall*

J'ai préféré la seconde option, plus "propre" à mon avis. Voyons donc ce qu'il y a dans notre fichier */etc/init.d/firewall* :  
<code>#!/bin/sh
#

ruleset_dir=/var/lib/iptables

case "$1" in
start)
echo -n "Loading iptables active ruleset: "
/sbin/iptables-restore < $ruleset_dir/active
echo "done."
;;
stop)
echo -n "Loading iptables inactive ruleset: "
/sbin/iptables-restore < $ruleset_dir/inactive
echo "done."
;;
force-reload|restart)
$0 stop
sleep 1
$0 start
;;
save)
echo -n "Saving iptables ruleset: "
cp $ruleset_dir/active $ruleset_dir/active-$(date +%Y%m%d_%H%M)
/sbin/iptables-save > $ruleset_dir/active
echo "done."
;;
*)
echo "Usage: /etc/init.d/iptables *start|stop|restart|force-reload*"
exit 1
esac

exit 0</code>

On a donc un script qui permet de charger/décharger les règles avec les options **start** et **stop** utilisées automatiquement, mais il peut aussi accepter d'être rechargé avec les options **restart** ou **force-reload**.  
Enfin, il permet de sauvegarder la configuration des règles courantes, avec l'option **save**, très utile quand on a testé des règles via la ligne de commande et qu'on souhaite les rendre persistantes.

Il reste donc à mettre en place les fichiers de stockage des règles.

Par défaut le dossier */var/lib/iptables* n'existe pas, nous allons le créer, ainsi que les fichiers vierges :  
<code>#mkdir -p /var/lib/iptables
#cd /var/lib/iptables
#touch active
#touch inactive</code>

Nous pouvons donc lancer une première fois la sauvegarde des règles courantes (s'il y en a) :  
<code>#/etc/init.d/firewall save</code>  
Le fichier vide */var/lib/iptables/active* est renommé avec la date du jour et un nouveau fichier est créé avec les règles courantes.

### Précautions ###
Comme pour tous les scripts d'init, il est nécessaire que */etc/init.d/firewall* soit la propriété de *root* et qu'il soit le seul à pouvoir le modifier.  
Il est également conseillé que les fichiers */var/lib/iptables/** soit aussi protégés contre des modifications par des utilisateurs non administrateurs.

### Conclusions ###
Il reste donc à apprendre à se servir des règles **iptables** pour gérer le firewall, le NAT, … pour cela un article très intéressant (en français) est disponible sur le site de **Christian Caleca** : [christian.caleca.free.fr](http://christian.caleca.free.fr/netfilter/iptables.htm)

En vous amusant avec **iptables**, méfiez vous car vous pouvez totalement bloquer l'accès à la machine depuis l'extérieur (y compris *ssh* et autre), donc gardez un accès physique (clavier/souris direct) à votre machine au cas où.