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
echo "jsscanner" >> requirements.txt
echo "nmap" >> requirements.txt
echo "theharvester" >> requirements.txt
echo "kxss" >> requirements.txt
echo "dalfox" >> requirements.txt
echo "ghauri" >> requirements.txt
echo "sqlmap" >> requirements.txt
echo "waybackurls" >> requirements.txt
echo "gau" >> requirements.txt
echo "nuclei" >> requirements.txt

# Prompt user for options
echo "Please select the tools you want to run:"
echo "1. Subdomain Enumeration"
echo "2. Subdomain Takeover Check"
echo "3. JS File Analysis"
echo "4. Port Scanning"
echo "5. Subdomain Live Check"
echo "6. Parameter Enumeration"
echo "7. XSS Check"
echo "8. SQLi Check"
echo "9. Old Domains Information Gathering"
echo "10. Sensitive Information Search"
echo "11. Run Nuclei"
echo "12. All Tools"

read -p "Enter your choice (1-12): " choice
echo

# Run selected tools based on user's choice
case $choice in
  1)
    echo "Running Subdomain Enumeration..."
    sublist3r -d "$target" -o "$output_dir/subdomains.txt"
    echo "Subdomain Enumeration completed!"
    echo
    ;;
  2)
    echo "Running Subdomain Takeover Check..."
    subjack -w "$output_dir/subdomains.txt" -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v -o "$output_dir/takeover.txt"
    echo "Subdomain Takeover Check completed!"
    echo
    ;;
  3)
    echo "Running JS File Analysis..."
    jsscanner -i "$output_dir/subdomains.txt" -o "$output_dir/js_files.txt"
    grep -E "(password|api_key|secret)" "$output_dir/js_files.txt" > "$output_dir/secrets.txt"
    echo "JS File Analysis completed!"
    echo
    ;;
  4)
    echo "Running Port Scanning..."
    nmap -iL "$output_dir/subdomains.txt" -p 80,443,8080,8443 -oN "$output_dir/port_scan.txt"
    echo "Port Scanning completed!"
    echo
    ;;
  5)
    echo "Running Subdomain Live Check..."
    while IFS= read -r domain; do
      if curl --output /dev/null --silent --head --fail "$domain"; then
        echo "$domain is live"
      else
        echo "$domain is not live"
      fi
    done < "$output_dir/subdomains.txt"
    echo "Subdomain Live Check completed!"
    echo
    ;;
  6)
    echo "Running Parameter Enumeration..."
    waybackurls "$target" | tee "$output_dir/waybackurls.txt"
    gau "$target" | tee -a "$output_dir/waybackurls.txt"
    theharvester -d "$target" -b all -f "$output_dir/parameters.txt"
    echo "Parameter Enumeration completed!"
    echo
    ;;
  7)
    echo "Running XSS Check..."
    echo "Running kxss..."
    kxss -i "$output_dir/subdomains.txt" -o "$output_dir/xss_results.txt"
    echo "kxss completed!"

    echo "Running dalfox..."
    dalfox -b hahwul.xss.ht file "$output_dir/xss_results.txt"
    echo "dalfox completed!"

    echo "XSS Check completed!"
    echo
    ;;
  8)
    echo "Running SQLi Check..."
    echo "Running Ghauri..."
    ghauri -u "$output_dir/subdomains.txt" -o "$output_dir/sqli_results.txt"
    echo "Ghauri completed!"

    echo "Running SQLMap..."
    sqlmap -m "$output_dir/subdomains.txt" --batch --output-dir "$output_dir/sqlmap_results"
    echo "SQLMap completed!"

    echo "SQLi Check completed!"
    echo
    ;;
  9)
    echo "Running Old Domains Information Gathering..."
    whois "$target" > "$output_dir/whois_info.txt"
    echo "Old Domains Information Gathering completed!"
    echo
    ;;
  10)
    echo "Running Sensitive Information Search..."
    grep -rE "(password|api_key|secret)" . > "$output_dir/sensitive_info.txt"
    echo "Sensitive Information Search completed!"
    echo
    ;;
  11)
    echo "Running Nuclei..."
    nuclei -l "$output_dir/subdomains.txt" -t ~/nuclei-templates/ -o "$output_dir/nuclei_results.txt"
    echo "Nuclei completed!"
    echo
    ;;
  12)
    echo "Running All Tools..."
    echo

    echo "Running Subdomain Enumeration..."
    sublist3r -d "$target" -o "$output_dir/subdomains.txt"
    echo "Subdomain Enumeration completed!"
    echo

    echo "Running Subdomain Takeover Check..."
    subjack -w "$output_dir/subdomains.txt" -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v -o "$output_dir/takeover.txt"
    echo "Subdomain Takeover Check completed!"
    echo

    echo "Running JS File Analysis..."
    jsscanner -i "$output_dir/subdomains.txt" -o "$output_dir/js_files.txt"
    grep -E "(password|api_key|secret)" "$output_dir/js_files.txt" > "$output_dir/secrets.txt"
    echo "JS File Analysis completed!"
    echo

    echo "Running Port Scanning..."
    nmap -iL "$output_dir/subdomains.txt" -p 80,443,8080,8443 -oN "$output_dir/port_scan.txt"
    echo "Port Scanning completed!"
    echo

    echo "Running Subdomain Live Check..."
    while IFS= read -r domain; do
      if curl --output /dev/null --silent --head --fail "$domain"; then
        echo "$domain is live"
      else
        echo "$domain is not live"
      fi
    done < "$output_dir/subdomains.txt"
    echo "Subdomain Live Check completed!"
    echo

    echo "Running Parameter Enumeration..."
    waybackurls "$target" | tee "$output_dir/waybackurls.txt"
    gau "$target" | tee -a "$output_dir/waybackurls.txt"
    theharvester -d "$target" -b all -f "$output_dir/parameters.txt"
    echo "Parameter Enumeration completed!"
    echo

    echo "Running XSS Check..."
    echo "Running kxss..."
    kxss -i "$output_dir/subdomains.txt" -o "$output_dir/xss_results.txt"
    echo "kxss completed!"

    echo "Running dalfox..."
    dalfox -b hahwul.xss.ht file "$output_dir/xss_results.txt"
    echo "dalfox completed!"

    echo "XSS Check completed!"
    echo

    echo "Running SQLi Check..."
    echo "Running Ghauri..."
    ghauri -u "$output_dir/subdomains.txt" -o "$output_dir/sqli_results.txt"
    echo "Ghauri completed!"

    echo "Running SQLMap..."
    sqlmap -m "$output_dir/subdomains.txt" --batch --output-dir "$output_dir/sqlmap_results"
    echo "SQLMap completed!"

    echo "SQLi Check completed!"
    echo

    echo "Running Old Domains Information Gathering..."
    whois "$target" > "$output_dir/whois_info.txt"
    echo "Old Domains Information Gathering completed!"
    echo

    echo "Running Sensitive Information Search..."
    grep -rE "(password|api_key|secret)" . > "$output_dir/sensitive_info.txt"
    echo "Sensitive Information Search completed!"
    echo

    echo "Running Nuclei..."
    nuclei -l "$output_dir/subdomains.txt" -t ~/nuclei-templates/ -o "$output_dir/nuclei_results.txt"
    echo "Nuclei completed!"
    echo
    ;;
  *)
    echo "Invalid choice!"
    ;;
esac
