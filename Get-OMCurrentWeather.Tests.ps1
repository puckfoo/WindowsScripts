

<#

https://jeffhicks.substack.com/p/creating-a-powershell-weather-command

https://open-meteo.com/



#Example API call using curl
curl "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m


#Roughly same command but using powershell Invoke-RestMethod
$r = Invoke-RestMethod "https://api.open-meteo.com/v1/forecast?latitude=38.917&longitude=-94.0695&hourly=temperature_2m,relativehumidity_2m,apparent_temperature,precipitation_probability,rain,showers&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch&timezone=America%2FChicago&past_days=1&forecast_days=14"




Get-PSRepository -Name PSGallery

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Find-Command -Repository PSGallery -Name Get-CurrentWeather


Get-Module Pester -ListAvailable


Install-Module Pester -force  #If you get a security error run the one below.


Install-Module Pester -force -SkipPublisherCheck -Scope AllUsers


#>


New-Fixture -name Get-OMCurrentWeather    #This will create the file Get-OMCurrentWeather.ps1

function Get-OMCurrentWeather {
    throw [NotImplementedException]'Get-OMCurrentWeather is not implemented.'
}

Get-OMCurrentWeather




BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-OMCurrentWeather" {
    It "Returns expected output" {
        Get-OMCurrentWeather | Should -Be "YOUR_EXPECTED_VALUE"
    }
}



$r = Invoke-RestMethod 'https://api.open-meteo.com/v1/forecast?latitude=38.917&longitude=-94.0695&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum&temperature_unit=fahrenheit&precipitation_unit=inch&forecast_days=1&timezone=America%2FChicago'
[PSCustomObject]@{
    Location        = 'Overland Park, KS.'
    Date            = $r.daily.time[0]
    WeatherCode     = $r.daily.weathercode[0]
    TemperatureLow  = $r.daily.temperature_2m_min[0]
    TemperatureHigh = $r.daily.temperature_2m_max[0]
    Precipitation   = $r.daily.precipitation_sum[0]
    Sunrise         = $r.daily.sunrise[0] -as [datetime]
    Sunset          = $r.daily.sunset[0] -as [datetime]
}


BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-OMCurrentWeather" {
    It "Returns expected output" {
        Get-OMCurrentWeather | Should -Be "YOUR_EXPECTED_VALUE"
    }
}



Describe "Get-OMCurrentWeather" {
    Context "Command Design" {
        It "design assertion" {
            #TBD
        }
    } #context Command Design
    Context "Command Execution" {
        It "Returns expected output" {
            Get-OMCurrentWeather | Should -Be "YOUR_EXPECTED_VALUE"
        }
    } #context Command Execution
} #