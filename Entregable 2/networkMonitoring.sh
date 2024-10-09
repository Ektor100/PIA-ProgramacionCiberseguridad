#!/bin/bash

echo "ADVERTENCIA: El programa le solicitara entrar en modo root para instalar herramientas que falten o ejecutarlas"


         mainNetworkMonitoring(){

    # Function for missing tools
    if ! command -v tcpdump &> /dev/null; then
        echo "tcpdump no esta instalado. Comenzando instalacion..."
        sudo apt update && sudo apt install -y tcpdump
        if [[ $? -eq 0 ]]; then
            echo "tcpdump se ha instalado correctamente."
        else
            echo "Error al instalar tcpdump. Finalizando script."
            exit 1
        fi
    else
        echo "tcpdump ya esta instalado."
    fi



    # Function to show network interfaces
    echo "Interfaces de red:"
    ip link show | awk -F: '/^[0-9]+: [^lo]/ {print $2}' | tr -d ' '

    while true; do
        echo "Ingrese el nombre de la interfaz de red:"
        read networkInterface

        if ip link show "$networkInterface" &> /dev/null; then
            echo "Has seleccionado la interfaz: $networkInterface"
            break
        else
            echo "Interfaz invalida. Intentelo de nuevo."
        fi
    done





    # Function to monitor network traffic with tcpdump
    echo "Iniciando monitoreo de trafico en la interfaz: $networkInterface"
    echo "Mostrando el trafico en tiempo real durante 30 segundos para que puedas observarlo."


    outputDir="./logs"
    mkdir -p "$outputDir"
    timestamp=$(date +"%Y%m%d_%H%M%S")
    outputFile="$outputDir/monitoreo_$timestamp.txt"

    sudo timeout 30 tcpdump -i "$networkInterface" -n -s 0 -vv | awk '
    BEGIN {
        printf "%-20s %-7s %-25s %-25s\n", "Timestamp", "Proto", "Source", "Destination"
        printf "%-20s %-7s %-25s %-25s\n", "-------------------", "-----", "----------------------", "----------------------"
    }
    {
        timestamp = $1
        proto = $2
        source = $3
        destination = $5

        printf "%-20s %-7s %-25s %-25s\n", timestamp, proto, source, destination
    }' | tee "$outputFile"

    echo -e "\nMonitoreo detenido. Los resultados se han guardado en: $outputFile"
}
