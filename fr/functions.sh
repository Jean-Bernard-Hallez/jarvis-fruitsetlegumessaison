# /bin/bash

# *FRUIT*SAISON*==jv_pg_fruits_saison
# *LEGUME*SAISON*==jv_pg_legumes_saison
# *QUEL*SAISON*==jv_pg_quel_saison

jv_pg_fruits_saison() {
chemin=${PWD}"/plugins_installed/jarvis-fruitsetlegumessaison/fruitslegumes.txt"
onest_saison_now=`date +%B`
ligne_num_fruitslegumes=`grep -i "$onest_saison_now - FRUITS" $chemin | sed -e "s/$onest_saison_now - FRUITS: //g"`
ligne_num_fruitslegumes_max=`echo "$ligne_num_fruitslegumes" | wc -c`
ligne_num_fruitslegumes_max1=`echo "$ligne_num_fruitslegumes" | grep -n ',' | wc -w`
ligne_num_fruitslegumes="Voici les $ligne_num_fruitslegumes_max1 fruits de saison du mois de $onest_saison_now: $ligne_num_fruitslegumes"
if [[ "$ligne_num_fruitslegumes_max" -gt "150" ]]; then 
ligne_num_fruitslegumes_2=$(( $ligne_num_fruitslegumes_max1 / 2 ))
ligne_num_fruitslegumes1=`echo "$ligne_num_fruitslegumes" | cut -d"," -f1-$ligne_num_fruitslegumes_2`
ligne_num_fruitslegumes2=`echo "$ligne_num_fruitslegumes" | cut -d"," -f$(( $ligne_num_fruitslegumes_2 + 1 ))-`
say "$ligne_num_fruitslegumes1"
say "$ligne_num_fruitslegumes2"
else
say "$ligne_num_fruitslegumes"
fi

}

jv_pg_legumes_saison() {
chemin=${PWD}"/plugins_installed/jarvis-fruitsetlegumessaison/fruitslegumes.txt"
onest_saison_now=`date +%B`
ligne_num_fruitslegumes=`grep -i "$onest_saison_now - LÉGUMES" $chemin | sed -e "s/$onest_saison_now - LÉGUMES: //g"`
ligne_num_fruitslegumes_max=`echo "$ligne_num_fruitslegumes" | wc -c`
ligne_num_fruitslegumes_max1=`echo "$ligne_num_fruitslegumes" | grep -n ',' | wc -w`
ligne_num_fruitslegumes="Voici les $ligne_num_fruitslegumes_max1 légumes de saison du mois de $onest_saison_now: $ligne_num_fruitslegumes"
if [[ "$ligne_num_fruitslegumes_max" -gt "150" ]]; then 
ligne_num_fruitslegumes_2=$(( $ligne_num_fruitslegumes_max1 / 2 ))
ligne_num_fruitslegumes1=`echo "$ligne_num_fruitslegumes" | cut -d"," -f1-$ligne_num_fruitslegumes_2`
ligne_num_fruitslegumes2=`echo "$ligne_num_fruitslegumes" | cut -d"," -f$(( $ligne_num_fruitslegumes_2 + 1 ))-`
say "$ligne_num_fruitslegumes1"
say "$ligne_num_fruitslegumes2"
else
say "$ligne_num_fruitslegumes"
fi
}

jv_pg_quel_saison() {
chemin=${PWD}"/plugins_installed/jarvis-fruitsetlegumessaison/fruitslegumes.txt"
chemin=${PWD}"/plugins_installed/jarvis-fruitsetlegumessaison/fruitslegumes.txt"
order_fruitslegumes=`echo $order | sed 's/.* //'`
order_fruitslegumes_S_P=`echo $order_fruitslegumes | tail -c 2`
if [[ "$order_fruitslegumes_S_P" == "s" ]]; then
order_fruitslegumes=`echo $order | sed 's/.* //' | sed "s/.$//"`
fi
order_fruitslegumes="$order_fruitslegumes,"
ligne_num_fruitslegumes_total=`grep -i -n $order_fruitslegumes $chemin | cut -d" " -f1 | wc -w`

ligne_num_fruitslegumes_total1="1"
fruitslegumes_ok=""
if [[ "$ligne_num_fruitslegumes_total" == "0" ]]; then 
say "désolé, je n'ai touvé aucun mois correspondants à $order"
return
fi
regarde_traitement_fruitslegumes

if [[ "$ligne_num_fruitslegumes_total" == "12" ]]; then 
say "On trouve toute l'année $order"
return
fi

fruitslegumes_ok=`echo $fruitslegumes_ok | sed "s/.$//"`
fruitslegumes_ok="$fruitslegumes_ok."

order_fruitslegumes=`echo $order | sed 's/.* //' | sed "s/.$//"`

if [[ "$ligne_num_fruitslegumes_total" == "1" ]]; then 
say "Le mois que j'ai trouvé pour $order_fruitslegumes est en: $fruitslegumes_ok"
else
say "Voici les $ligne_num_fruitslegumes_total mois que j'ai trouvé pour $order_fruitslegumes: $fruitslegumes_ok"
fi
}

regarde_traitement_fruitslegumes() {
if [[ "$ligne_num_fruitslegumes_total1" -lt "$(( $ligne_num_fruitslegumes_total + 1 ))" ]]; then
# ligne_num_fruitslegumes=`grep -i $symptome_fruitslegumes $chemin | cut -d: -f1 | sed -n $ligne_num_fruitslegumes_total1\p | cut -d"-" -f1`
ligne_num_fruitslegumes=`grep -i "$order_fruitslegumes" $chemin | cut -d" " -f1 | sed -n $ligne_num_fruitslegumes_total1\p`

if [[ "$jv_pg_fruitslegumesSMS" == "" ]]; then 
fruitslegumes_ok="$fruitslegumes_ok $ligne_num_fruitslegumes,"
fi

ligne_num_fruitslegumes_total1=$(( $ligne_num_fruitslegumes_total1 + 1 ))
regarde_traitement_fruitslegumes
fi

}