# VMBreaker

![obraz](https://github.com/kerszl/VMBreaker/assets/45152848/cead308e-4e78-474a-9982-e498e3187c61)

**VMBreaker** - specialized tool for breaking into virtual machines, designed by Kerszi/MindCrafters. Aimed at security researchers and educational purposes, VMBreaker offers a streamlined approach to virtual machine penetration testing.

## Overview

**VMBreaker** is not an all-in-one solution but focuses on providing the essential functionalities required for virtual machine security testing and analysis. With an emphasis on simplicity and efficiency, VMBreaker is equipped with a concise set of tools tailored for bypassing virtual machine protections, ensuring a straightforward, user-friendly experience.

## Features

- Dictionaries
- Network discovery
- Port scanning with **nmap**
- Web scanning with **whatweb**
- HTTP Scanning (Directory traversal)
- Vulnerability Search
- Cracking Services
- Hash Cracking
- Steganography tools
- Reverse Shell capabilities

## Disclaimer

**VMBreaker** is primarily designed for educational and research purposes within the context of virtual machine security analysis. It is a powerful tool that can potentially be used to bypass virtual machine protections. However, the creators or distributors assume no responsibility for any damage, loss, or legal consequences that may arise from its misuse. Users are urged to apply **VMBreaker** responsibly and ethically, strictly adhering to all applicable laws and regulations. Unauthorized or malicious activities are strongly discouraged and condemned.

## License

**VMBreaker** is released under the GNU General Public License (GPL), version 3, or (at your option) any later version. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## Installation
```
git clone https://github.com/kerszl/VMBreaker.git
cd VMBreaker
chmod +x install.sh
./install.sh
```
## Tools Used

The project utilizes the following tools:

- [Binwalk](https://github.com/ReFirmLabs/binwalk) - A tool for analyzing and extracting firmware images.
- [Dirsearch](https://github.com/maurosoria/dirsearch) - A web path scanner.
- [ExifTool](https://exiftool.org/) - A library and program to read, write, and edit meta information in files.
- [Feroxbuster](https://github.com/epi052/feroxbuster) - A tool for content discovery on websites.
- [Ffuf (Fuzz Faster U Fool)](https://github.com/ffuf/ffuf) - A fast web fuzzer.
- [File](http://darwinsys.com/file/) - A file type determination tool.
- [Hashcat](https://hashcat.net/hashcat/) - A password recovery tool.
- [Haiti](https://noraj.github.io/haiti/) - A hash type identifier.
- [Hydra](https://github.com/vanhauser-thc/thc-hydra) - A very fast network logon cracker.
- [John the Ripper](https://www.openwall.com/john/) - A password cracker.
- [Nc (Netcat)](http://nc110.sourceforge.net/) - A networking utility for reading from and writing to network connections.
- [Netdiscover](https://github.com/alexxy/netdiscover) - An active/passive address reconnaissance tool.
- [Netexec](https://github.com/Pennyw0rth/NetExec) -  The Network Execution Tool.
- [Nikto](https://github.com/sullo/nikto) - A web server scanner.
- [Nmap](https://nmap.org/) - A network discovery and security auditing tool.
- [Sqlmap](http://sqlmap.org/) - An automatic SQL injection and database takeover tool.
- [Stegoveritas](https://github.com/bannsec/stegoVeritas) - A tool for steganography analysis.
- [Stegseek](https://github.com/RickdeJager/stegseek) - A lightning-fast steghide cracker.
- [Wapiti](https://github.com/IFGHou/wapiti) - A web application vulnerability scanner.
- [WhatWeb](https://github.com/urbanadventurer/WhatWeb) - A web scanner to identify what websites are running.
- [WPScan](https://wpscan.org/) - A WordPress security scanner.
- [Zsteg](https://github.com/zed-0xff/zsteg) - A tool for detecting steganographic content in PNG and BMP files.

## Check installed tools
```
VMBreaker -c

binwalk: installed
dirsearch: installed
exiftool: installed
feroxbuster: installed
ffuf: installed
file: installed
hashcat: installed
haiti: installed
hydra: installed
john: installed
nc: installed
netdiscover: installed
netexec: installed
nikto: installed
nmap: installed
sqlmap: installed
stegoveritas: installed
stegseek: installed
wapiti: installed
whatweb: installed
wpscan: installed
zsteg: installed
```
## Usage

```bash
./VMBreaker.sh [options]
```
## Options
```
-c Show required programs.
-h, --help Show this help message.
-v Show variable exported values.
-vv Display detailed information about exported variable values (verbose mode).
```

## Contributions

Contributions are welcome! Please read the contribution guidelines before submitting a pull request.

## Greetings:

- [HackMyVM](https://hackmyvm.eu/)
- [Sekurak](https://sekurak.pl/) (Special greets for #CTF channel on Discord)
- 大傻子的小圈子

## Contact

For any inquiries, please contact kerszi@protonmail.com



