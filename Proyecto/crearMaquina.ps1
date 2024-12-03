$nombreMaquina = Read-Host "Escribe el nombre de la máquina virtual que qieres crear"
$VMPath = "$Env:USERPROFILE\VirtualBox VMs\$nombreMaquina"

VBoxManage createvm --name $nombreMaquina --register *> $null

VBoxManage modifyvm $nombreMaquina --memory 2048 --cpus 2 --os-type "Windows10_64" *> $null

VBoxManage createmedium disk --filename "$VMPath\$nombreMaquina.vdi" --size 20480 --format VDI --variant Standard *> $null

VBoxManage modifyvm $nombreMaquina --usb on --usbehci on
VBoxManage storagectl $nombreMaquina --name "USB" --add usb --controller usb *> $null
VBoxManage storageattach $nombreMaquina --storagectl "USB" --port 0 --device 0 --type hdd --medium "$VMPath\$nombreMaquina.vdi" *> $null

if (-Not (Test-Path -Path $VMPath)) {
    New-Item -ItemType Directory -Path $VMPath
}

VBoxManage modifyvm $nombreMaquina --nic1 nat *> $null

for ($i = 2; $i -le 8; $i++) {
    VBoxManage modifyvm $nombreMaquina --nic$i intnet *> $null
}

Write-Host "La máquina virtual $nombreMaquina se ha creado con 8 tarjetas de red."
