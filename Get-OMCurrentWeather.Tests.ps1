BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Get-OMCurrentWeather" {
    It "Returns expected output" {
        Get-OMCurrentWeather | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
