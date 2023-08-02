


$r = Invoke-RestMethod 'https://api.open-meteo.com/v1/forecast?latitude=38.91&longitude=-94.06&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,precipitation_sum&temperature_unit=fahrenheit&precipitation_unit=inch&forecast_days=1&timezone=America%2FChicago'
[PSCustomObject]@{
    Location        = 'Overland Park,KS'
    Date            = $r.daily.time[0]
    WeatherCode     = $r.daily.weathercode[0]
    TemperatureLow  = $r.daily.temperature_2m_min[0]
    TemperatureHigh = $r.daily.temperature_2m_max[0]
    Precipitation   = $r.daily.precipitation_sum[0]
    Sunrise         = $r.daily.sunrise[0] -as [datetime]
    Sunset          = $r.daily.sunset[0] -as [datetime]
}




function Get-OMCurrentWeather {
    throw [NotImplementedException]'Get-OMCurrentWeather is not implemented.'
}
