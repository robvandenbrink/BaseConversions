[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  

$Form = New-Object System.Windows.Forms.Form    
$Form.Size = New-Object System.Drawing.Size(1200,1000)  

############################################## Start functions

function SrcBase {
$NL = "`r`n"
$TAB="`t"
if ($RadioButton1.Checked -eq $true) {$base=10}
if ($RadioButton2.Checked -eq $true) {$base=16}
if ($RadioButton3.Checked -eq $true) {$base=2}
if ($RadioButton4.Checked -eq $true) {$base="A"}

$InputValue = $args[0]
$outputBox.Text = ""

if ($base -eq 10 ){
    $decnum = $InputValue
    $binnum = [convert]::tostring($decnum,2)
    $hexnum = [convert]::tostring($decnum,16)
    $result = $NL+"DEC (0d)"+$TAB+ $decnum+$NL+"BIN (0b)"+$TAB + $binnum +$NL+"HEX (0x)"+$TAB + $hexnum
    if ($decnum -le 65535) { 
        $asciival = [char][int]$decnum
        $result += $NL+"ASCII"+$TAB+$TAB+$asciival
        }
    } 
elseif ($base -eq 16) {
    $hexnum = $InputValue
    $decnum = [Convert]::ToString("0x"+$hexnum, 10)
    $binnum = [convert]::tostring($decnum,2)
    $result = $NL+"HEX (0x)"+$TAB+$hexnum+$NL +"BIN (0b)"+$TAB+$binnum+$NL+ "DEC (0d)"+$TAB+$decnum
    if ($decnum -le 65535) { 
        $asciival = [char]$decnum
        $result += $NL+"ASCII"+$TAB+$TAB+$asciival
        } 
    }
elseif ($base -eq 2) {
    $binnum = $InputValue
    $decnum = [convert]::toint32($binnum,2)
    $hexnum = [convert]::tostring($decnum,16)
    $result = $NL+"BIN (0b)"+$TAB + $binnum +$NL+"HEX (0x)"+$TAB + $hexnum+$NL+ "DEC (0d)"+$TAB+ $decnum
    if ($decnum -le 65535) { 
        $asciival = [char][int]$decnum
        $result += $NL+"ASCII"+$TAB+$TAB+$asciival
        } 
    }

elseif ($base -eq "A") {
    $hnum = @()
    $bnum = @()
    $asciival = $InputValue
    $list = [int[]][char[]]$inputvalue
    for ($i=0 ; $i -lt $asciival.length ; $i++) {
       $d = $list[$i]
       $h = [convert]::tostring($d,16)
       $b = [convert]::tostring($d,2)
       $hnum += $h
       $bnum += $b
       }
    $result = $NL+"ASCII`t`t"+$asciival
    $result += $NL+"DEC (0d)`t"+ ($list -join ' ' )
    $result += $NL+"HEX (0x)`t"+ ($hnum -join ' ' )
    $result += $NL+"BIN (0b)`t"+ ($bnum -join ' ' )
    }

# display the result
$outputBox.AppendText($result)

# clear the input box
$TextInputBox.Text = ""

# set the focus back to the input box
$TextInputBox.focus()

} 

############################################## end functions

############################################## group box

$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(350,20) 
$groupBox.size = New-Object System.Drawing.Size(500,400) 
$groupBox.text = "Source Base" 
$groupbox.font = New-Object System.Drawing.Font("Lucida Console",16,[System.Drawing.FontStyle]::Regular)
$Form.Controls.Add($groupBox) 

############################################## end group box

############################################## radio buttons

$RadioButton1 = New-Object System.Windows.Forms.RadioButton 
$RadioButton1.Location = new-object System.Drawing.Point(15,50) 
$RadioButton1.size = New-Object System.Drawing.Size(800,70) 
$RadioButton1.Checked = $true 
$RadioButton1.Text = "Decimal (0d)" 
$groupBox.Controls.Add($RadioButton1) 

$RadioButton2 = New-Object System.Windows.Forms.RadioButton
$RadioButton2.Location = new-object System.Drawing.Point(15,130)
$RadioButton2.size = New-Object System.Drawing.Size(800,70)
$RadioButton2.Text = "Hexadecimal (0x)"
$groupBox.Controls.Add($RadioButton2)

$RadioButton3 = New-Object System.Windows.Forms.RadioButton
$RadioButton3.Location = new-object System.Drawing.Point(15,210)
$RadioButton3.size = New-Object System.Drawing.Size(800,70)
$RadioButton3.Text = "Binary (0d)"
$groupBox.Controls.Add($RadioButton3)

$RadioButton4 = New-Object System.Windows.Forms.RadioButton
$RadioButton4.Location = new-object System.Drawing.Point(15,290)
$RadioButton4.size = New-Object System.Drawing.Size(800,70)
$RadioButton4.Text = "ASCII"
$groupBox.Controls.Add($RadioButton4)

############################################## end radio buttons

############################################## text box - INPUT STRING

$TextInputBox = New-Object System.Windows.Forms.TextBox
$TextInputBox.Location = New-Object System.Drawing.Size(20,50) 
$TextInputBox.Size = New-Object System.Drawing.Size(300,150) 
$TextInputBox.Height = 150 
$TextInputBox.font = New-Object System.Drawing.Font("Lucida Console",32,[System.Drawing.FontStyle]::Regular)

$Form.Controls.Add($TextInputBox) 


############################################## end text box - INPUT

##############################################  text field - OUTPUT

$outputBox = New-Object System.Windows.Forms.TextBox 
$outputBox.Location = New-Object System.Drawing.Size(100,475) 
$outputBox.Size = New-Object System.Drawing.Size(1000,300) 
$outputBox.MultiLine = $True 
$outputBox.Font = New-Object System.Drawing.Font("Lucida Console",32,[System.Drawing.FontStyle]::Regular)

$Form.Controls.Add($outputBox) 

############################################## end text field - OUTPUT

############################################## GO button

$Button = New-Object System.Windows.Forms.Button 
$Button.Location = New-Object System.Drawing.Size(100,150) 
$Button.Size = New-Object System.Drawing.Size(220,70) 
$Button.Font = New-Object System.Drawing.Font("Lucida Console",16,[System.Drawing.FontStyle]::Regular)
$Button.Text = "CONVERT" 
$Button.Add_Click({SrcBase $TextInputBox.Text}) 
$Form.Controls.Add($Button) 

############################################## end GO button

############################################## 
# Display the form
# Note that the text input box is the focus
##############################################
$Form.Add_Shown({$Form.Activate();$TextInputBox.focus()})
[void] $Form.ShowDialog()