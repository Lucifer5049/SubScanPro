#!/bin/bash

echo "SubScanPro - Subdomain Automation Tool"
echo "Written by M4rv3L"
echo

# Prompt user for target domain
read -p "Enter the target domain: " target
echo

# Create output directory
output_dir="subscanpro_output"
mkdir -p "$output_dir"

# Create requirements.txt file
echo "sublist3r" > requirements.txt
echo "subjack" >> requirements.txt
echo "nmap" >> requirements.txt
echo "curl" >> requirements.txt
echo "kxss" >> requirements.txt
echo "dalfox" >> requirements.txt
echo "ghauri" >> requirements.txt
echo "sqlmap" >> requirements.txt
echo "waybackurls" >> requirements.txt
echo "gau" >> requirements.txt
echo "theharvester" >> requirements.txt
echo "grep" >> requirements.txt
echo "whois" >> requirements.txt
echo "nuclei" >> requirements.txt

# Installation function with error handling and alternatives
install_tool() {
    tool_name=$1
    install_command=$2
    echo "Installing $tool_name..."
    eval "$install_command"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install $tool_name."
        echo "Trying alternative installation method..."
        eval "${install_command}_alternative"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install $tool_name using alternative method."
            echo "Please manually install $tool_name and proceed."
            return 1
        fi
    fi
    echo "$tool_name installed successfully."
    echo
    return 0
}

# Install Python 3.x
python_version=$(python3 -V 2>&1 | awk '{print $2}')
if [[ $python_version =~ ^3\. ]]; then
    echo "Python 3.x is already installed."
else
    echo "Python 3.x is not installed. Please install it manually and rerun the script."
    exit 1
fi
echo

# Install tools from requirements.txt
while IFS= read -r tool; do
    case $tool in
        sublist3r)
            install_tool "sublist3r" "pip install sublist3r"
            ;;
        subjack)
            install_tool "subjack" "go get github.com/haccer/subjack/v2 && go install github.com/haccer/subjack/v2" "go get github.com/haccer/subjack && go install github.com/haccer/subjack"
            ;;
        nmap)
            install_tool "nmap" "sudo apt-get install nmap"
            ;;
        curl)
            install_tool "curl" "sudo apt-get install curl"
            ;;
        kxss)
            install_tool "kxss" "go get github.com/Emoe/kxss && go install github.com/Emoe/kxss"
            ;;
        dalfox)
            install_tool "dalfox" "go get github.com/hahwul/dalfox && go install github.com/hahwul/dalfox"
            ;;
        ghauri)
            install_tool "ghauri" "go get github.com/tikazyq/ghauri && go install github.com/tikazyq/ghauri"
            ;;
        sqlmap)
            install_tool "sqlmap" "pip install sqlmap"
            ;;
        waybackurls)
            install_tool "waybackurls" "go get github.com/tomnomnom/waybackurls && go install github.com/tomnomnom/waybackurls"
            ;;
        gau)
            install_tool "gau" "go get github.com/lc/gau && go install github.com/lc/gau"
            ;;
        theharvester)
            install_tool "theharvester" "git clone https://github.com/laramies/theHarvester.git && cd theHarvester && pip install -r requirements.txt"
            ;;
        grep)
            install_tool "grep" "sudo apt-get install grep"
            ;;
        whois)
            install_tool "whois" "sudo apt-get install whois"
            ;;
        nuclei)
            install_tool "nuclei" "go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei && go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei"
            ;;
        *)
            echo "Error: Unknown tool '$tool' in requirements.txt"
            echo "Please manually install the required tools and proceed."
            ;;
    esac
done < requirements.txt
