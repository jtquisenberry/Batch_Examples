# To get the PID of the process (this will give you the first occurrence if multiple matches)
#$proc_pid = (get-process "slack").Id[0]

$username = "the_user"

$i = 1
$number = 480

do
{
	
	$myArray = @()
	$namesArray = @()
	$pathArray = @()
	#$procs = (get-wmiObject Win32_Process -Filter "name='calc.exe'")
	$procs = (get-wmiObject Win32_Process -Filter("name='calc.exe' or name='winmine.exe' or name='sol.exe'"))
	#$procs = (get-wmiObject Win32_Process -Filter("name='calc.exe'"))
	if ($procs.GetType().BaseType.Name -eq "Array")
	{
		for ($k = 0; $k -lt $procs.length; $k++)
		{
			$user = $procs[$k].GetOwner().User
			if($user -eq $username)
			{
				$pidx = $procs[$k].handle
				$proc_name = $procs[$k].name
				$myArray += $pidx
				$namesArray += $proc_name
				
			}
		}
	}
	Else
	{
		
		$user = $procs.GetOwner().User
		if($user -eq $username)
		{
			$pidx = $procs.handle
			$proc_name = $procs.name
			$myArray += $pidx
			$namesArray += $proc_name
		}	
	}
	
	Write-Host $myArray
	Write-Host $namesArray
	
	
	#$myArray = @(41932, 24500, 20500, 35268)

	For ($j=0; $j -lt $myArray.length; $j++)
	{
		$proc_pid = $myArray[$j]
		Write-Host $proc_pid
		
		$proc_name = $namesArray[$j]
		$prod_percentage_cpu = 0
		$Timestamp = 0
		
		#Write-Host $proc_pid

		$proc_path3 = ""
		# To match the CPU usage to for example Process Explorer you need to divide by the number of cores
		$cpu_cores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
		Write-Host "CPU Cores"$cpu_cores
		$proc_path_basic = (Get-Counter "\Processor(_Total)\% Processor Time").CounterSamples
		$proc_path_basic = (Get-Counter "\Process(*)\ID Process").CounterSamples
		For($m=0; $m -lt $proc_path_basic.length; $m++)
		{
			#Write-Host $proc_path_basic[$m].CookedValue
			$retrieved_pid = $proc_path_basic[$m].CookedValue
			#Write-Host $retrieved_pid
			
			#Write-Host $proc_path_basic[$m].Path
			#Write-Host $proc_pid", "$retrieved_pid
			If($proc_pid -eq $retrieved_pid)
			{
				
				$proc_path3 = $proc_path_basic[$m].Path
			}
			
			
		}
		
		
		
		$proc_path4 = $proc_path3 -replace "\\id process","\% Processor Time"
		Write-Host "proc_path4 "$proc_path4
		
		#Write-Host $proc_path_basic


		# This is to find the exact counter path, as you might have multiple processes with the same name
		#$proc_path = ((Get-Counter "\Process(*)\ID Process").CounterSamples | ? {$_.RawValue -eq $proc_pid}).Path
		#$proc_path = ((Get-Counter "\Process(*)\ID Process").CounterSamples | ? {$_.CookedValue -eq $proc_pid}).Path
		#Write-Host $proc_path

		#$proc_path2 = $proc_path -replace "\\id process","\% Processor Time"
		#Write-Host $proc_path2

		#Write-Host 


		# We now get the CPU percentage
		#$Data = Get-Counter $proc_path2
		$Data = Get-Counter $proc_path4



		$Cpu_Time = $Data.CounterSamples[0].CookedValue
		Write-Host "CPU Time "$Cpu_Time
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
			$proc_name = ""
		}
		
		#Write-Host $prod_percentage_cpu
		Write-Host $i","$proc_pid","$proc_name","$prod_percentage_cpu","$Timestamp
		Add-Content -Value $i","$proc_pid","$proc_name","$prod_percentage_cpu","$Timestamp -Path E:\test.txt
		
	}
	
	$i++
	$myArray = @()
	$namesArray = @()
	Start-Sleep 15
}
 while ($i -le $number)