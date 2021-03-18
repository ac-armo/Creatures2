# This script is designed to backup a running instance of the GOG version of Creatures2.
# This script requires Creatures2 to be running to perform the backup. This is designed
# for wolf runs.

# This will create a copy of the working directory, create a zip of the directory copy,
# then delete the copy. You cannot zip files in PS currently in use which is why it
# creates a copy of the working directory. 

# It will create a zip file of the date and time example: 02_21_2021 11_03.zip
# This is done so you have the option of ging back to whatever point in time you wish.

# I used this in conjunction with a scheduled task that runs at 11am and 11pm each day.
# The $dest_dir variable should be updated to point to the DIRECTORY you want the
# working directory copy and final ZIP file to exist. 

# The start directory is the default location that GOG's C2 kees its working files.

$start_dir = "C:\Users\$env:UserName\Documents\Creatures\Creatures 2"
$dest_dir = "E:\Creatures2_BACKUPS"

$cur_date = Get-Date -UFormat "%m_%d_%Y %R"
$cur_date = $cur_date.Replace(":","_")
$dest_dir_date = $dest_dir + '\' + $cur_date
$is_C2_running = Get-Process -Name creatures2 -ErrorAction SilentlyContinue

 
if ($is_C2_running){
    try{
        mkdir $dest_dir_date
    }catch{}

    Copy-Item -Path "C:\Users\Admin\Documents\Creatures\Creatures 2\*" -Destination $dest_dir_date -Recurse

    Compress-Archive -Path $dest_dir_date -DestinationPath "$dest_dir\$cur_date.zip"
    Remove-Item $dest_dir_date -Recurse
}