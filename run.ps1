
function patch($__file, $__find, $__to)
{
    # $find = ($__find -split ' ' | ForEach-Object {[char][byte]"0x$_"}) -join ''
    # $to = ($__to -split ' ' | ForEach-Object {[char][byte]"0x$_"}) -join ''
    [Byte[]] $find = $__find -split ' ' | ForEach-Object {[byte]"0x$_"}
    [Byte[]] $to = $__to -split ' ' | ForEach-Object {[byte]"0x$_"}
    # $to = [Byte[]](0x0F,0xB6,0x41,0x08,0xb0,0x01,0x74,0x0A,0x3C,0x07)

    [Byte[]] $file = [System.Io.File]::ReadAllBytes( $__file )

    $position = 0
    for ($i = 0; $i -lt ($file.length - $find.length); $i++)
    {
        for ($ii = 0; $ii -lt $find.length; $ii++)
        {
            if($file[$i+$ii] -ne $find[$ii])
            {
                break
            }
        }
        if ($ii -eq $find.length)
        {
            $position = $i
            
            $fileStream = [System.IO.File]::Open($__file, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite)
            $binaryWriter = New-Object System.IO.BinaryWriter($fileStream)
            $binaryWriter.BaseStream.Position = $position;
            $binaryWriter.Write($to)
            $fileStream.Close()
        }
    }

    if ( $position -ne 0 )
    {
        ( Get-FileHash "$__file" -Algorithm MD5 ).Hash > "$__file.patched.md5"
        echo "Patch succeeded."
    }
    else
    {
        echo "Patch faild."
    }
}

function run($__tab, $__file, $__find, $__to)
{
    if ( Test-Path "$__file" -PathType Leaf )
    {
        echo "Found and patching $__tab ..."
        if ( ( ! ( Test-Path "$__file.bak" -PathType Leaf ) ) -or ( ! ( Test-Path "$__file.patched.md5" -PathType Leaf ) ) -or ( ( cat "$__file.patched.md5" ) -ne ( Get-FileHash "$__file" -Algorithm MD5 ).Hash ) )
        {
            mv "$__file" "$__file.bak"
            cp "$__file.bak" "$__file"
            echo "Backup succeeded."
            patch "$__file" "$__find" "$__to"
        }
        else
        {
            echo "Already patched, skipped."
        }
    }
}

function _Ps()
{
    run `
        'Ps' `
        "C:\Program Files\Adobe\Adobe Photoshop 2020\Photoshop.exe" `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Lr()
{
    run `
        'Lr' `
        "C:\Program Files\Adobe\Adobe Lightroom Classic\Lightroom.exe" `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Ai()
{
    run `
        'Ai' `
        'C:\Program Files\Adobe\Adobe Illustrator 2020\Support Files\Contents\Windows\Illustrator.exe' `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Id()
{
    run `
        'Id' `
        'C:\Program Files\Adobe\Adobe InDesign 2020\Public.dll' `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Ic()
{
    run `
        'Ic' `
        'C:\Program Files\Adobe\Adobe InCopy 2020\Public.dll' `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Au()
{
    run `
        'Au' `
        'C:\Program Files\Adobe\Adobe Audition 2020\AuUI.dll' `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 32 C0" `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 B0 01"
}

function _Pr()
{
    run `
        'Pr' `
        'C:\Program Files\Adobe\Adobe Premiere Pro 2020\Registration.dll' `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 32 C0" `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 B0 01"
}

function _Pl()
{
    run `
        'Pl' `
        'C:\Program Files\Adobe\Adobe Prelude 2020\Registration.dll' `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 32 C0" `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 B0 01"
}

function _Ch()
{
    run `
        'Ch' `
        'C:\Program Files\Adobe\Adobe Character Animator 2020\Support Files\Character Animator.exe' `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 32 C0" `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 B0 01"
}

function _Ae()
{
    run `
        'Ae' `
        'C:\Program Files\Adobe\Adobe After Effects 2020\Support Files\AfterFXLib.dll' `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 32 C0" `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 B0 01"
}

function _Me()
{
    run `
        'Me' `
        'C:\Program Files\Adobe\Adobe Media Encoder 2020\Adobe Media Encoder.exe' `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 32 C0" `
        "48 8B 48 08 48 8B 44 24 60 48 39 48 08 75 0E 8B 44 24 48 39 44 24 58 75 04 B0 01 EB 02 B0 01"
}

function _Br()
{
    run `
        'Br' `
        'C:\Program Files\Adobe\Adobe Bridge 2020\Bridge.exe' `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _An()
{
    run `
        'An' `
        'C:\Program Files\Adobe\Adobe Animate 2020\Animate.exe' `
        "0F B6 41 08 84 C0 74 0A 3C 07" `
        "0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Dw()
{
    run `
        'Dw' `
        'C:\Program Files\Adobe\Adobe Dreamweaver 2020\Dreamweaver.exe' `
        "0F B6 41 08 84 C0 0F 84 AB 00 00 00 3C 07" `
        "0F B6 41 08 B0 01 0F 84 AB 00 00 00 3C 07"
}

function _Dn()
{
    run `
        'Dn' `
        'C:\Program Files\Adobe\Adobe Dimension\euclid-core-plugin.pepper' `
        "8B 05 92 C9 C1 02 48 33 C4 48 89 85 A8 00 00 00 49 8B F8 4C 8B FA 4C 8B E1 0F B6 41 08 84 C0 74 0A 3C 07" `
        "8B 05 92 C9 C1 02 48 33 C4 48 89 85 A8 00 00 00 49 8B F8 4C 8B FA 4C 8B E1 0F B6 41 08 B0 01 74 0A 3C 07"
}

function _Acrobat()
{
    run `
        'Acrobat' `
        'C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll' `
        "8A 43 08 84 C0 74 0A 3C 07" `
        "8A 43 08 B0 01 74 0A 3C 07"
}

_Ps
_Lr
_Ai
_Id
_Ic
_Au
_Pr
_Pl
_Ch
_Ae
_Me
_Br
_An
_Dw
_Dn
_Acrobat
