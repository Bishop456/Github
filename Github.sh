#!/bin/bash

color1="\033[;0;38;5;200m"
color2="\033[;0;38;5;45m"
color3="\033[;0;38;5;4m"
color4="\033[;0;38;5;65m"

usuario="Bishop456"
token=$(cat $HOME/token)
url="https://github.com/Bishop456/"


subir(){
  echo -e -n "$color1 Ingrese nombre del Repositorio : $color2";read nombre

  direccion=$(echo "$url$nombre")
  repo=$(echo $direccion | awk -F '456/' '{print $2}')

  cd $nombre && rm -rf .git
  git init
  git add .
  git commit -m "Commit inicial"
  git remote add origin $direccion 
  git push -u https://$usuario:$token@github.com/$usuario/$repo.git master
} 


listar(){
  echo ""
  echo -e -n "$color3"
  curl -H "Authorization: token $token" https://api.github.com/users/$usuario/repos | grep "full_name" | awk -F '/' '{print $NF}' | awk -F '"' '{print $1}'  
}


crear(){
  echo -e -n "$color1 Ingresa nombre : $color2";read nombre

  curl -H "Authorization: token $token" -d '{"name": "'"$nombre"'"}' https://api.github.com/user/repos
}

eliminar(){
  echo -e -n "$color1 Ingresa el nombre : $color2";read nombre_repositorio

  curl -X DELETE -H "Authorization: token $token" https://api.github.com/repos/$usuario/$nombre_repositorio
}

pagina(){
  echo -e -n "$color1 Ingrese nombre del Repositorio : $color2";read nombre
  curl -X POST -H "Authorization: token $token" -H "Accept: application/vnd.github.switcheroo-preview+json" https://api.github.com/repos/$usuario/$nombre/pages -d '{"source": {"branch": "master", "path": "$nombre", "type": "branch"}}'
}

echo ""
echo -e "$color4 1):Crear  2):Eliminar 3):subir 4):listar 5):pagina \n"
echo -e -n "$color3 Ingresa un número : $color4";read numero
echo ""

case $numero in
  1 ) crear ;;
  2 ) eliminar ;;
  3 ) subir ;;
  4 ) listar ;;
  5 ) pagina ;;
  * ) echo -e "$color3 Ingresa una opcion válida Genio......!!!!" ;;
esac



