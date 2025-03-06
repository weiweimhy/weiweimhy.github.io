oh-my-posh init pwsh --config D:\Applications\Scoop\apps\oh-my-posh\theme\powerlevel10k_lean.omp.json | Invoke-Expression
Import-Module posh-git
Import-Module Terminal-Icons
Set-PSReadLineOption -PredictionSource History 
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
cls

function _Print_Info($msg)
{
	''
	Write-Host $msg -fore Green
	''
}

function _Print_Warn($msg)
{
	''
	Write-Host $msg -fore Yellow
	''
}

function _Print_Error($msg)
{
	''
	Write-Host $msg -fore Red
	''
}

function Proxy-On([string]$proxy)
{
	if ($proxy -eq '')
	{
		$proxy = 'http://127.0.0.1:1080'
	}
	$env:http_proxy=$proxy
	$env:https_proxy=$proxy
	_Print_Info('proxy on', $proxy)
}

function Proxy-Off()
{
	$env:http_proxy=''
	$env:https_proxy=''
	_Print_Info('proxy off')
}

function Open([string]$path) 
{
	if ($path -eq '')
	{
		_Print_Warn('path empty~')
		return
	}
	if ($path -eq '.')
	{
		$current = (Get-Location).Path
		explorer $current
	}
	else
	{
		if ((Test-Path -Path $path))
		{
			explorer $path
		}
		else 
		{
			_Print_Error('file not exists!')
		}
	}
}

function Set-Env([string]$key, [string]$v, [string]$scope)
{
	if ($key -eq '')
	{
		_Print_Warn('env key can`t null~')
		return
	}
	if (-not (Test-Path env:$key))
	{
		Set-Item -Path Env:$key -Value $v
		if ($scope -eq 'u')
		{
			[Environment]::SetEnvironmentVariable($key, $v, 'User')
		}
		elseif ($scope -eq 'm')
		{
			_Print_Warn('not support, requires admin privileges, eg:')
			_Print_Info("sudo [Environment]::SetEnvironmentVariable('key', 'value', 'Machine')")
		}
	}
	else 
	{
		_Print_Warn('evn already exists, ' + $key + '=' + (Get-Item -Path Env:$key).Value)
	}
}

function Remove-Env($key, [string]$scope)
{
	if ($key -eq '')
	{
		_Print_Warn('env key can`t null~')
		return
	} 
	if (Test-Path env:$key)
	{
		Remove-Item -Path Env:$key
		if ($scope -eq 'u')
		{
			[Environment]::SetEnvironmentVariable($key, $null, 'User')
		}
		elseif ($scope -eq 'm')
		{
			_Print_Warn('not support, requires admin privileges, eg:')
			_Print_Info("sudo [Environment]::SetEnvironmentVariable('key', '$null', 'Machine')")
		}
	}
}

function Open-Tools()
{
	if (Test-Path env:MYTOOLS)
	{
		$current = (Get-Location).Path
		cd $env:MYTOOLS
		Open .
		cd $current
	}
	else 
	{
		_Print_Warn('env mytools not exists~')
	}
}

if ((Get-Location).Path -eq 'D:\Tools')
{
	cd '~'
} 