import subprocess
import os
import requests

# Define the target domain
target_domain = input("Enter the target domain: ")

# Enumerate subdomains
subdomains = subprocess.check_output(["sublist3r", "-d", target_domain]).decode("utf-8").splitlines()

# Check for subdomain takeover
takeover_vulnerable_subdomains = []
for subdomain in subdomains:
    subdomain_takeover_output = subprocess.check_output(["subjack", "-w", "subdomains.txt", "-t", "100"]).decode("utf-8")
    if "Potential Takeover Detected" in subdomain_takeover_output:
        takeover_vulnerable_subdomains.append(subdomain)

# Enumerate JS files and check for secrets
js_files_with_secrets = []
for subdomain in subdomains:
    js_files_output = subprocess.check_output(["jsscanner", "-u", subdomain]).decode("utf-8").splitlines()
    for js_file in js_files_output:
        # Perform secret detection logic
        if "secret" in js_file:
            js_files_with_secrets.append(js_file)

# Find the most common web ports on subdomains
common_ports = [80, 443, 8080]  # Customize this list based on your requirements
open_ports = []
for subdomain in subdomains:
    for port in common_ports:
        response = os.system("nmap -p {0} {1}".format(port, subdomain))
        if response == 0:
            open_ports.append((subdomain, port))

# Check if subdomains are live
live_subdomains = []
for subdomain in subdomains:
    response = requests.get("http://{0}".format(subdomain))
    if response.status_code < 400:
        live_subdomains.append(subdomain)

# Enumerate parameters for all subdomains
parameters = {}
for subdomain in subdomains:
    parameters_output = subprocess.check_output(["paramspider", "-d", subdomain]).decode("utf-8").splitlines()
    for parameter in parameters_output:
        # Perform parameter processing logic
        if parameter not in parameters:
            parameters[subdomain] = [parameter]
        else:
            parameters[subdomain].append(parameter)

# Check for XSS and SQLi
xss_vulnerable_subdomains = []
sqli_vulnerable_subdomains = []
for subdomain in subdomains:
    xss_output = subprocess.check_output(["xss-strike", "-u", subdomain]).decode("utf-8")
    if "XSS Vulnerability Found" in xss_output:
        xss_vulnerable_subdomains.append(subdomain)

    sqli_output = subprocess.check_output(["sqlmap", "-u", subdomain]).decode("utf-8")
    if "sqlmap identified the following injection points" in sqli_output:
        sqli_vulnerable_subdomains.append(subdomain)

# Gather all old domains
old_domains = subprocess.check_output(["theharvester", "-d", target_domain, "-b", "all"]).decode("utf-8").splitlines()

# Find sensitive information from old domains
sensitive_information = []
for domain in old_domains:
    # Perform sensitive information gathering logic
    sensitive_information.append(domain)

# Run Nuclei over previously gathered data
nuclei_output = subprocess.check_output(["nuclei", "-t", "nuclei-templates", "-l", "subdomains.txt"]).decode("utf-8")

# Print or process the results as needed
print("Subdomains:", subdomains)
print("Subdomain Takeover Vulnerabilities:", takeover_vulnerable_subdomains)
print("JS Files with Secrets:", js_files_with_secrets)
print("Open Ports:", open_ports)
print("Live Subdomains:", live_subdomains)
print("Parameters:", parameters)
print("XSS Vulnerable Subdomains:", xss_vulnerable_subdomains)
print("SQLi Vulnerable Subdomains:", sqli_vulnerable_subdomains)
print("Old Domains:", old_domains)
print("Sensitive Information:", sensitive_information)
print("Nuclei Output:", nuclei_output)