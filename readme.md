# CC patch

## Work

mac is work and win not work

## Run

### Mac

* Via curl

  ```curl -fsSL https://raw.githubusercontent.com/YJBeetle/ccpatch/generic/run.py | sudo python3```

* Via wget

  ```wget https://raw.githubusercontent.com/YJBeetle/ccpatch/generic/run.sh -O - | sudo python3```

### Win

* Via PowerShell (Administrator)

  ```powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/YJBeetle/ccpatch/2021/run.ps1')"```

## Restore

### Mac

* Via curl

  ```curl -fsSL https://raw.githubusercontent.com/YJBeetle/ccpatch/generic/run.py | sudo python3 restore```

* Via wget

  ```wget https://raw.githubusercontent.com/YJBeetle/ccpatch/generic/run.sh -O - | sudo python3 restore```

### Win

* Via PowerShell (Administrator)

  ```powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/YJBeetle/ccpatch/2021/revoke.ps1')"```
