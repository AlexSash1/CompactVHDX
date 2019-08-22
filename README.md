# vmlinux-deflater

this case - guest VM linux that have many write and delete, as example - swap file

before full backup VM i run this script, that write big file(whole free filesystem) and then remove it

this may reduse full backup because all free space on VM contain zeroes  

in my case 401Gb backup file was "deflated" to 293Gb =) maybe you will obtain more



new case


[CmdletBinding()]
Param(
    $VMnames
)

foreach($VMname in $VMnames){
    #Check if VM is running
    Write-Verbose "Checking $VMname"
    if((Get-VM -Name $VMname).State -eq "off" -and (Get-VM -Name $VMname).ParentCheckpointId -eq $null){
    
    #Find the disks
    foreach($VHD in ((Get-VMHardDiskDrive -VMName $VMname).Path)){
        Write-Verbose "Working on $VHD, please wait"
        Write-Verbose "Current size $([math]::truncate($(Get-VHD -Path $VHD).FileSize/ 1GB)) GB"
        Mount-VHD -Path $VHD -NoDriveLetter -ReadOnly
        Optimize-VHD -Path $VHD -Mode Full
        Write-Verbose "Optimize size $([math]::truncate($(Get-VHD -Path $VHD).FileSize/ 1GB)) GB"
        Dismount-VHD -Path $VHD
        Write-Verbose ""
        }
    }
    else{Write-Warning "$VMname is not turned off or has a snapshot, will not be fixed"
    Write-Verbose ""}
}


The command is 
OptimiseVHDX.ps1 -VMnames "Server Name" -verbose

So my output is pretty
PS C:\temp> .\OptimiseVHDX.ps1 -VMnames "Server Name" -verbose
VERBOSE: Checking Server Name
VERBOSE: Working on V:\Hyper-V\Virtual Hard Disks\Server Name C Drive.vhdx, please wait
VERBOSE: Current size 96 GB
VERBOSE: Optimize size 94 GB
VERBOSE:
