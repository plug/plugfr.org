--- 
title: Compiler Photon pour iMac Intel
layout: post
categories: divers
---
[_English at the end_](#english)

Depuis longtemps j'utilise **Photon**, un plugin génial pour iPhoto, qui permet de poster directement des photos sur un blog.

Au début Photon, était payant, puis le développeur l'a rendu gratuit, et enfin il l'a totalement abandonné, certainement pour de très bonnes raisons.
Le contenu de son [site web](http://daikini.com/) a disparu, ne restent que les sources et une version compilée de ses softs.

Depuis quelques mois, je possède un iMac Intel dont je suis absolument ravi, seulement je ne peux pas faire marcher la version PPC de Photon, ce qui me frustre énormément parce que j'ai des dizaines de photos de ma petite fille que je voudrais facilement mettre sur [mon blog de photos](http://jimetnina.lecour.fr/photos/).

J'ai donc installé Xcode 2.4 pour tenter de faire ma propre compilation de Photon. Je dois dire tout de suite que c'était la première fois de ma vie que je cliquais sur "Build". Malgré quelques erreurs dues à la compatibilité avec Mac OS X 10.3 (que j'ai supprimée, pour le moment), j'ai obtenu un résultat plus ou moins satisfaisant et presque fonctionnel, mais l'envoi d'images et la création de posts ne fonctionnent pas encore. D'après la Console, je soupçonne l'installation au niveau du serveur (certainement un module Perl manquant, ou quelque chose comme ça).

Si quelqu'un a obtenu une compilation correcte et fonctionnelle sur Mac Intel, je suis preneur du résultat et de la manière de l'obtenir. En effet, je suis très intéressé par le fait d'avoir un Photon fonctionnel, mais en apprendre un peu plus sur le fonctionnement de Xcode ça me botte aussi.

D'ailleurs, je n'ai pas trouvé comment ajouter une traduction de l'interface (dans Interface Builder ou bien dans Xcode ?), donc si quelqu'un le sait, je voudrais bien mettre en pratique.

----

I'm a longtime user of **Photon**, a great iPhoto plugin to easily post photos directly on a blog.The developper has abandonned (for some good reasons, I guess) his software and is giving away Photon and its sources. The package isn't Universal Binary and doesn't work on an intel-based Mac (I own an iMac 20").I've tried to build the sources on my Mac, and finally obtained something quite working (after eliminating the Mac OS X 10.3 compatibility for the moment), but uploading and creating a post didn't work yet. I suspect a problem on the server side, maybe a Perl module issue.

If anyone has a working version of Photon on intel Macs, I'd like to have it and also axplainations on how to make it. I'm a total newbi in Xcode and in software making so anything is a benefit.

Also I'd like to translate the soft in French, but I didn't find where to to this, in Interface Builder or in Xcode. If anyone knows …

Pardon my english, it's not my native language ;-)
