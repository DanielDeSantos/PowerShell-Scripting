$VMName = Read-Host "NuevaVM"
$VMPath = "$Env:USERPROFILE\VirtualBox VMs\$VMName"

VBoxManage createvm --name $VMName --register *> $null

VBoxManage modifyvm $VMName --memory 2048 --cpus 2 --os-type "Windows10_64" *> $null

VBoxManage createmedium disk --filename "$VMPath\$VMName.vdi" --size 20480 --format VDI --variant Standard *> $null

VBoxManage storagectl $VMName --name "USB" --add usb --controller usb *> $null
VBoxManage storageattach $VMName --storagectl "USB" --port 0 --device 0 --type hdd --medium "$VMPath\$VMName.vdi" *> $null

if (-Not (Test-Path -Path $VMPath)) {
    New-Item -ItemType Directory -Path $VMPath
}

VBoxManage modifyvm $VMName --nic1 nat *> $null

for ($i = 2; $i -le 8; $i++) {
    VBoxManage modifyvm $VMName --nic$i intnet *> $null
}

Write-Host "La máquina virtual $VMName se ha creado con 8 tarjetas de red."