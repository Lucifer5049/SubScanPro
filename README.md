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

## Requirements
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

## Installation

1. Clone the SubScanPro repository:

git clone https://github.com/SubScanPro/SubScanPro.git

2. Install the required dependencies:

chmod +x install.sh & ./install.sh


## Usage

1. Navigate to the SubScanPro directory:

cd SubScanPro

2. Run the subscanpro.sh script:
chmod +x SubScanPro.sh
./SubScanPro.sh

3. Follow the on-screen prompts to select the desired options and provide the target domain.

## Disclaimer

SubScanPro is a tool meant for authorized and legal use only. You are solely responsible for your actions and usage of this tool. The developers and contributors of SubScanPro are not responsible for any misuse or illegal activities performed with this tool.

## License

This project is licensed under the [MIT License](LICENSE).

## Credits

SubScanPro was developed by M4rv3L.


