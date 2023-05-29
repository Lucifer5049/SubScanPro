#!/bin/bash

echo "SubScanPro - Automation Tool"
echo "Written by M4rv3L"

# Create requirements.txt file
echo "sublist3r" > requirements.txt
echo "subjack" >> requirements.txt
echo "jsscanner" >> requirements.txt
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

# Installation function with error handling
install_tool() {
    tool_name=$1
    echo "Installing $tool_name..."
    if ! eval "$2"; then
        echo "Error: Failed to install $tool_name."
        echo "Please manually install $tool_name and rerun the script."
        exit 1
    fi
    echo "$tool_name installed successfully."
    echo
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
            install_tool "subjack" "go get github.com/haccer/subjack && go install github.com/haccer/subjack"
            ;;
        jsscanner)
            install_tool "jsscanner" "pip install jsscanner"
            ;;
        nmap)
            install_tool "nmap" "sudo apt-get install nmap"  # Update with OS-specific package manager command if required
            ;;
        curl)
            install_tool "curl" "sudo apt-get install curl"  # Update with OS-specific package manager command if required
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
            install_tool "grep" "sudo apt-get install grep"  # Update with OS-specific package manager command if required
            ;;
        whois)
            install_tool "whois" "sudo apt-get install whois"  # Update with OS-specific package manager command if required
            ;;
        nuclei)
            install_tool "nuclei" "go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei && go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei"
            ;;
        *)
            echo "Error: Unknown tool '$tool' in requirements.txt"
            echo "Please manually install the required tools and rerun the script."
            exit 1
            ;;
    esac
done < requirements.txt
echo "SubScanPro Requirements installation completed successfully!"
echo "You can now navigate to the 'subscanpro' directory and run the tool using './SubScanPro.sh'."
