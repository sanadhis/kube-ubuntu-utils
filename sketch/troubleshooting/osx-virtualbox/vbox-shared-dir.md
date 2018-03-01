# Use case
* Virtualbox
* Host OS is Mac OSX
* Guest OS is Ubuntu (linux)
* Want to share directory
* Both can read,write without sudo privilege

# Troubleshooting mac(host) to ubuntu(guest) shared dir problems:
1. Install Virtualbox Extension Pack on host OS
2. Install virtualbox packages in guest OS so it can recognize `vboxsf` filesystem
```bash
sudo apt-get install virtualbox-guest-additions-iso virtualbox-guest-utils
```
3. Share the directory (via GUI in virtualbox): Your VM >> Setttings >> Shared folders
4. In guest OS, add user to vboxsf
```bash
sudo adduser $(whoami) vboxsf
```
5. In guest OS, mount
```bash
sudo mount -t vboxsf -o rw,uid=$UID,gid=$UID {{ shared folder name }} {{ desired path for mount }}
```