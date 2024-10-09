source Honeypot.sh 
source networkMonitoring.sh

# Main function menu
read -p "wich one option 1) Local dir Honeypot 2) Network Monitoring" $op
case $op in 
    1) honeypot;;
    2) mainNetworkMonitoring;;
esac 
