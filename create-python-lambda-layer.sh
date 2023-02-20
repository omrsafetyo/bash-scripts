#!/bin/bash
package_name=("$@")
dynamic_folders=("python3.7" "python3.8" "python3.9")
mkdir -p "./$package_name/python/lib"

install_packages=0
FILE=./requirements.txt
if [ -f "$FILE" ]; then
  echo "$FILE exists."
  mv $FILE $package_name/.
  cd $package_name
  install_packages=1
fi

for dynamic_name in "${dynamic_folders[@]}"
do
  # Create the subfolder tree under the parent folder
  mkdir -p "python/lib/$dynamic_name/site-packages"
  if [[ install_packages -eq 1 ]]; then
    echo "Installing packages from requirements.txt"
    $dynamic_name -m pip install -r requirements.txt --target ./python/lib/$dynamic_name/site-packages
  else
    echo "requirements.txt not present"
  fi
done
