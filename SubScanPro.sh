#!/bin/bash
echo "SubScanPro - Automation Tool"
echo "Written by M4rv3L"
echo

# Prompt user for target choice
echo "Please choose an option:"
echo "1. Perform subdomain enumeration"
echo "2. Scan a single target URL"
read -p "Enter your choice (1 or 2): " choice
echo

# Create output directory
output_dir="subscanpro_output"
mkdir -p "$output_dir"

# Perform subdomain enumeration
perform_subdomain_enum() {
    echo "Performing subdomain enumeration..."
    read -p "Enter the target domain: " target_domain
    echo

    # Use sublist3r for subdomain enumeration
    echo "Running sublist3r..."
    sublist3r -d "$target_domain" -o "$output_dir/subdomains.txt" 2>/dev/null
    echo "Subdomain enumeration completed. Results saved in $output_dir/subdomains.txt."
    echo
}

# Perform scan on a single target URL
perform_single_scan() {
    read -p "Enter the target URL: " target_url
    echo

    # Individual tool options
    options=("JS File Secrets" "Port Scanning" "Subdomain Live Check" "Parameter Enumeration" "XSS Check" "SQLi Check")

    PS3="Select an option: "
    select option in "${options[@]}"; do
        case $option in
            "JS File Secrets")
                echo "Running jsscanner..."
                jsscanner "$target_url" | tee "$output_dir/jsscanner.txt" 2>/dev/null
                echo "JS file analysis completed. Results saved in $output_dir/jsscanner.txt."
                break
                ;;
            "Port Scanning")
                echo "Running nmap..."
                nmap -p 1-1000 "$target_url" | tee "$output_dir/port_scan.txt" 2>/dev/null
                echo "Port scanning completed. Results saved in $output_dir/port_scan.txt."
                break
                ;;
            "Subdomain Live Check")
                echo "Running curl..."
                if curl -sSL "$target_url" -o /dev/null; then
                    echo "Target URL is live."
                else
                    echo "Target URL is not live."
                fi
                break
                ;;
            "Parameter Enumeration")
                echo "Running waybackurls..."
                waybackurls "$target_url" | tee "$output_dir/waybackurls.txt" 2>/dev/null
                echo "Running gau..."
                gau "$target_url" | tee -a "$output_dir/waybackurls.txt" 2>/dev/null
                echo "Running theharvester..."
                theharvester -d "$target_url" -b all | tee -a "$output_dir/waybackurls.txt" 2>/dev/null
                echo "Parameter enumeration completed. Results saved in $output_dir/waybackurls.txt."
                break
                ;;
            "XSS Check")
                echo "Running kxss..."
                kxss "$target_url" | tee "$output_dir/kxss.txt" 2>/dev/null
                echo "Running dalfox..."
                dalfox url "$target_url" | tee -a "$output_dir/kxss.txt" 2>/dev/null
                echo "XSS check completed. Results saved in $output_dir/kxss.txt."
                break
                ;;
            "SQLi Check")
                echo "Running ghauri..."
                ghauri -u "$target_url" | tee "$output_dir/ghauri.txt" 2>/dev/null
                echo "Running sqlmap..."
                sqlmap -u "$target_url" --batch | tee -a "$output_dir/ghauri.txt" 2>/dev/null
                echo "SQLi check completed. Results saved in $output_dir/ghauri.txt."
                break
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done

    echo
}

# Perform subdomain enumeration or single target scan based on user choice
case $choice in
    1)
        perform_subdomain_enum
        ;;
    2)
        perform_single_scan
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

exit 0
