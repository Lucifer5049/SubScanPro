# SubScanPro

SubScanPro is a comprehensive security assessment tool designed to automate various tasks related to subdomain enumeration, vulnerability scanning, and information gathering. It leverages a combination of open-source tools to perform these tasks efficiently.

## Features

- Enumerate subdomains associated with a target domain.
- Check for subdomain takeover vulnerabilities.
- Enumerate JavaScript files and search for potential secrets.
- Find the most common web ports on subdomains.
- Check the availability of subdomains.
- Enumerate parameters for all subdomains.
- Perform XSS and SQLi tests on subdomains.
- Gather information on old or expired domains associated with the target.
- Search for sensitive information from old domains.
- Run Nuclei to perform predefined security checks.

## Prerequisites

- Python 3.x
- Required dependencies (mentioned in the script)
- Installed and configured command-line tools (sublist3r, subjack, jsscanner, nmap, theharvester, xss-strike, sqlmap, nuclei)

## Usage

1. Clone the repository:
   git clone https://github.com/Lucifer5049/SubScanPro.git
2. Install the required dependencies:
   pip install -r requirements.txt
   Modify the script to customize the tool's behavior based on your requirements.
3. Run the script:
   python3 SubScanPro.py

Disclaimer
Please note that this tool should be used responsibly and only with proper authorization. Unauthorized use of this tool may be a violation of local, state, or federal laws. The tool author and contributors are not responsible for any illegal or unethical usage.

Contributing
Contributions are welcome! If you have any improvements or new features to add, feel free to fork the repository and submit a pull request.

