#!/bin/bash
# -----------------------------------------------------------------------
# Alvar Soler alvardsoler@gmail.com
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details

# Description:
# Script para guardar la dirección IP pública de una máquina en un fichero
# para después subirlo a DropBox utilizando dropbox_uploader 
# (https://github.com/andreafabrizi/Dropbox-Uploader)

PATH_FILE=~;
# Ruta del fichero donde se va a guardar la ip
OLD_IP_FILE="${PATH_FILE}/.ip.tmp";
NEW_IP_FILE="${PATH_FILE}/.ip";

NEW_IP="$(curl ipinfo.io/ip)"
./dropbox_uploader.sh download /raspi/ip "${OLD_IP_FILE}";
OLD_IP="$(cat $OLD_IP_FILE)";

# Solo se hace la subida si la ip ha cambiado
if [ "$NEW_IP" != "$OLD_IP" ]; then
	echo "$NEW_IP" | tee "$NEW_IP_FILE"
	./dropbox_uploader.sh upload .ip /raspi/ip
	rm "$OLD_IP_FILE";
fi
