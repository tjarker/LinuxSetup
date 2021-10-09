SHELL := /bin/bash

none:
	@echo 'Select one of the setup make targets'


# ---------------------------------------------------------------------------------------------------------------
# Visual Studio Code
# ---------------------------------------------------------------------------------------------------------------
vscode:
	sudo apt install -y code
	code --install-extension Equinusocio.vsc-community-material-theme
	\code --install-extension yzhang.markdown-all-in-one










# ---------------------------------------------------------------------------------------------------------------
# F#
# ---------------------------------------------------------------------------------------------------------------
fsharp:
	# add Microsoft package signing key 
	wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	rm packages-microsoft-prod.deb
	# install the .net core sdk
	sudo apt-get update; \
	sudo apt-get install -y apt-transport-https && \
	sudo apt-get update && \
	sudo apt-get install -y dotnet-sdk-5.0 fsharp
	# install vscode extensions
	code --install-extension Ionide.Ionide-fsharp
	code --install-extension ms-dotnettools.csharp
	code --install-extension ms-dotnettools.dotnet-interactive-vscode










# ---------------------------------------------------------------------------------------------------------------
# Chisel
# ---------------------------------------------------------------------------------------------------------------
chisel:
	curl -s "https://get.sdkman.io" | bash
	source "$$HOME/.sdkman/bin/sdkman-init.sh" && \
	sdk install java 8.0.282.hs-adpt && \
	sdk install sbt 
	sudo apt install -y flatpak
	flatpak install com.jetbrains.IntelliJ-IDEA-Community -y
	echo -e '\n\nThe scala plugin still needs to be installed inside Intellij!\n\n'










# ---------------------------------------------------------------------------------------------------------------
# Xilinx Vivado
# ---------------------------------------------------------------------------------------------------------------
VIVADO_DIR := /opt/ext/Xilinx/Vivado/2020.2

vivado:
	# install additional dependencies
	sudo apt install -y \
		libstdc++6:i386 \
		libgtk2.0-0:i386 \
		dpkg-dev:i386 \
		libtinfo5 libncurses5
	# take ownership of the install directory
	#sudo chown -R $$USER $(VIVADO_DIR)
	# add user to dialout group to allow access to usb devices
	sudo adduser $$USER dialout
	# install vivado cable drivers
	cd $(VIVADO_DIR)/data/xicom/cable_drivers/lin64/install_script/install_drivers/ && sudo ./install_drivers
	# add vivado bin directory to path
	grep Vivado $$HOME/.profile && @echo "Vivado is already added to path" ||\
		echo -e 'export PATH="$(VIVADO_DIR)/bin/:$$PATH"' >> $$HOME/.profile
	# create a shortcut
	cd /usr/share/applications/ && sudo touch vivado.desktop && echo -e "\
#!/usr/bin/env xdg-open\n\
[Desktop Entry]\n\
Type=Application\n\
Icon=$(VIVADO_DIR)/doc/images/vivado_logo.ico\n\
Name=Vivado\n\
Exec=bash -c \"mkdir -p $$HOME/.vivado && cd $$HOME/.vivado && $(VIVADO_DIR)/bin/vivado && rm -r $$HOME/.vivado && rm $$HOME/vivado_pid*\"\n\
Categories=Development;\n\
" | sudo tee vivado.desktop










# ---------------------------------------------------------------------------------------------------------------
# draw.io
# ---------------------------------------------------------------------------------------------------------------
drawio:
	sudo apt update
	sudo apt -y install wget
	wget https://github.com/jgraph/drawio-desktop/releases/download/v15.4.0/drawio-amd64-15.4.0.deb
	sudo dpkg -i drawio-amd64-15.4.0.deb
	sudo apt -y -f install
	rm drawio-amd64-15.4.0.deb










# ---------------------------------------------------------------------------------------------------------------
# Onedrive
# ---------------------------------------------------------------------------------------------------------------
onedrive:
	sudo apt install -y onedrive
	onedrive
	gedit ~/.config/onedrive/sync_list
	systemctl --user enable onedrive
	systemctl --user start onedrive
	journalctl --user-unit onedrive -f

onedrive_monitor:
	journalctl --user-unit onedrive -f

onedrive_sync:
	onedrive --synchronize









# ---------------------------------------------------------------------------------------------------------------
# Matlab
# ---------------------------------------------------------------------------------------------------------------
MATLAB_DIR := /opt/matlab/2020A

matlab:
	# add matlab bin directory to path
	grep matlab $$HOME/.profile && echo "Matlab is already added to path" ||\
		echo -e 'export PATH="$(MATLAB_DIR)/bin/:$$PATH"' >> $$HOME/.profile
	# create a shortcut
	cd /usr/share/applications/ && sudo touch matlab.desktop && echo -e "\
#!/usr/bin/env xdg-open\n\
[Desktop Entry]\n\
Type=Application\n\
Icon=/usr/share/icons/matlab.png\n\
Name=Matlab\n\
Exec=/opt/matlab/R2021a/bin/matlab -desktop -prefersoftwareopengl\n\
Categories=Development;\n\
" | sudo tee vivado.desktop