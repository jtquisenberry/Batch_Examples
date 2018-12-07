# To get the PID of the process (this will give you the first occurrence if multiple matches)
#$proc_pid = (get-process "slack").Id[0]

$i = 1
$number = 240




do
{
	$myArray = @(41932, 24500, 20500, 35268)

	For ($j=0; $j -lt $myArray.length; $j++)
	{
		$proc_pid = $myArray[$j]
		Write-Host $proc_pid
		
		$prod_percentage_cpu = 0
		$Timestamp = 0
		
		#Write-Host $proc_pid


		# To match the CPU usage to for example Process Explorer you need to divide by the number of cores
		$cpu_cores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
		#Write-Host $cpu_cores


		# This is to find the exact counter path, as you might have multiple processes with the same name
		$proc_path = ((Get-Counter "\Process(*)\ID Process").CounterSamples | ? {$_.RawValue -eq $proc_pid}).Path
		#Write-Host $proc_path

		$proc_path2 = $proc_path -replace "\\id process","\% Processor Time"
		#Write-Host $proc_path2

		#Write-Host 


		# We now get the CPU percentage
		$Data = Get-Counter $proc_path2



		$Cpu_Time = $Data.CounterSamples[0].CookedValue
		$Timestamp = $Data.CounterSamples[0].Timestamp
		#Write-Host $Cpu_Time
		#$Data.CounterSamples | Format-List -Property *


		#Write-Host ((Get-Counter -Counter $proc_path2).CounterSamples.Path)
		#
		#$prod_percentage_cpu = (((Get-Counter -Counter ($proc_path -replace "\\id process","\% Processor Time")).CounterSamples.CookedValue))
		$prod_percentage_cpu = [math]::Round(($Cpu_Time / $cpu_cores),2) 
		
		if ($Timestamp -eq 0)
		{
			$proc_pid = 0
		}
		
		#Write-Host $prod_percentage_cpu
		Write-Host $i","$proc_pid","$prod_percentage_cpu","$Timestamp
		Add-Content -Value $i","$proc_pid","$prod_percentage_cpu","$Timestamp -Path E:\test.txt
		
	}
	
	$i++
	Start-Sleep 15
}
 while ($i -le $number)