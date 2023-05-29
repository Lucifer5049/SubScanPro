# SubScanPro

SubScanPro is a comprehensive security assessment tool designed to automate various tasks related to subdomain enumeration, vulnerability scanning, and information gathering. It leverages a combination of open-source tools to perform these tasks efficiently.

## Features

- Subdomain enumeration using sublist3r
- Subdomain takeover checks using subjack
- JS file analysis for secrets using jsscanner
- Port scanning using nmap
- Subdomain live check using curl
- Parameter enumeration using waybackurls, gau, and theharvester
- XSS checks using kxss and dalfox
- SQLi checks using Ghauri and SQLMap
- Old domain information gathering using whois
- Sensitive information search in files using grep
- Running Nuclei for further scanning

**##Requirements**
The following tools and dependencies are required to run SubScanPro:

Python 3.x
sublist3r
subjack
jsscanner
nmap
curl
kxss
dalfox
Ghauri
SQLMap
waybackurls
gau
theharvester
grep
whois
nuclei
Please make sure these tools are installed and accessible in your system before running SubScanPro.

## Usage

Usage
Navigate to the SubScanPro directory:
   cd subscanpro
Run the SubScanPro script:
   chmod +x SubScanPro.sh and ./SubScanPro
Follow the prompts and select the tools you want to run.

Disclaimer
Please note that this tool should be used responsibly and only with proper authorization. Unauthorized use of this tool may be a violation of local, state, or federal laws. The tool author and contributors are not responsible for any illegal or unethical usage.

Contributing
Contributions are welcome! If you have any improvements or new features to add, feel free to fork the repository and submit a pull request.

