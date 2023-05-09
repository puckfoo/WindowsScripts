<#
Error and Exception Terminology

1. Exception
2. Throw and Catch
3. The Call Stack
4. Terminating and Non-terminating Errors
5. Swallowing an Exception


Error - Error are returned as PowerShell Objects.  Provide terminating and non-terminating errors.
Exceptions - Exceptions are created when normal error handling cannot handle the issue.  Exceptions are typically non-terminating.

Terminating Errors - The error generated by the script, functions, or commands, stop or halts the execution.
Non-Terminating Errors - Generated by internal commands.  Normally automatically handled so the error doesn't terminate the execution of the pipeline.

Error Handling Approaches
1. Throw - Throw the exception and possibly stop or break the script
2. Write-Error - Write the message out
3. ErrorAction
4. Try/Catch
5. Try/Finally
6. Try/Catch/Finally
#>

#Generate and Error using "Throw"
function New-Error {
    Throw "This is an Error"
}


#Use Write-Error with "-ErrorAction" to Generate Error
Write-Error -Message "This is an Error"  -ErrorAction Stop


#Generate an Error using Throw
function  New-Error {
    $number = 0;
    for ($i = 1; $i -le 10; $i++) {
        Write-Host "The current number is: $i" 
        Throw "This in an Error"
        $number += $i

    }
}

New-Error


#Generate Error using "-ErrorAction"
New-Error -ErrorAction stop


<#
    The -ErrorAction Parameter Values

    Contine - Log's error, then displays error to console, and continues processing
    Stop - Log's error, then displays error to console, and then terminates
    SilentlyContinue - Log's error, does not display error, and continues processing
    Ignore - Does not log error.  Does not display error, and continues processing


#>


function  New-Error {
    $number = 0;
    for ($i = 1; $i -le 10; $i++) {
        Write-Host "The current number is: $i"
        Write-Error -Message "Error" -ErrorAction SilentlyContinue #continues regardless of error
        $number += $i
    }
}

New-Error




function  New-Error {
    $number = 0;
    for ($i = 1; $i -le 10; $i++) {
        Write-Host "The current number is: $i"
        Write-Error -Message "Error" -ErrorAction Suspend  #The suspend action isn't usable here.
        $number += $i
    }
}

New-Error



function  New-Error {
    $number = 0;
    for ($i = 1; $i -le 10; $i++) {
        Write-Host "The current number is: $i"
        Write-Error -Message "Error" -ErrorAction Stop  #Stops after the first error
        $number += $i
    }
}

New-Error



try {
    New-Message
}finally {
    Write-Output "Continue Execution"

}



try {
    New-Message
} catch {
    Write-Output "An Exeption was Generated"
} finally {
    Write-Output "Continue Execution"
}

<#
Typed Exception Handling

1. Exceptions have a type. You can specify the type of exception you need to catch
2. Catch multiple exception types with a single try/catch statement

#>


$path = "C:\Users\Richard Holland\Documents\Code"

try{
    New-Error -Path $path -ErrorAction Stop
}
catch [System.IO.DirectoryNotFoundException],[System.IO.FileNotFoundException]{
    Write-Output "The Path or File was not found: [$path]"
}
catch [System.IO.IOException] {
    Write-Output "Error within the selected file: [$path]"
}


function New-Error {
    Throw "New Error"
}

New-Error


Try{
    New-Error   
}
catch{
    Write-Host "An Error Occured"
}


function New-Error {
    Throw [System.IO.FileNotFoundException] "File not found"
}

New-Error


try {
    {New-Error}
}
catch{
    Write-Host $_ 
    $_.GetType().FullName
    $_.Exception
    $_.Exception.GetType().FullName
    $_.Exception.Message
}




try {
    New-Error
}
catch{
    [System.IO.FileNotFoundException]{
        Write-Host "Catch01"
    }
catch [System.IO.IOException] {
    Write-Host "Catch02"
}